% LIBMUSIC
% Copyright (C) 2022, Piotr Gregor piotr@dataandsignal.com
%
% single_tone_freq_noise
% 
% Test single tone frequency estimate in noise.
%
% date: August 2022

Fs = 8000;
t = 0:1/Fs:1-1/Fs;
f1 = 1209;
Amp = 3;

%sigma = [0.0001 0.00025 0.0005 0.001 0.0025 0.005 0.01 0.025 0.5];
sigma = [10^-8 10^-6 10^-4 10^-3];
%sigma = [0];
x_start = 1;

P = 1;
M_START = 3;
M_END = M_START+6;
N_START = 12;
N_END = N_START+120;
N_RUNS = 5;

X = linspace(M_START, M_END, M_END-M_START+1);
M_SIZE = length(X);
Y = linspace(N_START, N_END, N_END-N_START+1);
N_SIZE = length(Y);
%Z_SIZE = M_SIZE * N_SIZE;
z1 = zeros(M_SIZE, N_SIZE); % amp by correlation test
z2 = zeros(M_SIZE, N_SIZE); % amp by eigenvectors

figure
for k=1:length(sigma)
    s = Amp(1)*sin(2*pi*f1*t);
    s = s + sigma(k)*randn(1,Fs); % Add white noise with standard deviation sigma
    for nr=1:N_RUNS
        for M=M_START:M_END
            for N=N_START:N_END
                if M >= N
                    fprintf("Ignored, M=%d, N=%d\n", M, N);
                    continue;
                end
                err = 550;
                signal_error = 0;
                f1_found = 0;
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

                if size(fs,1) < 1
                    fprintf("Err, could not detect, M=%d, N=%d\n", M, N);
                    err = -1;
                else
                    z = fs(1,2);
                    f = abs(fs(1,3));
                    fprintf("z = %f + %fj, |z| = %f, f = %f [Hz]\n", real(z), imag(z), abs(z), f);
                    err = abs(f - f1);
                end

                z1(M-M_START+1,N-N_START+1) = z1(M-M_START+1,N-N_START+1) + err;
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
    %zlim([0 2])
end
set(findall(gcf,'-property','FontSize'),'FontSize',36);

%subplot(1,2,2)
%mesh(X,Y,z2);
%xlabel('M')
%ylabel('N')
%zlabel('Błąd [%]')
%grid on