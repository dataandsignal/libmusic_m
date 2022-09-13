% LIBMUSIC
% Copyright (C) 2022, Piotr Gregor piotr@dataandsignal.com
%
% lm_single_tone_noise
% 
% Run MUSIC on single tone with noise.
%
% date: August 2022

% Prepare input samples
Fs = 8000;
t = 0:1/Fs:1-1/Fs;
f1 = 1209;
Amp = 3;

s = Amp*sin(2*pi*f1*t);
x_start = 1;
sigma = 0.1;
s = s + sigma*randn(1,Fs); % Add white noise with standard deviation sigma

P = 1;  % there is single real signal source in stream
M = 5;  % autocorrelation order
N = 24; % number of smaples to process

methods = ["pisarenko" "music" "ev" "mn"];
figure
j = 1;
for i=1:size(methods,2)
    
    % Create method
    method = lm_spectral_method(methods(i), M, 2*P);

    % Process samples
    y = s(x_start:N)
    [Vy,Vx,Ve,A,Ry] = method.process(y)

    % Plot PSD
    fs = linspace(1,4000,4000);
    [X2,d2] = method.psd(method, 1:1:4000, Fs);
    subplot(4,2,j);
    plot(fs,X2)
    xlabel("Hz");
    ylabel("Pmu");
    title(methods(i));
    set(findall(gcf,'-property','FontSize'),'FontSize',24);
    j = j + 1;

    % Get main frequency components by peak searching,
    % only frequencies at fs are checked
    [peaks, pmu] = method.peaks(fs, Fs, 0)

    subplot(4,2,j);
    scatter(peaks,pmu,'filled');
    xlabel("Hz");
    ylabel("Pmu");
    set(findall(gcf,'-property','FontSize'),'FontSize',24);
    j = j + 1;

    % Get P main frequency components by eigenfilter method
    [fs] = method.eigenrooting(Fs, 0, 0)
    fprintf("Roots chosen by distance from unit circle:\n");
    for i=1:P
        if i > size(fs,1)
            break;
        end
        z = fs(i,2);
        f = real(fs(i,3));
        fprintf("z = %f + %fj, |z| = %f, f = %f [Hz]\n", real(z), imag(z), abs(z), f);
    end

    % Get amplitude estimate by correlation method
    A = method.single_tone_amplitude()
    fprintf("Error: %f [%%]\n", (A-Amp)*100/Amp);

    % Get amplitude estimate(s) by solving eigen equations
    A = method.solve_for_amplitudes(f,Fs)
    fprintf("Error: %f [%%]\n", (A-Amp)*100/Amp);
end
