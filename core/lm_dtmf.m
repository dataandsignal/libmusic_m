% LIBMUSIC
% Copyright (C) 2022, Piotr Gregor piotr@dataandsignal.com
%
% lm_dtmf
% 
% DTMF detection.
%
% date: August 2022


classdef lm_dtmf < handle
    properties
        dtmf_low_freqs
        dtmf_high_freqs
    end
    methods
        function [d] = lm_dtmf()
            d.dtmf_low_freqs = [697 770 852 941];
            d.dtmf_high_freqs = [1209 1336 1477 1633];
        end
        function [decision, f1, f2] = check_by_roots(d, fs, print)
            decision = 0;
            f1 = 0;
            f2 = 0;
            N = size(fs,1);
            if N < 2
                error("Did not find roots");
            else
                f1_found = 0;
                f2_found = 0;

                % Search low group freq
                for i=1:N

                    z = fs(i,2);
                    z_distance = fs(i,1);
                    z_f = abs(fs(i,3));

                    for j=1:4

                        f = d.dtmf_low_freqs(j);

                        if print
                            fprintf("LOW %f Hz:  z = %f + %fj, |z| = %f, f = %f [Hz]\n", f, real(z), imag(z), abs(z), z_f);
                        end
                        if abs(f - z_f) < 2
                            f1_found = f;
                            if print
                                fprintf("SELECTED z = %f + %fj, |z| = %f, f = %f [Hz]\n", real(z), imag(z), abs(z), f);
                            end
                            break;
                        end
                    end
                    if f1_found
                        break;
                    end
                end

                if f1_found
                    % Search high group freq
                    for i=1:N

                        z = fs(i,2);
                        z_distance = fs(i,1);
                        z_f = abs(fs(i,3));

                        for j=1:4

                            f = d.dtmf_high_freqs(j);

                            if print
                                fprintf("HIGH %f Hz: z = %f + %fj, |z| = %f, f = %f [Hz]\n", real(z), imag(z), abs(z), z_f);
                            end
                            if abs(f - z_f) < 2
                                f2_found = f;
                                if print
                                    fprintf("SELECTED z = %f + %fj, |z| = %f, f = %f [Hz]\n", real(z), imag(z), abs(z), f);
                                end
                                break;
                            end
                        end
                        if f2_found
                            break;
                        end
                    end
                end
            end
            if (f1_found && f2_found)
                decision = 1;
                f1 = f1_found;
                f2 = f2_found;
            end
        end

        function [decision, f1, f2] = check_by_peaks(d, peak1, peak2, print)
            decision = 0;
            f1 = 0;
            f2 = 0;

            f1_found = 0;
            f2_found = 0;

            % Search low group freq
            for j=1:4
                f = d.dtmf_low_freqs(j);
                if (abs(f - peak1) <= 2 )
                    f1_found = f;
                    if print
                        fprintf("SELECTED f1 by peak1 f = %f [Hz]\n", f);
                    end
                end
                if (abs(f - peak2) <= 2)
                    f1_found = f;
                    if print
                        fprintf("SELECTED f1 by peak2 f = %f [Hz]\n", f);
                    end
                end
            end

            if f1_found
                % Search high group freq
                for j=1:4
                    f = d.dtmf_high_freqs(j);
                    if (abs(f - peak1) <= 2)
                        f2_found = f;
                        if print
                            fprintf("SELECTED f2 by peak1 f = %f [Hz]\n", f);
                        end
                        break;
                    end
                    if (abs(f - peak2) <= 2)
                        f2_found = f;
                        if print
                            printf("SELECTED f2 by peak2 f = %f [Hz]\n", f);
                        end
                        break;
                    end
                end
            end
            if (f1_found && f2_found)
                decision = 1;
                f1 = f1_found;
                f2 = f2_found;
            end
        end

        function [decision,detectSample,detectSymbol] = execute_on_test_vector(d, lm, vector, method, detectBlockLen, byRoots, checkAmplitude, print)
            decision = 0;
            detectSample = 0;
            detectSymbol = 1500;
            vector = vector(:)';
            sample_n = length(vector);
            sample_end = sample_n - detectBlockLen + 1;
            if sample_end < 1
                error("Test vector too short");
            end
            for i=1:sample_end
                try
                    if print
                        fprintf("[%d/%d]->\n", detectBlockLen, i);
                        if i ==41
                            fprintf("o\n");
                        end
                    end
                    f1 = 0;
                    f2 = 0;
                    y = vector(i:i+detectBlockLen-1);
                    % Energy check
                    ENERGY_THRESHOLD = 0.5*(lm.g_dtmf_req_etsi_f2_amp_min_v^2)*detectBlockLen;
                    energy = sum(y.^2);
                    if energy < ENERGY_THRESHOLD
                        continue;
                    end
                    [~,~,~,~,~] = method.process(vector(i:i+detectBlockLen-1));

                    if byRoots
                        [fs] = method.eigenrooting(lm.g_Fs,0,0);
                        [decision,f1,f2] = d.check_by_roots(fs,0);
                        if print
                            fprintf("[%d/%d]By ROOTS, decision=%d, f1=%d, f2=%d\n", detectBlockLen, i, decision, f1, f2);
                        end
                    else
                        [peaks,peaks_pmu] = method.peaks(1:1:4000, lm.g_Fs, 0);
                        [decision,f1,f2] = check_by_peaks(d,peaks(1),peaks(2),print);
                    end
                    if decision
                        if checkAmplitude
                            A = method.dual_tone_amplitude(f1, f2, lm.g_Fs);
                            if size(A,2) < 2
                                continue
                            end
                            if A(1) < lm.g_dtmf_req_etsi_f1_amp_min_v || A(1) > lm.g_dtmf_req_etsi_f1_amp_max_v
                                continue
                            end
                            if A(2) < lm.g_dtmf_req_etsi_f1_amp_min_v || A(2) > lm.g_dtmf_req_etsi_f1_amp_max_v
                                continue
                            end
                        end
                        if print
                            fprintf("DETECTED\n");
                        end
                        detectSample = i;
                        detectSymbol = lm.dtmf_etsi_f1_f2_2_symbol(f1, f2);
                        return
                    end
                catch e
                    if print
                        fprintf("Detection failed\n");
                    end
                    continue;
                end
            end
        end

        function [success_rate] = execute_on_test_vectors(d, lm, vectors, method, detectBlockLen, byRoots, ...
                shouldDetect, shouldCheckSymbol, shouldCheckAmplitude, shouldDetectSampleStart, shouldDetectSampleEnd, print)
            tests_n = size(vectors,1);
            score = 0;
            for i=1:tests_n
                if print
                    fprintf("=== [Exec vector %d]\n", i);
                end
                try
                    [decision,detectSample,detectSymbol] = d.execute_on_test_vector(lm, vectors(i,:), method, detectBlockLen, byRoots, shouldCheckAmplitude, print);
                    if decision
                        if shouldDetect
                            % check symbol index
                            if shouldCheckSymbol
                                trueSymbol = lm.dtmf_etsi_idx_2_symbol(i);
                                if trueSymbol ~= detectSymbol
                                    if print
                                        fprintf("Wrong symbol detected\n");
                                    end
                                    continue
                                end
                                if print
                                    fprintf("Right symbol detected [%c]\n", trueSymbol);
                                end
                            end

                            % check sample number is valid
                            if (detectSample < shouldDetectSampleStart) || (detectSample > shouldDetectSampleEnd)
                                if print
                                    fprintf("False detection\n");
                                end
                            else
                                score = score + 1;
                            end
                        else
                            continue
                        end
                    end
                    if ~decision
                        if ~shouldDetect
                            score = score + 1;
                        else
                            continue
                        end
                    end
                catch
                    continue
                end
            end
            success_rate = (score / tests_n);
        end
    end
end