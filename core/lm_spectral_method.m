% LIBMUSIC
% Copyright (C) 2022, Piotr Gregor piotr@dataandsignal.com
%
% lm_spectral_method
% 
% Spectral method implementation.
%
% This class provides support for MUSIC, Pisarenko, EV, Minimum Norm
% spectral methods which working principle is to decompose a noisy signal
% space Vy (spanned by eigenvalues of autocorrelation matrix Ry) into pure signal
% subspace Vx (spanned by selected P2 eigenvectors of Ry, when eigenvalues
% are sorted in decreasing order) and noise subspace Ve.
% This class provides then means to compute PSD and amplitude estimates.
% It has also support for finding maxima in PSD by a peak finding
% and by eigenfilter method (eigenrooting).
%
% Basic usage
%   method = spectral_method('music', M, 2*P);
%   [Vy,Vx,Ve,A,Ry] = method.process(y)
%   [X2,d2] = method.psd(method, 1:1:4000, Fs);
%   A = method.single_tone_amplitude();
%   A = method.dual_tone_amplitude();
%   A = method.solve_for_amplitudes([f1],Fs);
%   [peaks, pmu] = method.peaks(fs, Fs);
%   [fs] = method.eigenrooting(Fs,0,0);
% 
% For detailed usage see exmples and tests folders.
%
% date: August 2022


