% LIBMUSIC
% Copyright (C) 2022, Piotr Gregor piotr@dataandsignal.com
%
% dual_tone_noise
% 
% Test dual tone frequency estimates in noise.
%
% date: August 2022

Fs = 8000;
t = 0:1/Fs:1-1/Fs;
f1 = 697;
f2 = 1209;
Amp = [3 3];

sigma = [10^-8 10^-6 10^-4 10^-3];
x_start = 1;

P = 2;
M_START = 4;
M_END = M_START+6;
N_START = 8;
N_END = N_START+24;
N_RUNS = 1;

X = linspace(M_START, M_END, M_END-M_START+1);
M_SIZE = length(X);
Y = linspace(N_START, N_END, N_END-N_START+1);
N_SIZE = length(Y);
z1 = zeros(M_SIZE, N_SIZE);

figure
for k=1:length(sigma)
    s = Amp(1)*sin(2*pi*f1*t) + Amp(2)*sin(2*pi*f2*t);
    s = s + sigma(k)*randn(1,Fs); % Add white noise with standard deviation sigma
    for nr=1:N_RUNS
        for M=M_START:M_END
            for N=N_START:N_END
                if M >= N-4
                    fprintf("Ignored, M=%d, N=%d\n", M, N);
                    continue;
                end
                err = 0;
                signal_error = 0;
                f1_found = 0;
                f2_found = 0;
                y = s(x_start:x_start+N-1);

                try
                    method = lm_spectral_method('music', M, 2*P);
                    [~,~,~,~,~] = method.process(y);
                    [fs] = method.eigenrooting(Fs,0,0);
                    % Alternatively
                    % [peaks, pmu] = method.peaks(fs, Fs, 0)
                catch ER
                    fprintf("Error, M=%d, N=%d\n", M, N);
                    continue;
                end

                if size(fs,1) < 2
                    fprintf("Err, M=%d, N=%d\n", M, N);
                    err = -1;
                else

                    f1_found = 0;
                    f2_found = 0;
                    for i=1:size(fs,1)
                        z = fs(i,2);
                        f = abs(fs(i,3));
                        fprintf("z = %f + %fj, |z| = %f, f = %f [Hz]\n", real(z), imag(z), abs(z), f);
                        if abs(f - f1) < 0.5
                            f1_found = f;
                        else
                            if abs(f-f2) < 0.5
                                f2_found = f;
                            end
                        end
                        if f1_found && f2_found
                            break;
                        end
                    end

                    if f1_found == 0 || f2_found == 0
                        fprintf("?? Did not detect freqs, (%d/%d), M=%d, N=%d\n", f1_found, f2_found, M, N);
                        signal_error = 1;
                        continue;
                    end
                end

                err1 = abs(f1 - f1_found);
                err2 = abs(f2 - f2_found);
                z1(M-M_START+1,N-N_START+1) = z1(M-M_START+1,N-N_START+1) + max(err1,err2);
            end
        end
    end

    z1 = z1/nr;

    subplot(2,2,k)
    s=mesh(Y,X,z1,'FaceAlpha','0.1');
    s.FaceColor = 'flat';
    xlabel('N')
    ylabel('M')
    zlabel('Error [Hz]')
    grid on
    title("sigma = " + sigma(k));
    set(findall(gcf,'-property','FontSize'),'FontSize',36);
end
set(findall(gcf,'-property','FontSize'),'FontSize',36);