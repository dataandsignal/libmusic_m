% LIBMUSIC
% Copyright (C) 2022, Piotr Gregor piotr@dataandsignal.com
%
% single_tone_amp
% 
% Estimate single tone amplitude with 2 methods:
% correlation and eigenvectors.
%
% date: August 2022

Fs = 8000;
t = 0:1/Fs:1-1/Fs;
f1 = 1209;
Amp = 3;

s = Amp(1)*sin(2*pi*f1*t);
x_start = 1;

P = 1;
M_START = 2;
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

        %fprintf("Selected unit root:\n");
        err_freq = 1;
        for i=1:size(fs,1)
            z = fs(i,2);
            f = abs(fs(i,3));
            fprintf("z = %f + %fj, |z| = %f, f = %f [Hz]\n", real(z), imag(z), abs(z), f);
            if abs(f - f1) < 0.5
                err_freq = 0;
                break;
            end
        end

        if err_freq
            fprintf("Could not detect freq, M=%d, N=%d\n", M, N);
            continue;
        end

        amp1 = method.single_tone_amplitude();
        err1 = (amp1 - Amp) * 100 / Amp;
        m1 = max(0, 1-abs(err1)/100);
        fprintf("M=%d N=%d, err 1: %f, metric (%f), Amp: %f\n", M, N, err1, m1, amp1);

        amp2 = method.solve_for_amplitudes([f1],Fs);
        err2 = (amp2(1) - Amp) * 100 / Amp;
        m2 = max(0, 1-abs(err2)/100);
        fprintf("M=%d N=%d, err 2: %f, metric (%f), Amp: %f\n", M, N, err2, m2, amp2(1));

        %z1(1+mod(M,N_SIZE),N-N_START+1) = max(0, 1-abs(err1));
        %z2(1+mod(M,N_SIZE),N-N_START+1) = max(0, 1-abs(err2));
        z1(M-M_START+1,N-N_START+1) = err1;
        z2(M-M_START+1,N-N_START+1) = err2;
    end
end

figure
subplot(1,2,1)
s=mesh(Y,X,z1,'FaceAlpha','0.1');
s.FaceColor = 'flat';
xlabel('N')
ylabel('M')
zlabel('Error (corr) [%]')
grid on
subplot(1,2,2)
s=mesh(Y,X,z2,'FaceAlpha','0.05');
s.FaceColor = 'flat';
xlabel('N')
ylabel('M')
zlabel('Error (eigen) [%]')
grid on
set(findall(gcf,'-property','FontSize'),'FontSize',36);