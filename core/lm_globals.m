% LIBMUSIC
% Copyright (C) 2022, Piotr Gregor piotr@dataandsignal.com
%
% lm_globals - Global variables.
%
% date: August 2022

classdef lm_globals < handle
    properties
        g_Fs
        g_t
        g_f1
        g_f2
        g_amp
        g_dtmf_low_freqs
        g_dtmf_high_freqs

        % Sine and cosine, 1000 Hz
        g_s_1000
        g_c_1000
        g_s_1000_e01
        g_c_1000_e01
        g_s_1000_e001
        g_c_1000_e001
        g_s_1000_e0001
        g_c_1000_e0001
        g_s_1000_e00001
        g_c_1000_e00001

        % Sine and cosine, 1209 Hz
        g_s_1209
        g_c_1209
        g_s_1209_e01
        g_c_1209_e01
        g_s_1209_e001
        g_c_1209_e001
        g_s_1209_e0001
        g_c_1209_e0001
        g_s_1209_e00001
        g_c_1209_e00001

        % Sine and cosine, 697 Hz
        g_s_697
        g_c_697
        g_s_697_e01
        g_c_697_e01
        g_s_697_e001
        g_c_697_e001
        g_s_697_e0001
        g_c_697_e0001
        g_s_697_e00001
        g_c_697_e00001

        % Sine and cosine, 770 Hz
        g_s_770
        g_c_770
        g_s_770_e01
        g_c_770_e01
        g_s_770_e001
        g_c_770_e001
        g_s_770_e0001
        g_c_770_e0001
        g_s_770_e00001
        g_c_770_e00001

        % Sine and cosine, 1633 Hz
        g_s_1633
        g_c_1633
        g_s_1633_e01
        g_c_1633_e01
        g_s_1633_e001
        g_c_1633_e001
        g_s_1633_e0001
        g_c_1633_e0001
        g_s_1633_e00001
        g_c_1633_e00001

        % Sine and cosine, 1833 Hz
        g_s_1833
        g_c_1833
        g_s_1833_e01
        g_c_1833_e01
        g_s_1833_e001
        g_c_1833_e001
        g_s_1833_e0001
        g_c_1833_e0001
        g_s_1833_e00001
        g_c_1833_e00001

        % Sine and cosine, 2000 Hz
        g_s_2000
        g_c_2000
        g_s_2000_e01
        g_c_2000_e01
        g_s_2000_e001
        g_c_2000_e001
        g_s_2000_e0001
        g_c_2000_e0001
        g_s_2000_e00001
        g_c_2000_e00001

        % Sine and cosine, 3000 Hz
        g_s_3000
        g_c_3000
        g_s_3000_e01
        g_c_3000_e01
        g_s_3000_e001
        g_c_3000_e001
        g_s_3000_e0001
        g_c_3000_e0001
        g_s_3000_e00001
        g_c_3000_e00001

        % Sine and cosine, 3033 Hz
        g_s_3033
        g_c_3033
        g_s_3033_e01
        g_c_3033_e01
        g_s_3033_e001
        g_c_3033_e001
        g_s_3033_e0001
        g_c_3033_e0001
        g_s_3033_e00001
        g_c_3033_e00001

        % Sine and cosine, 3500 Hz
        g_s_3500
        g_c_3500
        g_s_3500_e01
        g_c_3500_e01
        g_s_3500_e001
        g_c_3500_e001
        g_s_3500_e0001
        g_c_3500_e0001
        g_s_3500_e00001
        g_c_3500_e00001

        % DTMF
        g_dtmf_1_f1
        g_dtmf_1_f2
        g_dtmf_2_f1
        g_dtmf_2_f2
        g_dtmf_3_f1
        g_dtmf_3_f2
        g_dtmf_A_f1
        g_dtmf_A_f2

        g_dtmf_4_f1
        g_dtmf_4_f2
        g_dtmf_5_f1
        g_dtmf_5_f2
        g_dtmf_6_f1
        g_dtmf_6_f2
        g_dtmf_B_f1
        g_dtmf_B_f2

        g_dtmf_7_f1
        g_dtmf_7_f2
        g_dtmf_8_f1
        g_dtmf_8_f2
        g_dtmf_9_f1
        g_dtmf_9_f2
        g_dtmf_C_f1
        g_dtmf_C_f2

        g_dtmf_star_f1
        g_dtmf_star_f2
        g_dtmf_0_f1
        g_dtmf_0_f2
        g_dtmf_hash_f1
        g_dtmf_hash_f2
        g_dtmf_D_f1
        g_dtmf_D_f2

        g_dtmf_1
        g_dtmf_2
        g_dtmf_3
        g_dtmf_A
        g_dtmf_4
        g_dtmf_5
        g_dtmf_6
        g_dtmf_B
        g_dtmf_7
        g_dtmf_8
        g_dtmf_9
        g_dtmf_C
        g_dtmf_star
        g_dtmf_0
        g_dtmf_hash
        g_dtmf_D

        % ETSI ES 201 235-2 V1.1.1 DTMF Requirements
        g_dtmf_req_etsi_freq_error_percent
        g_dtmf_req_etsi_f1_amp_min_dbv
        g_dtmf_req_etsi_f1_amp_max_dbv
        g_dtmf_req_etsi_f1_amp_min_v
        g_dtmf_req_etsi_f1_amp_max_v
        g_dtmf_req_etsi_f2_amp_min_dbv
        g_dtmf_req_etsi_f2_amp_max_dbv
        g_dtmf_req_etsi_f2_amp_min_v
        g_dtmf_req_etsi_f2_amp_max_v
        g_dtmf_req_etsi_f2_f1_diff_min_db
        g_dtmf_req_etsi_f2_f1_diff_max_db
        g_dtmf_req_etsi_duration_min_ms
        g_dtmf_req_etsi_total_unwanted_power_max_dB
        g_dtmf_etsi_f1_amp_v
        g_dtmf_etsi_f2_amp_v

        % ETSI compliant DTMF
        g_dtmf_1_etsi
        g_dtmf_2_etsi
        g_dtmf_3_etsi
        g_dtmf_A_etsi
        g_dtmf_4_etsi
        g_dtmf_5_etsi
        g_dtmf_6_etsi
        g_dtmf_B_etsi
        g_dtmf_7_etsi
        g_dtmf_8_etsi
        g_dtmf_9_etsi
        g_dtmf_C_etsi
        g_dtmf_star_etsi
        g_dtmf_0_etsi
        g_dtmf_hash_etsi
        g_dtmf_D_etsi

        % Array of ETSI compliant DTMFs
        g_dtmf_etsi
        g_dtmf_etsi_freqs

        % Testing
        g_dtmf_v_valid
        g_dtmf_v_invalid_amp
        g_dtmf_v_invalid_amp_diff
        g_dtmf_v_invalid_freq_diff
        g_dtmf_v_invalid_amp_and_freq
        g_dtmf_v_not_a_dtmf
        MAX_FRACTION_LEN
        TEST_VECTOR_LEN
        DTMF_START
        dtmf_etsi_symbol_arr
        g_files
    end
    methods
        function o = lm_globals()
            o.g_Fs=8000;
            o.g_t = 0:1/o.g_Fs:1-1/o.g_Fs;
            o.g_f1 = 1000;
            o.g_f2 = 1209;
            o.g_amp = 1;
            o.g_dtmf_low_freqs = [697 770 852 941];
            o.g_dtmf_high_freqs = [1209 1336 1477 1336];

            % Sine and cosine, 1000 Hz
            o.g_s_1000 = o.g_amp*sin(2*pi*1000*o.g_t);
            o.g_c_1000 = o.g_amp*cos(2*pi*1000*o.g_t);
            o.g_s_1000_e01 = o.g_amp*sin(2*pi*1000*o.g_t) + 0.1* randn(1,o.g_Fs);
            o.g_c_1000_e01 = o.g_amp*cos(2*pi*1000*o.g_t) + 0.1* randn(1,o.g_Fs);
            o.g_s_1000_e001 = o.g_amp*sin(2*pi*1000*o.g_t) + 0.01* randn(1,o.g_Fs);
            o.g_c_1000_e001 = o.g_amp*cos(2*pi*1000*o.g_t) + 0.01* randn(1,o.g_Fs);
            o.g_s_1000_e0001 = o.g_amp*sin(2*pi*1000*o.g_t) + 0.001* randn(1,o.g_Fs);
            o.g_c_1000_e0001 = o.g_amp*cos(2*pi*1000*o.g_t) + 0.001* randn(1,o.g_Fs);
            o.g_s_1000_e00001 = o.g_amp*sin(2*pi*1000*o.g_t) + 0.0001* randn(1,o.g_Fs);
            o.g_c_1000_e00001 = o.g_amp*cos(2*pi*1000*o.g_t) + 0.0001* randn(1,o.g_Fs);

            % Sine and cosine, 1209 Hz
            o.g_s_1209 = o.g_amp*sin(2*pi*1209*o.g_t);
            o.g_c_1209 = o.g_amp*cos(2*pi*1209*o.g_t);
            o.g_s_1209_e01 = o.g_amp*sin(2*pi*1209*o.g_t) + 0.1* randn(1,o.g_Fs);
            o.g_c_1209_e01 = o.g_amp*cos(2*pi*1209*o.g_t) + 0.1* randn(1,o.g_Fs);
            o.g_s_1209_e001 = o.g_amp*sin(2*pi*1209*o.g_t) + 0.01* randn(1,o.g_Fs);
            o.g_c_1209_e001 = o.g_amp*cos(2*pi*1209*o.g_t) + 0.01* randn(1,o.g_Fs);
            o.g_s_1209_e0001 = o.g_amp*sin(2*pi*1209*o.g_t) + 0.001* randn(1,o.g_Fs);
            o.g_c_1209_e0001 = o.g_amp*cos(2*pi*1209*o.g_t) + 0.001* randn(1,o.g_Fs);
            o.g_s_1209_e00001 = o.g_amp*sin(2*pi*1209*o.g_t) + 0.0001* randn(1,o.g_Fs);
            o.g_c_1209_e00001 = o.g_amp*cos(2*pi*1209*o.g_t) + 0.0001* randn(1,o.g_Fs);

            % Sine and cosine, 697 Hz
            o.g_s_697 = o.g_amp*sin(2*pi*697*o.g_t);
            o.g_c_697 = o.g_amp*cos(2*pi*697*o.g_t);
            o.g_s_697_e01 = o.g_amp*sin(2*pi*697*o.g_t) + 0.1* randn(1,o.g_Fs);
            o.g_c_697_e01 = o.g_amp*cos(2*pi*697*o.g_t) + 0.1* randn(1,o.g_Fs);
            o.g_s_697_e001 = o.g_amp*sin(2*pi*697*o.g_t) + 0.01* randn(1,o.g_Fs);
            o.g_c_697_e001 = o.g_amp*cos(2*pi*697*o.g_t) + 0.01* randn(1,o.g_Fs);
            o.g_s_697_e0001 = o.g_amp*sin(2*pi*697*o.g_t) + 0.001* randn(1,o.g_Fs);
            o.g_c_697_e0001 = o.g_amp*cos(2*pi*697*o.g_t) + 0.001* randn(1,o.g_Fs);
            o.g_s_697_e00001 = o.g_amp*sin(2*pi*697*o.g_t) + 0.0001* randn(1,o.g_Fs);
            o.g_c_697_e00001 = o.g_amp*cos(2*pi*697*o.g_t) + 0.0001* randn(1,o.g_Fs);

            % Sine and cosine, 770 Hz
            o.g_s_770 = o.g_amp*sin(2*pi*770*o.g_t);
            o.g_c_770 = o.g_amp*cos(2*pi*770*o.g_t);
            o.g_s_770_e01 = o.g_amp*sin(2*pi*770*o.g_t) + 0.1* randn(1,o.g_Fs);
            o.g_c_770_e01 = o.g_amp*cos(2*pi*770*o.g_t) + 0.1* randn(1,o.g_Fs);
            o.g_s_770_e001 = o.g_amp*sin(2*pi*770*o.g_t) + 0.01* randn(1,o.g_Fs);
            o.g_c_770_e001 = o.g_amp*cos(2*pi*770*o.g_t) + 0.01* randn(1,o.g_Fs);
            o.g_s_770_e0001 = o.g_amp*sin(2*pi*770*o.g_t) + 0.001* randn(1,o.g_Fs);
            o.g_c_770_e0001 = o.g_amp*cos(2*pi*770*o.g_t) + 0.001* randn(1,o.g_Fs);
            o.g_s_770_e00001 = o.g_amp*sin(2*pi*770*o.g_t) + 0.0001* randn(1,o.g_Fs);
            o.g_c_770_e00001 = o.g_amp*cos(2*pi*770*o.g_t) + 0.0001* randn(1,o.g_Fs);

            % Sine and cosine, 1633 Hz
            o.g_s_1633 = o.g_amp*sin(2*pi*1633*o.g_t);
            o.g_c_1633 = o.g_amp*cos(2*pi*1633*o.g_t);
            o.g_s_1633_e01 = o.g_amp*sin(2*pi*1633*o.g_t) + 0.1* randn(1,o.g_Fs);
            o.g_c_1633_e01 = o.g_amp*cos(2*pi*1633*o.g_t) + 0.1* randn(1,o.g_Fs);
            o.g_s_1633_e001 = o.g_amp*sin(2*pi*1633*o.g_t) + 0.01* randn(1,o.g_Fs);
            o.g_c_1633_e001 = o.g_amp*cos(2*pi*1633*o.g_t) + 0.01* randn(1,o.g_Fs);
            o.g_s_1633_e0001 = o.g_amp*sin(2*pi*1633*o.g_t) + 0.001* randn(1,o.g_Fs);
            o.g_c_1633_e0001 = o.g_amp*cos(2*pi*1633*o.g_t) + 0.001* randn(1,o.g_Fs);
            o.g_s_1633_e00001 = o.g_amp*sin(2*pi*1633*o.g_t) + 0.0001* randn(1,o.g_Fs);
            o.g_c_1633_e00001 = o.g_amp*cos(2*pi*1633*o.g_t) + 0.0001* randn(1,o.g_Fs);

            % Sine and cosine, 1833 Hz
            o.g_s_1833 = o.g_amp*sin(2*pi*1833*o.g_t);
            o.g_c_1833 = o.g_amp*cos(2*pi*1833*o.g_t);
            o.g_s_1833_e01 = o.g_amp*sin(2*pi*1833*o.g_t) + 0.1* randn(1,o.g_Fs);
            o.g_c_1833_e01 = o.g_amp*cos(2*pi*1833*o.g_t) + 0.1* randn(1,o.g_Fs);
            o.g_s_1833_e001 = o.g_amp*sin(2*pi*1833*o.g_t) + 0.01* randn(1,o.g_Fs);
            o.g_c_1833_e001 = o.g_amp*cos(2*pi*1833*o.g_t) + 0.01* randn(1,o.g_Fs);
            o.g_s_1833_e0001 = o.g_amp*sin(2*pi*1833*o.g_t) + 0.001* randn(1,o.g_Fs);
            o.g_c_1833_e0001 = o.g_amp*cos(2*pi*1833*o.g_t) + 0.001* randn(1,o.g_Fs);
            o.g_s_1833_e00001 = o.g_amp*sin(2*pi*1833*o.g_t) + 0.0001* randn(1,o.g_Fs);
            o.g_c_1833_e00001 = o.g_amp*cos(2*pi*2000*o.g_t) + 0.0001* randn(1,o.g_Fs);

            % Sine and cosine, 2000 Hz
            o.g_s_2000 = o.g_amp*sin(2*pi*2000*o.g_t);
            o.g_c_2000 = o.g_amp*cos(2*pi*2000*o.g_t);
            o.g_s_2000_e01 = o.g_amp*sin(2*pi*2000*o.g_t) + 0.1* randn(1,o.g_Fs);
            o.g_c_2000_e01 = o.g_amp*cos(2*pi*2000*o.g_t) + 0.1* randn(1,o.g_Fs);
            o.g_s_2000_e001 = o.g_amp*sin(2*pi*2000*o.g_t) + 0.01* randn(1,o.g_Fs);
            o.g_c_2000_e001 = o.g_amp*cos(2*pi*2000*o.g_t) + 0.01* randn(1,o.g_Fs);
            o.g_s_2000_e0001 = o.g_amp*sin(2*pi*2000*o.g_t) + 0.001* randn(1,o.g_Fs);
            o.g_c_2000_e0001 = o.g_amp*cos(2*pi*2000*o.g_t) + 0.001* randn(1,o.g_Fs);
            o.g_s_2000_e00001 = o.g_amp*sin(2*pi*2000*o.g_t) + 0.0001* randn(1,o.g_Fs);
            o.g_c_2000_e00001 = o.g_amp*cos(2*pi*2000*o.g_t) + 0.0001* randn(1,o.g_Fs);


            % Sine and cosine, 3000 Hz
            o.g_s_3000 = o.g_amp*sin(2*pi*3000*o.g_t);
            o.g_c_3000 = o.g_amp*cos(2*pi*3000*o.g_t);
            o.g_s_3000_e01 = o.g_amp*sin(2*pi*3000*o.g_t) + 0.1* randn(1,o.g_Fs);
            o.g_c_3000_e01 = o.g_amp*cos(2*pi*3000*o.g_t) + 0.1* randn(1,o.g_Fs);
            o.g_s_3000_e001 = o.g_amp*sin(2*pi*3000*o.g_t) + 0.01* randn(1,o.g_Fs);
            o.g_c_3000_e001 = o.g_amp*cos(2*pi*3000*o.g_t) + 0.01* randn(1,o.g_Fs);
            o.g_s_3000_e0001 = o.g_amp*sin(2*pi*3000*o.g_t) + 0.001* randn(1,o.g_Fs);
            o.g_c_3000_e0001 = o.g_amp*cos(2*pi*3000*o.g_t) + 0.001* randn(1,o.g_Fs);
            o.g_s_3000_e00001 = o.g_amp*sin(2*pi*3000*o.g_t) + 0.0001* randn(1,o.g_Fs);
            o.g_c_3000_e00001 = o.g_amp*cos(2*pi*3000*o.g_t) + 0.0001* randn(1,o.g_Fs);

            % Sine and cosine, 3033 Hz
            o.g_s_3033 = o.g_amp*sin(2*pi*3033*o.g_t);
            o.g_c_3033 = o.g_amp*cos(2*pi*3033*o.g_t);
            o.g_s_3033_e01 = o.g_amp*sin(2*pi*3033*o.g_t) + 0.1* randn(1,o.g_Fs);
            o.g_c_3033_e01 = o.g_amp*cos(2*pi*3033*o.g_t) + 0.1* randn(1,o.g_Fs);
            o.g_s_3033_e001 = o.g_amp*sin(2*pi*3033*o.g_t) + 0.01* randn(1,o.g_Fs);
            o.g_c_3033_e001 = o.g_amp*cos(2*pi*3033*o.g_t) + 0.01* randn(1,o.g_Fs);
            o.g_s_3033_e0001 = o.g_amp*sin(2*pi*3033*o.g_t) + 0.001* randn(1,o.g_Fs);
            o.g_c_3033_e0001 = o.g_amp*cos(2*pi*3033*o.g_t) + 0.001* randn(1,o.g_Fs);
            o.g_s_3033_e00001 = o.g_amp*sin(2*pi*3033*o.g_t) + 0.0001* randn(1,o.g_Fs);
            o.g_c_3033_e00001 = o.g_amp*cos(2*pi*3033*o.g_t) + 0.0001* randn(1,o.g_Fs);

            % Sine and cosine, 3500 Hz
            o.g_s_3500 = o.g_amp*sin(2*pi*3500*o.g_t);
            o.g_c_3500 = o.g_amp*cos(2*pi*3500*o.g_t);
            o.g_s_3500_e01 = o.g_amp*sin(2*pi*3500*o.g_t) + 0.1* randn(1,o.g_Fs);
            o.g_c_3500_e01 = o.g_amp*cos(2*pi*3500*o.g_t) + 0.1* randn(1,o.g_Fs);
            o.g_s_3500_e001 = o.g_amp*sin(2*pi*3500*o.g_t) + 0.01* randn(1,o.g_Fs);
            o.g_c_3500_e001 = o.g_amp*cos(2*pi*3500*o.g_t) + 0.01* randn(1,o.g_Fs);
            o.g_s_3500_e0001 = o.g_amp*sin(2*pi*3500*o.g_t) + 0.001* randn(1,o.g_Fs);
            o.g_c_3500_e0001 = o.g_amp*cos(2*pi*3500*o.g_t) + 0.001* randn(1,o.g_Fs);
            o.g_s_3500_e00001 = o.g_amp*sin(2*pi*3500*o.g_t) + 0.0001* randn(1,o.g_Fs);
            o.g_c_3500_e00001 = o.g_amp*cos(2*pi*3500*o.g_t) + 0.0001* randn(1,o.g_Fs);


            % DTMF
            %	 *			1209 Hz	|	1336 Hz		| 1477 Hz	|	1633 Hz
            %	 *	697 Hz	'1'			'2'				'3'			'A'
            %	 *	770 Hz	'4'			'5'				'6'			'B'
            %	 *	852 Hz	'7'			'8'				'9'			'C'
            %	 *	941 Hz	'*'			'0'				'#'			'D'
            %
            % f1 - low group frequency
            % f2 - high group frequency
            % f1_amp - amplitude of lower freq component
            % f2_amp - amplitude of higher freq component

            o.g_dtmf_1_f1 = 697;
            o.g_dtmf_1_f2 = 1209;
            o.g_dtmf_2_f1 = 697;
            o.g_dtmf_2_f2 = 1336;
            o.g_dtmf_3_f1 = 697;
            o.g_dtmf_3_f2 = 1477;
            o.g_dtmf_A_f1 = 697;
            o.g_dtmf_A_f2 = 1633;

            o.g_dtmf_4_f1 = 770;
            o.g_dtmf_4_f2 = 1209;
            o.g_dtmf_5_f1 = 770;
            o.g_dtmf_5_f2 = 1336;
            o.g_dtmf_6_f1 = 770;
            o.g_dtmf_6_f2 = 1477;
            o.g_dtmf_B_f1 = 770;
            o.g_dtmf_B_f2 = 1633;

            o.g_dtmf_7_f1 = 852;
            o.g_dtmf_7_f2 = 1209;
            o.g_dtmf_8_f1 = 852;
            o.g_dtmf_8_f2 = 1336;
            o.g_dtmf_9_f1 = 852;
            o.g_dtmf_9_f2 = 1477;
            o.g_dtmf_C_f1 = 852;
            o.g_dtmf_C_f2 = 1633;

            o.g_dtmf_star_f1 = 941;
            o.g_dtmf_star_f2 = 1209;
            o.g_dtmf_0_f1 = 941;
            o.g_dtmf_0_f2 = 1336;
            o.g_dtmf_hash_f1 = 941;
            o.g_dtmf_hash_f2 = 1477;
            o.g_dtmf_D_f1 = 941;
            o.g_dtmf_D_f2 = 1633;

            o.g_dtmf_1 = sin(2*pi*o.g_dtmf_1_f1*o.g_t) + sin(2*pi*o.g_dtmf_1_f2*o.g_t);
            o.g_dtmf_2 = sin(2*pi*o.g_dtmf_2_f1*o.g_t) + sin(2*pi*o.g_dtmf_2_f2*o.g_t);
            o.g_dtmf_3 = sin(2*pi*o.g_dtmf_3_f1*o.g_t) + sin(2*pi*o.g_dtmf_3_f2*o.g_t);
            o.g_dtmf_A = sin(2*pi*o.g_dtmf_A_f1*o.g_t) + sin(2*pi*o.g_dtmf_A_f2*o.g_t);
            o.g_dtmf_4 = sin(2*pi*o.g_dtmf_4_f1*o.g_t) + sin(2*pi*o.g_dtmf_4_f2*o.g_t);
            o.g_dtmf_5 = sin(2*pi*o.g_dtmf_5_f1*o.g_t) + sin(2*pi*o.g_dtmf_5_f2*o.g_t);
            o.g_dtmf_6 = sin(2*pi*o.g_dtmf_6_f1*o.g_t) + sin(2*pi*o.g_dtmf_6_f2*o.g_t);
            o.g_dtmf_B = sin(2*pi*o.g_dtmf_B_f1*o.g_t) + sin(2*pi*o.g_dtmf_B_f2*o.g_t);
            o.g_dtmf_7 = sin(2*pi*o.g_dtmf_7_f1*o.g_t) + sin(2*pi*o.g_dtmf_7_f2*o.g_t);
            o.g_dtmf_8 = sin(2*pi*o.g_dtmf_8_f1*o.g_t) + sin(2*pi*o.g_dtmf_8_f2*o.g_t);
            o.g_dtmf_9 = sin(2*pi*o.g_dtmf_9_f1*o.g_t) + sin(2*pi*o.g_dtmf_9_f2*o.g_t);
            o.g_dtmf_C = sin(2*pi*o.g_dtmf_C_f1*o.g_t) + sin(2*pi*o.g_dtmf_C_f2*o.g_t);
            o.g_dtmf_star = sin(2*pi*o.g_dtmf_star_f1*o.g_t) + sin(2*pi*o.g_dtmf_star_f2*o.g_t);
            o.g_dtmf_0 = sin(2*pi*o.g_dtmf_0_f1*o.g_t) + sin(2*pi*o.g_dtmf_0_f2*o.g_t);
            o.g_dtmf_hash = sin(2*pi*o.g_dtmf_hash_f1*o.g_t) + sin(2*pi*o.g_dtmf_hash_f2*o.g_t);
            o.g_dtmf_D = sin(2*pi*o.g_dtmf_D_f1*o.g_t) + sin(2*pi*o.g_dtmf_D_f2*o.g_t);

            % ETSI DTMF requirements
            o.g_dtmf_req_etsi_freq_error_percent = 1.5;
            o.g_dtmf_req_etsi_f1_amp_min_dbv = -13.0;
            o.g_dtmf_req_etsi_f1_amp_max_dbv = -8.5;
            o.g_dtmf_req_etsi_f1_amp_min_v = 0.2239;
            o.g_dtmf_req_etsi_f1_amp_max_v = 0.3758;
            o.g_dtmf_req_etsi_f2_amp_min_dbv = -11.5;
            o.g_dtmf_req_etsi_f2_amp_max_dbv = -7.0;
            o.g_dtmf_req_etsi_f2_amp_min_v = 0.2661;
            o.g_dtmf_req_etsi_f2_amp_max_v = 0.4467;
            o.g_dtmf_req_etsi_f2_f1_diff_min_db = 1.0;
            o.g_dtmf_req_etsi_f2_f1_diff_max_db = 4.0;
            o.g_dtmf_req_etsi_duration_min_ms = 25;
            o.g_dtmf_req_etsi_total_unwanted_power_max_dB = 20;
            o.g_dtmf_etsi_f1_amp_v = 0.5 * (o.g_dtmf_req_etsi_f1_amp_min_v + o.g_dtmf_req_etsi_f1_amp_max_v);
            o.g_dtmf_etsi_f2_amp_v = 0.5 * (o.g_dtmf_req_etsi_f2_amp_min_v + o.g_dtmf_req_etsi_f2_amp_max_v);

            % ETSI compliant DTMF
            A1 = o.g_dtmf_etsi_f1_amp_v;
            A2 = o.g_dtmf_etsi_f2_amp_v;
            o.g_dtmf_1_etsi = A1*sin(2*pi*o.g_dtmf_1_f1*o.g_t) + A2*sin(2*pi*o.g_dtmf_1_f2*o.g_t);
            o.g_dtmf_2_etsi = A1*sin(2*pi*o.g_dtmf_2_f1*o.g_t) + A2*sin(2*pi*o.g_dtmf_2_f2*o.g_t);
            o.g_dtmf_3_etsi = A1*sin(2*pi*o.g_dtmf_3_f1*o.g_t) + A2*sin(2*pi*o.g_dtmf_3_f2*o.g_t);
            o.g_dtmf_A_etsi = A1*sin(2*pi*o.g_dtmf_A_f1*o.g_t) + A2*sin(2*pi*o.g_dtmf_A_f2*o.g_t);
            o.g_dtmf_4_etsi = A1*sin(2*pi*o.g_dtmf_4_f1*o.g_t) + A2*sin(2*pi*o.g_dtmf_4_f2*o.g_t);
            o.g_dtmf_5_etsi = A1*sin(2*pi*o.g_dtmf_5_f1*o.g_t) + A2*sin(2*pi*o.g_dtmf_5_f2*o.g_t);
            o.g_dtmf_6_etsi = A1*sin(2*pi*o.g_dtmf_6_f1*o.g_t) + A2*sin(2*pi*o.g_dtmf_6_f2*o.g_t);
            o.g_dtmf_B_etsi = A1*sin(2*pi*o.g_dtmf_B_f1*o.g_t) + A2*sin(2*pi*o.g_dtmf_B_f2*o.g_t);
            o.g_dtmf_7_etsi = A1*sin(2*pi*o.g_dtmf_7_f1*o.g_t) + A2*sin(2*pi*o.g_dtmf_7_f2*o.g_t);
            o.g_dtmf_8_etsi = A1*sin(2*pi*o.g_dtmf_8_f1*o.g_t) + A2*sin(2*pi*o.g_dtmf_8_f2*o.g_t);
            o.g_dtmf_9_etsi = A1*sin(2*pi*o.g_dtmf_9_f1*o.g_t) + A2*sin(2*pi*o.g_dtmf_9_f2*o.g_t);
            o.g_dtmf_C_etsi = A1*sin(2*pi*o.g_dtmf_C_f1*o.g_t) + A2*sin(2*pi*o.g_dtmf_C_f2*o.g_t);
            o.g_dtmf_star_etsi = A1*sin(2*pi*o.g_dtmf_star_f1*o.g_t) + A2*sin(2*pi*o.g_dtmf_star_f2*o.g_t);
            o.g_dtmf_0_etsi= A1*sin(2*pi*o.g_dtmf_0_f1*o.g_t) + A2*sin(2*pi*o.g_dtmf_0_f2*o.g_t);
            o.g_dtmf_hash_etsi = A1*sin(2*pi*o.g_dtmf_hash_f1*o.g_t) + A2*sin(2*pi*o.g_dtmf_hash_f2*o.g_t);
            o.g_dtmf_D_etsi = A1*sin(2*pi*o.g_dtmf_D_f1*o.g_t) + A2*sin(2*pi*o.g_dtmf_D_f2*o.g_t);

            o.dtmf_etsi_symbol_arr = [ '0' '1' '2' '3' '4' '5' '6' '7' '8' '9' 'A' 'B' 'C' 'D' '*' '#'];

            o.g_dtmf_etsi = zeros(16,o.g_Fs);
            o.g_dtmf_etsi(1,:) = o.g_dtmf_0_etsi;
            o.g_dtmf_etsi(2,:) = o.g_dtmf_1_etsi;
            o.g_dtmf_etsi(3,:) = o.g_dtmf_2_etsi;
            o.g_dtmf_etsi(4,:) = o.g_dtmf_3_etsi;
            o.g_dtmf_etsi(5,:) = o.g_dtmf_4_etsi;
            o.g_dtmf_etsi(6,:) = o.g_dtmf_5_etsi;
            o.g_dtmf_etsi(7,:) = o.g_dtmf_6_etsi;
            o.g_dtmf_etsi(8,:) = o.g_dtmf_7_etsi;
            o.g_dtmf_etsi(9,:) = o.g_dtmf_8_etsi;
            o.g_dtmf_etsi(10,:) = o.g_dtmf_9_etsi;
            o.g_dtmf_etsi(11,:) = o.g_dtmf_A_etsi;
            o.g_dtmf_etsi(12,:) = o.g_dtmf_B_etsi;
            o.g_dtmf_etsi(13,:) = o.g_dtmf_C_etsi;
            o.g_dtmf_etsi(14,:) = o.g_dtmf_D_etsi;
            o.g_dtmf_etsi(15,:) = o.g_dtmf_star_etsi;
            o.g_dtmf_etsi(16,:) = o.g_dtmf_hash_etsi;

            o.g_dtmf_etsi_freqs = [941 1336; 697 1209; 697 1336; 697 1477; 
                770 1209; 770 1336; 770 1477; 852 1209; 852 1336; 852 1477; 
                697 1633; 770 1633; 852 1633; 941 1633; 941 1209; 941 1477];

            MAX_FRACTION_LEN = 50;
            TEST_VECTOR_LEN = 100;
            o.MAX_FRACTION_LEN = MAX_FRACTION_LEN;
            o.TEST_VECTOR_LEN = TEST_VECTOR_LEN;
            o.g_dtmf_v_valid = zeros(16,MAX_FRACTION_LEN, TEST_VECTOR_LEN);
            o.g_dtmf_v_invalid_amp = zeros(16,MAX_FRACTION_LEN, TEST_VECTOR_LEN);
            o.g_dtmf_v_invalid_amp_diff = zeros(16,MAX_FRACTION_LEN, TEST_VECTOR_LEN);
            o.g_dtmf_v_invalid_amp_and_freq = zeros(16,MAX_FRACTION_LEN, TEST_VECTOR_LEN);
            o.g_dtmf_v_invalid_freq_diff = zeros(16,MAX_FRACTION_LEN, TEST_VECTOR_LEN);
            o.g_dtmf_v_not_a_dtmf = zeros(16,MAX_FRACTION_LEN, TEST_VECTOR_LEN);

            o.DTMF_START = 50; % where the symbol starts

            fd = ["sounds/music1_8000.wav" "sounds/music2_8000.wav" "sounds/music3_8000.wav" "sounds/music4_8000.wav"];
            o.g_files = zeros(4, 8000*60);
            for i=1:4
                [o.g_files(i,:), ~] = audioread(fd(i),[1,8000*60]);
            end

            for i=1:16      % DTMF symbols in g_dtmf_etsi order
                for j=1:50  % fraction length in samples

                    % Create test vectors

                    % Valid DTMF
                    s = zeros(1,TEST_VECTOR_LEN);
                    d = o.g_dtmf_etsi(i,:);
                    s(o.DTMF_START:o.DTMF_START+j-1) = d(1:j);
                    o.g_dtmf_v_valid(i,j,:) = s;

                    % Invalid DTMF
                    % 1, no diff between amplitudes
                    t = (0:1:j-1)/o.g_Fs;
                    A1 = 1;
                    A2 = 1;
                    s = zeros(1,TEST_VECTOR_LEN);
                    s(o.DTMF_START:o.DTMF_START+j-1) = A1*sin(2*pi*o.g_dtmf_etsi_freqs(i,1)*t) + A2*sin(2*pi*o.g_dtmf_etsi_freqs(i,2)*t);
                    o.g_dtmf_v_invalid_amp(i,j,:) = s;

                    % 2, amplitudes diff too much
                    A1 = o.g_dtmf_req_etsi_f1_amp_min_v*0.95;
                    A2 = o.g_dtmf_req_etsi_f2_amp_max_v*1.05;
                    s = zeros(1,TEST_VECTOR_LEN);
                    s(o.DTMF_START:o.DTMF_START+j-1) = A1*sin(2*pi*o.g_dtmf_etsi_freqs(i,1)*t) + A2*sin(2*pi*o.g_dtmf_etsi_freqs(i,2)*t);
                    o.g_dtmf_v_invalid_amp_diff(i,j,:) = s;

                    % 3, freq diff too much (3%) (ETSI req is 1.5% max)
                    A1 = o.g_dtmf_etsi_f1_amp_v;
                    A2 = o.g_dtmf_etsi_f2_amp_v;
                    s = zeros(1,TEST_VECTOR_LEN);
                    s(o.DTMF_START:o.DTMF_START+j-1) = A1*sin(2*pi*((100+2*o.g_dtmf_req_etsi_freq_error_percent)/100)*o.g_dtmf_etsi_freqs(i,1)*t) ...
                                                    + A2*sin(2*pi*((100-2*o.g_dtmf_req_etsi_freq_error_percent)/100)*o.g_dtmf_etsi_freqs(i,2)*t);
                    o.g_dtmf_v_invalid_freq_diff(i,j,:) = s;

                    %4 Amp and freq is wrong
                    A1 = o.g_dtmf_req_etsi_f1_amp_min_v*0.95;
                    A2 = o.g_dtmf_req_etsi_f2_amp_max_v*1.05;
                    s = zeros(1,TEST_VECTOR_LEN);
                    s(o.DTMF_START:o.DTMF_START+j-1) = A1*sin(2*pi*((100+2*o.g_dtmf_req_etsi_freq_error_percent)/100)*o.g_dtmf_etsi_freqs(i,1)*t) ...
                                                    + A2*sin(2*pi*((100-2*o.g_dtmf_req_etsi_freq_error_percent)/100)*o.g_dtmf_etsi_freqs(i,2)*t);
                    o.g_dtmf_v_invalid_amp_and_freq(i,j,:) = s;

                    % 5 Signals, not being DTMF
                    noise = randn(1,TEST_VECTOR_LEN);
                    sine1 = sin(2*pi*50*o.g_t);
                    sine2 = sine1 + sin(2*pi*240*o.g_t) + sin(2*pi*1740*o.g_t);
                    sine3 = sine2 + sin(2*pi*3450*o.g_t);
                    shift = 8000*30;

                    s = zeros(1,TEST_VECTOR_LEN);
                    switch i
                        case 1
                            s(o.DTMF_START:o.DTMF_START+j-1) = 0.001*noise(o.DTMF_START:o.DTMF_START+j-1);
                        case 2
                            s(o.DTMF_START:o.DTMF_START+j-1) = 0.01*noise(o.DTMF_START:o.DTMF_START+j-1);
                        case 3
                            s(o.DTMF_START:o.DTMF_START+j-1) = 0.1*noise(o.DTMF_START:o.DTMF_START+j-1);
                        case 4
                            s(o.DTMF_START:o.DTMF_START+j-1) = 0.5*noise(o.DTMF_START:o.DTMF_START+j-1);
                        case 5
                            s(o.DTMF_START:o.DTMF_START+j-1) = 1.2*noise(o.DTMF_START:o.DTMF_START+j-1);
                        case 6
                            s(o.DTMF_START:o.DTMF_START+j-1) = 0.6*sine1(o.DTMF_START:o.DTMF_START+j-1);
                        case 7
                            s(o.DTMF_START:o.DTMF_START+j-1) = 0.3*sine2(o.DTMF_START:o.DTMF_START+j-1);
                        case 8
                            s(o.DTMF_START:o.DTMF_START+j-1) = 0.2*sine3(o.DTMF_START:o.DTMF_START+j-1);
                        case 9
                            x = o.g_files(1,:);
                            s(o.DTMF_START:o.DTMF_START+j-1) = x(o.DTMF_START:o.DTMF_START+j-1);
                        case 10
                            x = o.g_files(1,:);
                            s(o.DTMF_START:o.DTMF_START+j-1) = x((o.DTMF_START:o.DTMF_START+j-1)+shift);
                        case 11
                            x = o.g_files(2,:);
                            s(o.DTMF_START:o.DTMF_START+j-1) = x((o.DTMF_START:o.DTMF_START+j-1)+shift);
                        case 12
                            x = o.g_files(2,:);
                            s(o.DTMF_START:o.DTMF_START+j-1) = x((o.DTMF_START:o.DTMF_START+j-1)+shift);
                        case 13
                            x = o.g_files(3,:);
                            s(o.DTMF_START:o.DTMF_START+j-1) = x((o.DTMF_START:o.DTMF_START+j-1)+shift);
                        case 14
                            x = o.g_files(3,:);
                            s(o.DTMF_START:o.DTMF_START+j-1) = x((o.DTMF_START:o.DTMF_START+j-1)+shift);
                        case 15
                            x = o.g_files(4,:);
                            s(o.DTMF_START:o.DTMF_START+j-1) = x((o.DTMF_START:o.DTMF_START+j-1)+shift);
                        case 16
                            x = o.g_files(4,:);
                            s(o.DTMF_START:o.DTMF_START+j-1) = x((o.DTMF_START:o.DTMF_START+j-1)+shift);
                        otherwise
                            error("Oops");
                    end

                    o.g_dtmf_v_not_a_dtmf(i,j,:) = s;
                end
            end
        end
        function [symbol] = dtmf_etsi_idx_2_symbol(o, idx)
            symbol = o.dtmf_etsi_symbol_arr(idx);
        end
        function [idx] = dtmf_etsi_symbol_2_idx(o, symbol)
            idx = find(o.dtmf_etsi_symbol_arr==symbol);
        end
        function [idx] = dtmf_etsi_f1_f2_2_idx(o, f1, f2)
            idx = find(ismember(o.g_dtmf_etsi_freqs,[f1 f2],'rows'));
        end
        function [symbol] = dtmf_etsi_f1_f2_2_symbol(o, f1, f2)
            idx = o.dtmf_etsi_f1_f2_2_idx(f1, f2);
            symbol = o.dtmf_etsi_idx_2_symbol(idx);
        end
    end
end