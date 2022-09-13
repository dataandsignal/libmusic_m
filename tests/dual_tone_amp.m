% LIBMUSIC
% Copyright (C) 2022, Piotr Gregor piotr@dataandsignal.com
%
% dual_tone_amp
% 
% Estimate dual tone amplitudes with 2 methods:
% correlation and eigenvectors.
%
% date: August 2022

Fs = 8000;
t = 0:1/Fs:1-1/Fs;
f1 = 697;
f2 = 1209;
Amp = [3 3];
s = Amp(1)*sin(2*pi*f1*t) + Amp(2)*sin(2*pi*f2*t);

x_start = 1;

P = 2;
M_START = 4;
M_END = M_START+6;
N_START = 12;
N_END = N_START+32;

X = linspace(M_START, M_END, M_END-M_START+1);
M_SIZE = length(X);
Y = linspace(N_START, N_END, N_END-N_START+1);
N_SIZE = length(Y);
z1 = zeros(M_SIZE, N_SIZE); % amp by correlation test
z2 = zeros(M_SIZE, N_SIZE); % amp by eigenvectors

for M=M_START:M_END
    for N=N_START:N_END
        if M > N
            fprintf("Ignored, M=%d, N=%d\n", M, N);
            continue;
        end
        err_freq = 0;
        y = s(x_start:x_start+N-1);

        try
        method = lm_spectral_method('music', M, 2*P);
        [~,~,~,~,~] = method.process(y);
        [fs] = method.eigenrooting(Fs,0,0);
        % Alternatively
        % [peaks, pmu] = method.peaks(fs, Fs, 0)
        catch ER
            fprintf("Err, M=%d, N=%d\n", M, N);
            continue;
        end

        if size(fs,1) < 2
            fprintf("Err, did not detect freqs, M=%d, N=%d\n", M, N);
            continue;
        end

        f1_found = 0;
        f2_found = 0;
        for i=1:size(fs,1)
            z = fs(i,2);
            f = abs(fs(i,3));
            %fprintf("z = %f + %fj, |z| = %f, f = %f [Hz]\n", real(z), imag(z), abs(z), f);
            if abs(f - f1) < 0.5
                f1_found = 1;
            else
                if abs(f-f2) < 0.5
                    f2_found = 1;
                end
            end
        end

        if f1_found == 0 || f2_found == 0
            fprintf("?? Did not detect freqs, (%d/%d), M=%d, N=%d\n", f1_found, f2_found, M, N);
            continue;
        end

        amp1 = method.dual_tone_amplitude(f1, f2, Fs);
        a1 = (amp1(1) - Amp(1)) * 100 / Amp(1);
        a2 = (amp1(2) - Amp(2)) * 100 / Amp(2);
        err1 = max(abs(a1), abs(a2));
        m1 = max(0, 1-abs(err1)/100);
        fprintf("M=%d N=%d, err 1: %f, metric (%f), Amp: %f %f\n", M, N, err1, m1, amp1(1), amp1(2));

        amp2 = method.solve_for_amplitudes([f1 f2],Fs);
        a1 = (amp2(1) - Amp(1)) * 100 / Amp(1);
        a2 = (amp2(2) - Amp(2)) * 100 / Amp(2);
        err2 = max(abs(a1), abs(a2));
        m2 = max(0, 1-abs(err2)/100);
        fprintf("M=%d N=%d, err 2: %f, metric (%f), Amp: %f %f\n", M, N, err2, m2, amp2(1), amp2(2));

        %z1(1+mod(M,N_SIZE),N-N_START+1) = max(0, 1-abs(err1));
        %z2(1+mod(M,N_SIZE),N-N_START+1) = max(0, 1-abs(err2));
        z1(M-M_START+1,N-N_START+1) = err1;
        z2(M-M_START+1,N-N_START+1) = err2;
    end
end

figure
subplot(1,2,1)
s = mesh(Y,X,z1,'FaceAlpha','0.1');
s.FaceColor = 'flat';
xlabel('N')
ylabel('M')
zlabel('Error [%]')
grid on
set(findall(gcf,'-property','FontSize'),'FontSize',24);

subplot(1,2,2)
s = mesh(Y,X,z2,'FaceAlpha','0.1');
s.FaceColor = 'flat';
xlabel('N')
ylabel('M')
zlabel('Error [%]')
grid on
set(findall(gcf,'-property','FontSize'),'FontSize',24);
