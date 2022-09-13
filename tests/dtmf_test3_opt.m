% LIBMUSIC
% Copyright (C) 2022, Piotr Gregor piotr@dataandsignal.com
%
% dtmf_test3_opt
% 
% Find best (optimal) settings for DTMF detection/rejection.
% This test runs DTMF detection on proper DTMF signals,
% and checks for rejection of invalid DTMF signals.
% If PLOT_ONLY_100_PERCENT_VALID is set, then result is a map of settings 
% (M,N,L) that work in all cases. Otherwise result is chart.
%
% date: August 2022

o = lm_globals();
d = lm_dtmf();

Fs = 8000;
t = 0:1/Fs:1-1/Fs;
f1 = 697;
f2 = 1209;
Amp = [3 3];


%blocks = [16 8];
%blocks = [40 32];
%blocks = [14 12 11 10 9 8];
%blocks = [10];
blocks = [40 32 16 12 10 8];
%blocks = [24 16 14 13 12 11 10 9 8];
x_start = 1;

P = 2;
M_START = 4;
M_END = M_START+3;
N_START = 8;
N_END = N_START+20; % 20 36 42
N_RUNS = 1;
sigma = 0.001;
PLOT_ONLY_100_PERCENT_VALID = 0; % 1 - result is map of optimum settings, 0 - result is chart
x = [];
y = [];

X = linspace(M_START, M_END, M_END-M_START+1);
M_SIZE = length(X);
Y = linspace(N_START, N_END, N_END-N_START+1);
N_SIZE = length(Y);
z1 = zeros(M_SIZE, N_SIZE); % amp by correlation test
z2 = zeros(M_SIZE, N_SIZE); % amp by eigenvectors

figure
for k=1:length(blocks)
    BLOCK_LEN = blocks(k);
    for nr=1:N_RUNS
        x = [];
        y = [];
        for M=M_START:M_END
            for N=N_START:N_END
                FRACTION_LEN = N;
                if M >= N
                    fprintf("Ignored, M=%d, N=%d\n", M, N);
                    continue;
                end
                err = 0;
                success_rate = 0;
                success_rate_cum = 1;


                try
                    fprintf("== Block/Fraction: %d/%d\n", BLOCK_LEN, FRACTION_LEN);

                    % Create 2d array of test vectors for given fraction length
                    % from 3d array of test vectors
                    for v=1:5
                        vectors = [];
                        for i=1:16
                            switch v
                                case 1
                                    s = squeeze(o.g_dtmf_v_invalid_freq_diff(i,FRACTION_LEN,:));
                                case 2
                                    s = squeeze(o.g_dtmf_v_invalid_amp_diff(i,FRACTION_LEN,:));
                                case 3
                                    s = squeeze(o.g_dtmf_v_invalid_amp_and_freq(i,FRACTION_LEN,:));
                                case 4
                                    s = squeeze(o.g_dtmf_v_not_a_dtmf(i,FRACTION_LEN,:));
                                case 5
                                    s = squeeze(o.g_dtmf_v_valid(i,FRACTION_LEN,:));
                            end
                            s = s(:)';
                            s = s + sigma*randn(1,o.TEST_VECTOR_LEN); % Add white noise with standard deviation sigma
                            vectors = [vectors; s(:)'];
                        end

                        method = lm_spectral_method('music', M, 4);
                        byRoots = 1;

                        shouldCheckSymbol = 1;
                        shouldCheckAmplitude = 0;
                        shouldDetectSampleStart = max(1,o.DTMF_START - BLOCK_LEN);
                        shouldDetectSampleEnd = min(o.TEST_VECTOR_LEN,o.DTMF_START+N-1);

                        switch v
                            case 5
                                shouldDetect = 1;
                            otherwise
                                shouldDetect = 0;
                        end
                        
                        [success_rate] = execute_on_test_vectors(d, o, vectors, method, BLOCK_LEN, byRoots, ...
                                    shouldDetect, shouldCheckSymbol, shouldCheckAmplitude, shouldDetectSampleStart, shouldDetectSampleEnd, 0)
                        if ~PLOT_ONLY_100_PERCENT_VALID
                            success_rate_cum = success_rate_cum + success_rate;
                        else
                            success_rate_cum = success_rate_cum * success_rate;
                        end
                    end
                catch ER
                    fprintf("Err, M=%d, N=%d\n", M, N);
                    continue;
                end

                if ~PLOT_ONLY_100_PERCENT_VALID
                    z1(M-M_START+1,N-N_START+1) = success_rate_cum*100/5;
                else
                    if success_rate_cum==1
                        x = [x; M];
                        y = [y; N];
                    end
                end
            end
        end
    end

    if ~PLOT_ONLY_100_PERCENT_VALID
        z1 = z1/nr;
        subplot(ceil(length(blocks)/2),2,k);
        s=mesh(Y,X,z1,'FaceAlpha','0.1');
        s.FaceColor = 'flat';
        xlabel('L') % DTMF fraction length
        ylabel('M')
        zlabel('Correctness [%]')
        grid on
    else
        subplot(ceil(length(blocks)/2),2,k);
        s=scatter(x,y,45,"blue",'filled');
        xlabel('M')
        ylabel('L') % DTMF fraction length
        grid on
        grid minor
        ax = gca;
        ax.GridLineStyle = '-';
        xlim([M_START M_END]);
        ylim([N_START N_END]);
    end

    title("N = " + BLOCK_LEN);
    set(findall(gcf,'-property','FontSize'),'FontSize',36);
    hold on
end
set(findall(gcf,'-property','FontSize'),'FontSize',36);