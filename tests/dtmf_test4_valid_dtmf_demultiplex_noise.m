% LIBMUSIC
% Copyright (C) 2022, Piotr Gregor piotr@dataandsignal.com
%
% dtmf_test_4_valid_symbols_demultiplex_noise
% 
% Test detection of fractions of
% valid DTMF symbols, with demultiplexing, in noise.
%
% date: August 2022

o = lm_globals();
d = lm_dtmf();
CHECK_BY_ROOTS = 1; % if 0 then check by peaks

%sigma = [0.0001 0.0005 0.001 0.005 0.01 0.05 0.1 0.5];
sigma = [10^-8 10^-7 10^-6 10^-5];
%sigma = 0;
x_start = 1;

P = 2;
M_START = 4;
M_END = M_START+6;
N_START = 8;
N_END = N_START+12;
N_RUNS = 1;
BLOCK_LEN = 11;

X = linspace(M_START, M_END, M_END-M_START+1);
M_SIZE = length(X);
Y = linspace(N_START, N_END, N_END-N_START+1);
N_SIZE = length(Y);
z1 = zeros(M_SIZE, N_SIZE); %

figure
for k=1:length(sigma)
    for nr=1:N_RUNS
        for M=M_START:M_END
            for N=N_START:N_END
                if M >= N-4
                    fprintf("Ignored, M=%d, N=%d\n", M, N);
                    continue;
                end

                try
                    % Create 2d array of test vectors for given fraction length
                    % from 3d array of test vectors
                    vectors = [];
                    for i=1:16
                        s = squeeze(o.g_dtmf_v_valid(i,N,:));
                        s = s(:)';
                        s = s + sigma(k)*randn(1,o.TEST_VECTOR_LEN); % Add white noise with standard deviation sigma
                        vectors = [vectors; s(:)'];
                    end

                    method = lm_spectral_method('music', M, 4);
                    byRoots = 1;
                    shouldDetect = 1;
                    shouldCheckSymbol = 1;
                    shouldCheckAmplitude = 0;
                    shouldDetectSampleStart = max(1,o.DTMF_START - BLOCK_LEN);
                    shouldDetectSampleEnd = min(o.TEST_VECTOR_LEN,o.DTMF_START+N-1);
                    [success_rate] = execute_on_test_vectors(d, o, vectors, method, BLOCK_LEN, byRoots, ...
                        shouldDetect, shouldCheckSymbol, shouldCheckAmplitude, shouldDetectSampleStart, shouldDetectSampleEnd, 0)
                catch ER
                    fprintf("Err, M=%d, N=%d\n", M, N);
                    continue;
                end

                z1(M-M_START+1,N-N_START+1) = success_rate*100;
            end
        end
    end

    z1 = z1/nr;

    subplot(2,2,k)
    s=mesh(Y,X,z1,'FaceAlpha','0.1');
    s.FaceColor = 'flat';
    xlabel('N')
    ylabel('M')
    zlabel('Correctness [%]')
    grid on
    title("sigma = " + sigma(k));
    set(findall(gcf,'-property','FontSize'),'FontSize',36);
end
set(findall(gcf,'-property','FontSize'),'FontSize',36);