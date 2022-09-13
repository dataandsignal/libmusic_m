% LIBMUSIC
% Copyright (C) 2022, Piotr Gregor piotr@dataandsignal.com
%
% test_etsi
% 
% Some tests of testing. 
%
% date: August 2022


o = lm_globals();
d = lm_dtmf();

FRACTION_LEN = 16;

dtmfs = [1 5 6 8 9 10];
M = 5;


Fs = 8000;
method = lm_spectral_method('music', M, 4);

if 1
    for i=1:16
        decision = 0;
        f1 = 0;
        f2 = 0;
        y = o.g_dtmf_etsi(i,1:FRACTION_LEN);
        %figure
        %plot(y);
        [~,~,~,~,~] = method.process(y);
        [fs] = method.eigenrooting(Fs,0,0);
        [decision,f1,f2] = d.check_by_roots(fs,0);
        fprintf("By ROOTS i=%d, decision=%d, f1=%d, f2=%d\n", i, decision, f1, f2);
    end
end

if 1
    figure
    for i=1:16
        decision = 0;
        f1 = 0;
        f2 = 0;
        y = o.g_dtmf_etsi(i,1:FRACTION_LEN);
        subplot(4,4,i);
        plot(y);
        c = o.dtmf_etsi_idx_2_symbol(i);
        title(c);
        [~,~,~,~,~] = method.process(y);
        [peaks,pmu] = method.peaks(1:1:4000, Fs, 0);
        [decision,f1,f2] = d.check_by_peaks(peaks(1), peaks(2),0);
        fprintf("By PEAKS i=%d (%c), decision=%d, f1=%d, f2=%d\n", i, c, decision, f1, f2);
    end
end


Fs = 8000;
M = 5;
y = o.g_dtmf_etsi(1,1:FRACTION_LEN);

figure

PEAK_WIDTH = 10;
method = lm_spectral_method('music', M, 4);
[~,~,~,~,~] = method.process(y);
[peaks,pmu] = method.peaks(1:1:4000, Fs, PEAK_WIDTH);
[X2,d2] = method.psd(method, 1:1:4000, Fs);
subplot(1,3,1);
plot(X2);

PEAK_WIDTH = 20;
method = lm_spectral_method('ev', M, 4);
[~,~,~,~,~] = method.process(y);
[peaks,pmu] = method.peaks(1:1:4000, Fs, PEAK_WIDTH);
[X2,d2] = method.psd(method, 1:1:4000, Fs);
subplot(1,3,2);
plot(X2);

PEAK_WIDTH = 30;
method = lm_spectral_method('mn', M, 4);
[~,~,~,~,~] = method.process(y);
[peaks,pmu] = method.peaks(1:1:4000, Fs, PEAK_WIDTH);
[X2,d2] = method.psd(method, 1:1:4000, Fs);
subplot(1,3,3);
plot(X2);