% LIBMUSIC
% Copyright (C) 2022, Piotr Gregor piotr@dataandsignal.com
%
% dtmf_test1_valid_dtmf_demultiplex
% 
% Test freq estimates for valid DTMF.
%
% date: August 2022

o = lm_globals();
d = lm_dtmf();

blocks = [11];
%blocks = [40 32 16 12 10 8];
%blocks = [48 32 24 16];
%blocks = [14 12 11 10 9 8];
%blocks = [10 8];
%blocks = [24 16 14 13 12 11 10 9 8];
x_start = 1;

P = 2;
M_START = 4;
M_END = M_START+4;
N_START = 8;
N_END = N_START+20; % 20 36 42
N_RUNS = 1;
PLOT_ONLY_100_PERCENT_VALID = 1;
x = [];
y = [];

X = linspace(M_START, M_END, M_END-M_START+1);
M_SIZE = length(X);
Y = linspace(N_START, N_END, N_END-N_START+1);
N_SIZE = length(Y);
%Z_SIZE = M_SIZE * N_SIZE;
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

                try
                    fprintf("== Block/Fraction: %d/%d\n", BLOCK_LEN, FRACTION_LEN);

                    % Create 2d array of test vectors for given fraction length
                    % from 3d array of test vectors
                    vectors = [];
                    for i=1:16
                        s = squeeze(o.g_dtmf_v_valid(i,FRACTION_LEN,:));
                        %s = squeeze(o.g_dtmf_v_invalid_freq_diff(i,FRACTION_LEN,:));
                        vectors = [vectors; s(:)'];
                    end

                    method = lm_spectral_method('music', M, 4);
                    %method = spectral_method('ev', M, 4);
                    byRoots = 1; % if 1 - use eigenfilter method, if 0 - search for peaks
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

                if ~PLOT_ONLY_100_PERCENT_VALID
                    z1(M-M_START+1,N-N_START+1) = success_rate*100;
                else
                    if success_rate==1
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
        subplot(ceil(length(blocks)/3),3,k);
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