classdef lm_spectral_method < handle
    properties
        kind            % (in) method ('pisarenko', 'music', 'ev', 'mn')
        psd             % (out) pseudospectrum
        subspace_decomposer % handle to core implementation
        M               % autocorrelation order (also max signal space dim)
        P2              % pure signal space dim (must be < M+1)
        Vy              % (out) eigenvectors
        Vx              % (out) pure signal subspace eigenvectors
        Ve              % (out) noise subspace eigenvectors
        A               % (out) eigenvalues
        Ry              % (out) autocorrelation matrix
        y               % (in) samples
        peak_width % when computing another peak, frequencies within
                    % half this range from previous peaks are ignored
        signal_space_dim    % computed pure signal subspace dim
        noise_space_dim     % computed noise subspace dim
    end
    methods
        function m = lm_spectral_method(kind, M, P2)
            m.kind = kind;
            switch kind
                case 'pisarenko'
                    m.psd = @psd_pisarenko;
                case 'music'
                    m.psd = @psd_music;
                case 'ev'
                    m.psd = @psd_ev;
                case 'mn'
                    m.psd = @psd_minimum_norm;
                otherwise
            end
            m.M = M;
            m.P2 = P2;
            m.peak_width = 10; % Default peak width in Hz
            m.signal_space_dim = 0;
            m.noise_space_dim = 0;
            m.subspace_decomposer = lm_spectral_subspace_decomposition(M, P2);
        end

        % Decompose noisy signal space into signal and noise subspaces
        % Return result:
        % Ry - correlation matrix
        % Vy = [Vx Ve] - eigenvectors
        % A - eigenvalues (sorted in descending order)
        % After this returns method's signal_space_dim and noise_space_dim
        % are set to result space dimensions. For Pisarenko noise space dim
        % is truncated to 1.
        function [Vy,Vx,Ve,A,Ry] = process(m, y)
            [Vy,Vx,Ve,A,Ry] = m.subspace_decomposer.decompose(y);
            m.Vy = Vy;
            m.Vx = Vx;
            m.Ve = Ve;
            m.A = A;
            m.Ry = Ry;
            m.y = y;
        end

        function [X2,d2] = psd_pisarenko(m, f, Fs)
            [X2,d2] = psd_music(m, f, Fs); 
        end

        function [X2,d2] = psd_music(m, f, Fs)
            N = length(f(:).');
            X2 = zeros(1, N);
            d2 = zeros(1, N);

            n = size(m.A,2);
            if n <= m.P2
                error("Number of eigenvectors " + n + ...
                    " too short for signal space dimension " ...
                    + m.P2);
            end

            noise_space_dim = n - m.P2;
            switch m.kind
                case 'pisarenko'
                    noise_space_dim = 1;
                otherwise
            end

            e = m.Ve(:, 1:noise_space_dim);

            switch m.kind
                case 'pisarenko'
                    w = [1];
                case 'music'
                    x = ones(1,noise_space_dim);
                    w = diag(x);
                case 'ev'
                    x = diag(m.A);
                    x = x(m.P2+1:m.P2+noise_space_dim);
                    x = 1./x;
                    w = diag(x);
                case 'mn'
                    u1 = zeros(1, m.M+1);
                    u1(1) = 1;
                    a_nom = e*e'*u1';
                    a_denom = u1*e*e'*u1';;
                    a = a_nom / a_denom;
                otherwise
            end

            for i=1:N
                % Compute the distance from steering vector to signal supspace,
                % i.e. projection of steering vector onto noise subspace
                t = (0:(m.M+1)-1).*1/Fs;
                %steering_vector = sin(2*pi*f(i)*t);
                steering_vector = exp(1i*2*pi*f(i)*t);
                switch m.kind
                    case 'mn'
                        d2(i) = abs(steering_vector*(a*(a'*steering_vector.')));
                    otherwise
                        d2(i) = abs(steering_vector*(e*w*(e'*steering_vector.')));
                end
                pmu(i) = 1/d2(i);
                X2(i) = pmu(i);
            end
        end
        function [X2,d2] = psd_ev(m, f, Fs)
            [X2,d2] = psd_music(m, f, Fs);
        end
        function [X2,d2] = psd_minimum_norm(m, f, Fs)
            [X2,d2] = psd_music(m, f, Fs);
        end

        function [A] = amplitude(m)
            A = 0;
            switch m.P2
                case 2
                    A = single_component_amplitude(m);
                case 4
                    A = double_components_amplitude(m,f1,f2,Fs);
                otherwise
                    fprintf("Oops, not implemented\n");
            end
        end

        function [A] = single_tone_amplitude(m)
            corr_av = sum(diag(m.Ry))/(m.M+1);
            eigenvals = diag(m.A);
            noise_var_est = sum(eigenvals(m.P2+1:end))/((m.M+1)-m.P2);
            A = sqrt(2*(corr_av-noise_var_est));
        end

        function [A] = dual_tone_amplitude(m, f1, f2, Fs)
            r0av = sum(diag(m.Ry))/(m.M+1);
            r1av = sum(diag(m.Ry,1))/(m.M+1-1);
            eigenvals = diag(m.A);
            noise_var_est = sum(eigenvals(m.P2+1:end))/((m.M+1)-m.P2);
            c1 = cos(2*pi*f1*1/Fs);
            c2 = cos(2*pi*f2*1/Fs);
            P1 = (r1av-r0av*c2)/(c1-c2);
            P2 = r0av - P1;

            A1 = sqrt(2*P1);
            A2 = sqrt(2*P2);

            A = [A1 A2]; 
        end

        function [A] = solve_for_amplitudes(m, fs, Fs)

            fs = fs(:)';
            N = length(fs);
            eigenvals = diag(m.A);
            noise_var_est = sum(eigenvals(m.P2+1:end))/((m.M+1)-m.P2);

            f = [fs -fs];
            t = (1:m.M+1).*1/Fs;
            for i=1:m.P2
                steering_vector = exp(1i*2*pi*f(i)*t);
                for j=1:m.P2
                    v = m.Vx(:,j);
                    v = v /(norm(v));
                    M(j,i) = abs(steering_vector*v).^2;
                end
            end
            lambdas = eigenvals(1:m.P2);
            B = (lambdas - noise_var_est);
            P = abs(pinv(M) * B);
            %P = linsolve(M,B);

            A = 2*sqrt(P(1:N));
        end

        % Search for another peak.
        %
        % @f2ignore     Frequencies of previous peaks that should be ignored
        %               in this search
        % @bw2ignore    Frequency range that should be ignored around
        %               each of previous peaks, i.e. for each of previous
        %               peaks P ignored range is (P-bw2ignore, P+bw2ignore)
        function [peak, peak_pmu] = peak(m, f, Fs, f2ignore, bw2ignore)
            N = length(f(:).');
            [X2,d2] = m.psd(m, f, Fs);
            max_pmu(1) = 0;
            max_pmu_freq(1) = 1;

            for u=1:N
                ignore = 0;
                peaks_n = length(f2ignore);
                if peaks_n > 0
                    for k=1:peaks_n
                        if abs(f2ignore(k)-f(u)) < bw2ignore
                            ignore = 1;
                            break;
                        end
                    end
                    if ignore
                        continue;
                    end
                end
                pmu_u = X2(u);
                if max_pmu(1) < pmu_u
                    max_pmu = circshift(max_pmu,1);
                    max_pmu_freq = circshift(max_pmu_freq,1);
                    max_pmu(1) = pmu_u;
                    max_pmu_freq(1) = f(u);
                end
            end
            peak = max_pmu_freq(1);
            peak_pmu = max_pmu(1);
        end

        % Search for peaks.
        %
        % @freqs        frequencies to evaluate
        % @Fs           sampling rate
        % @peakWidth    Frequency range that should be ignored around
        %               each of previous peaks, i.e. for each of previous
        %               peaks P ignored range is (P-peakWidth/2, P+peakWidth/2)
        function [peaks, peaks_pmu] = peaks(m, freqs, Fs, peakWidth)
            peaks_n = m.P2/2;
            if peakWidth > 0
                m.peak_width = peakWidth;
            end
            peaks = [];
            peaks_pmu = [];
            for i=1:peaks_n
                [peaks(i), peaks_pmu(i)] = peak(m, freqs, Fs, peaks, m.peak_width/2);
            end
    
        end

        function [r] = plot_roots(m, p)

            if 1 > length(p)
                fprintf("Err: empty vector\n")
                return
            end
            r = roots(p);
            angle(r);
            figure();
            plot(real(r),imag(r),'.','MarkerSize',50,'LineWidth',10,'DisplayName','Roots')
            axis equal
            grid on
            t = linspace(0,2*pi,100);
            hold on
            plot(cos(t),sin(t),'r-','DisplayName','Unit circle')
            hold off
            set(findall(gcf,'-property','FontSize'),'FontSize',36);
        end

        % Estimate freq by rooting noise eigenvectors
        function [fs_] = eigenrooting(m, Fs, plot, print)
            N = size(m.Ve,2);
            fs_ = [];

            for i=1:N
                e = m.Ve(:,i);
                Zet = tf(e',1);
                if print
                   fprintf("Eigenwektor:\n");
                    e
                    Zet
                end
                if (plot)
                    rts = plot_roots(m, e);
                else
                    rts = roots(e);
                end

                rts = rts(:);
                sz = size(rts,1);
                z = zeros(sz,1);
                fs = [z rts z];
                for i=1:sz
                    r = fs(i,2);
                    fs(i,1) = abs(1-abs(r));
                    fs(i,3) = (angle(r)/pi)*Fs/2;
                end
                if print
                    fprintf("Pierwiastki (odległość, z, f):\n");
                    fs(:,1)
                    fs(:,2)
                    fs(:,3)
                end

                fs_ = [fs_;fs];
            end
            fs_ = sortrows(fs_);
            if print
                fprintf("Wszystkie pierwiastki:\n");
                fs_
            end
            indices = find(fs_(:,3) < 0);
            fs_(indices, :) = [];
        end

        function plot3D(m, y2, y3, y4)
            % Plot signal space
            n = size(m.Vx, 2);
            for i=1:n
                l = "wektor własny przestrzeni sygnału Vx[" + num2str(i) + ']';
                switch i
                    case 1
                        quiver3(0,0,0,m.Vx(1,i)',m.Vx(2,1),m.Vx(3,i),0,'DisplayName',l,'Color','green',LineWidth=6);
                    case 3
                        quiver3(0,0,0,m.Vx(1,i)',m.Vx(2,1),m.Vx(3,i),0,'DisplayName',l,'Color','blue',LineWidth=6);
                    case 2
                        quiver3(0,0,0,m.Vx(1,i)',m.Vx(2,1),m.Vx(3,i),0,'DisplayName',l,'Color','green',LineWidth=3);
                    case 4
                        quiver3(0,0,0,m.Vx(1,i)',m.Vx(2,1),m.Vx(3,i),0,'DisplayName',l,'Color','blue',LineWidth=3);
                end
                hold on
                %quiver3(0,0,0,m.Vx(1,2)',m.Vx(2,2),m.Vx(3,2),0,'DisplayName','wektor własny przestrzeni sygnału Vx[2]','Color','green',LineWidth=3);
            end

            % Plot noise space
            quiver3(0,0,0,m.Ve(1,1)',m.Ve(2,1),m.Ve(3,1),0,'DisplayName','wektor własny przestrzeni szumu Ve','Color','red',LineWidth=2);

            % Plot input points
            scatter3(m.y(1),m.y(2),m.y(3),70,'filled', 'DisplayName','[y[1T] y[2T] y[3T]]','Marker','o','Color','black');
            scatter3(y2(1),y2(2),y2(3),65,'filled', 'DisplayName','[y[2T] y[3T] y[4T]]','Marker','o','Color','black');
            scatter3(y3(1),y3(2),y3(3),70,'filled', 'DisplayName','[y[3T] y[4T] y[5T]]','Marker','o','Color','black');
            scatter3(y4(1),y4(2),y4(3),80,'filled', 'DisplayName','[y[4T] y[5T] y[6T]]','Marker','o','Color','black');

            % Input vector coordinates in noisy signal space
            fprintf("\nWspółrzędne wektora wejściowego y[] w zaszumionej przestrzeni\n");
            y_coords = inv(m.Vy)*(m.y(1:(m.M+1))')

            for i=1:n/2
                % Plot input in base vectors
                k = 2*i - 1;
                v1 = y_coords(1).*m.Vx(:,k); % This is first eigenvector scaled
                v2 = y_coords(2).*m.Vx(:,k+1); % This is second eigenvector scaled
                v = [v1 v2];
                x1 = [v(1,1) 0];
                y1 = [v(2,1) 0];
                z1 = [v(3,1) 0];
                l = "współrzędne y[] w Vx[" + num2str(k) + ']';
                plot3(x1',y1',z1','DisplayName',l,'LineStyle','--',LineWidth=5);
                x2 = [v(1,2) 0];
                y2 = [v(2,2) 0];
                z2 = [v(3,2) 0];
                l = "współrzędne y[] w Vx[" + num2str(k)+1 + ']';
                plot3(x2',y2',z2','DisplayName',l,'LineStyle','--',LineWidth=6);
                % Anchor first vector at the second and plot
                x3 = x1+x2;
                y3 = y1+y2;
                z3 = z1+z2;
                l = "współrzędne y[] w przestrzeni czystego sygnału [Vx[" + num2str(k) + '] Vx['+num2str(k+1)+']]';
                plot3(x3',y3',z3','DisplayName',l,'LineStyle','-.',LineWidth=2);
            end

            xlabel('x[1]')
            ylabel('x[2]')
            zlabel('x[3]')
            set(findall(gcf,'-property','FontSize'),'FontSize',24);
        end

        function add3D(m, y1, y2, y3, y4)

            % Plot input points
            scatter3(y1(1),y1(2),y1(3),50,'DisplayName','[sp[1T] sp[2T] sp[3T]]','MarkerEdgeColor', 'r');
            scatter3(y2(1),y2(2),y2(3),45,'DisplayName','[sp[2T] sp[3T] sp[4T]]','MarkerFaceColor', 'r');
            scatter3(y3(1),y3(2),y3(3),50,'DisplayName','[sp[3T] sp[4T] sp[5T]]','MarkerFaceColor', 'y','MarkerEdgeColor', 'm');
            scatter3(y4(1),y4(2),y4(3),60,'DisplayName','[sp[4T] sp[5T] sp[6T]]','MarkerEdgeColor', 'm');

            % Input vector coordinates in noisy signal space
            fprintf("\nWspółrzędne wektora wejściowego sp[] w zaszumionej przestrzeni\n");
            y_coords = inv(m.Vy)*(y1(1:(m.M+1))')

            % Plot input in base vectors
            v1 = y_coords(1).*m.Vx(:,1); % This is first eigenvector scaled
            v2 = y_coords(2).*m.Vx(:,2); % This is second eigenvector scaled
            v3 = y_coords(3).*m.Ve(:,1); % This is first error eigenvector

            v = [v1 v2];
            x1 = [v(1,1) 0];
            y1 = [v(2,1) 0];
            z1 = [v(3,1) 0];
            plot3(x1',y1',z1','DisplayName','współrzędne sp[] w Vx[1]','LineStyle','-.',LineWidth=3);
            x2 = [v(1,2) 0];
            y2 = [v(2,2) 0];
            z2 = [v(3,2) 0];
            plot3(x2',y2',z2','DisplayName','współrzędne sp[] w Vx[2]','LineStyle','-.',LineWidth=4);

            v = [v1 v2 v3];
            x3 = [v(1,3) 0];
            y3 = [v(2,3) 0];
            z3 = [v(3,3) 0];
            plot3(x3',y3',z3','Color','y','DisplayName','współrzędne sp[] w Ve','LineStyle','-.',LineWidth=8);
            % Anchor first vector at the second and plot
            x3 = x1+x2+x3;
            y3 = y1+y2+y3;
            z3 = z1+z2+z3;
            plot3(x3',y3',z3','DisplayName','współrzędne sp[] w przestrzeni zaszumionego sygnału [Vx[1] Vx[2] Ve]','LineStyle','-.',LineWidth=1);

            set(findall(gcf,'-property','FontSize'),'FontSize',24);
        end
    end
end