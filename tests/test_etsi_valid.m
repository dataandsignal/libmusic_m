% LIBMUSIC
% Copyright (C) 2022, Piotr Gregor piotr@dataandsignal.com
%
% test_etsi_valid
% 
% Test detection on fractions of valid DTMFs. 
% By peaks and by eigenfilter.
%
% date: August 2022


o = lm_globals();
d = lm_dtmf();

DTMF_IDX = 1;
FRACTION_LEN = 14;

for i=1:1
    for j=FRACTION_LEN:FRACTION_LEN
        s = squeeze(o.g_dtmf_v_valid(i,j,:));
    end
end

Fs = 8000;
method = lm_spectral_method('music', M, 4);

for i=1:16
    decision = 0;
    f1 = 0;
    f2 = 0;
    y = squeeze(o.g_dtmf_v_valid(i,FRACTION_LEN,:));
    [~,~,~,~,~] = method.process(y(o.DTMF_START:o.DTMF_START+FRACTION_LEN-1));
    [fs] = method.eigenrooting(Fs,0,0);
    [decision,f1,f2] = d.check_by_roots(fs,0);
    c = o.dtmf_etsi_idx_2_symbol(i);
    fprintf("By ROOTS i=%d (%c), decision=%d, f1=%d, f2=%d\n", i, c, decision, f1, f2);
end

for i=1:16
    decision = 0;
    f1 = 0;
    f2 = 0;
    y = squeeze(o.g_dtmf_v_valid(i,FRACTION_LEN,:));
    [~,~,~,~,~] = method.process(y(o.DTMF_START:o.DTMF_START+FRACTION_LEN-1));
    PEAK_WIDTH = 10;
    [peaks,pmu] = method.peaks(1:1:4000, Fs, PEAK_WIDTH);
    [decision,f1,f2] = d.check_by_peaks(peaks(1), peaks(2),0);
    c = o.dtmf_etsi_idx_2_symbol(i);
    fprintf("By PEAKS i=%d (%c), decision=%d, f1=%d, f2=%d\n", i, c, decision, f1, f2);
end