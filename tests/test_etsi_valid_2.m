% LIBMUSIC
% Copyright (C) 2022, Piotr Gregor piotr@dataandsignal.com
%
% test_etsi_valid_2 - Test detection on fractions of valid DTMFs 2.
%
% date: August 2022


o = lm_globals();
d = lm_dtmf();

DETECT_BLOCK_LEN = [10 11 12]; % enum like sigma

N_START = 12;
N_END = 16;

Fs = 8000;

for i = 1:length(DETECT_BLOCK_LEN)
    BLOCK_LEN = DETECT_BLOCK_LEN(i);
    %vectors = zeros(16,o.TEST_VECTOR_LEN);
    for N=N_START:N_END % iterate fractions len
        fprintf("== Block/Fraction: %d/%d\n", BLOCK_LEN, N);

        % Create 2d array of test vectors for given fraction length
        % from 3d array of test vectors
        vectors = [];
        for i=1:16
            s = squeeze(o.g_dtmf_v_valid(i,N,:));
            vectors = [vectors; s(:)'];
        end

        method = lm_spectral_method('music', 4, 4);
        byRoots = 1;
        shouldDetect = 1;
        shouldCheckSymbol = 1;
        shouldCheckAmplitude = 0;
        shouldDetectSampleStart = max(1,o.DTMF_START - BLOCK_LEN);
        shouldDetectSampleEnd = min(o.TEST_VECTOR_LEN,o.DTMF_START+N-1);
        [success_rate] = execute_on_test_vectors(d, o, vectors, method, BLOCK_LEN, byRoots, ...
            shouldDetect, shouldCheckSymbol, shouldCheckAmplitude, shouldDetectSampleStart, shouldDetectSampleEnd, 0)
    end
end