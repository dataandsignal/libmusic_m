# libmusic_m

This is a MATLAB implementation of spectral methods based on signal space decomposition.
The idea behind those methods is to decompose noisy signal into pure signal and noise.
Methods provided here are:
- MUSIC (and special case of Pisarenko)
- EV
- Minimum Norm

You will find examples in **examples** folder and tests in **tests** folder.
There is also specific support for DTMF (dual tone signals), including a toy testing framework for them. Just ignore them or reuse that for your own purposes.

# Using in MATLAB
1. Add <b>core</b> folder to your path
2. Create a method handle

        method = lm_spectral_method(kind, M, 2*P);

where <b>kind</b> is one of `pisarenko/music/ev/mn`, <b>M</b> is autocorrelation order and <b>P</b> is number of real signal sources.

3. Process your samples

        [Vy,Vx,Ve,A,Ry] = method.process(y)

4. Compute PSD

        fs = linspace(1,4000,4000);
        [X2,d2] = method.psd(method, fs, Fs);
        plot(fs,X2)
        
![2tone_psd](https://user-images.githubusercontent.com/40000574/190016488-6add0a3b-7601-44cb-a37e-6b01adf37529.jpg)


5. Get frequency components by eigenrooting (roots of the Z-transforms of noise eigenvectors)

        [fs] = method.eigenrooting(Fs, 0, 0)


6. Get frequency components by peak searching

        [peaks, pmu] = method.peaks(fs, Fs, 0)


7. Get amplitudes by correlation method

        A = method.single_tone_amplitude(peaks(1), peaks(2), Fs)
        A = method.dual_tone_amplitude(peaks(1), peaks(2), Fs)

8. Get amplitudes by eigenvector method (solving eigen equations)

        A = method.solve_for_amplitudes([f1 f2 f3], Fs)


 
This is MATLAB sandbox for [libmusic](https://github.com/dataandsignal/libmusic)

Copyright (C) 2022, Piotr Gregor piotr@dataandsignal.com

![lm5](https://user-images.githubusercontent.com/40000574/190017795-051ef15c-404d-4868-a0e3-dc462e838632.jpg)

## Performance in noise

In a noisy environment, MUSIC performs well as long as SNR is above 66.53 dB.


## Applications

In telephony, DTMF symbols must be removed from stream, due too sensitive data protection. Often though, fractions of those DTMFs are left in a stream and must be removed. This cannot be done with Goertzel algorithm as it needs more than 110 samples to achieve right frequency resolution, to be able to detect DTMF frequencies. An example of such DTMF fraction is shown on the picture. This one is 14 samples in length (1.75 ms at a sampling rate of 8000 Hz).

![dtmf_test_vector_valid](https://user-images.githubusercontent.com/40000574/190151206-2e7b78a0-0d79-459f-bf8f-cf422fd9da72.jpg)

With MUSIC, samples requirement is reduced from 110 to 8 and frequency resolution (accuracy) increased from 72.73 Hz to 10^-2 Hz in the same time.
This picture presents correctness as a percentage of detected fractions of dual tone signals (DTMFs), by input vector length **N** (8,9,10,11,12,14), autocorrelation order **M** (4-8) and fraction length **L** (8-28 samples).

![dtmf_test_valid_freq_2](https://user-images.githubusercontent.com/40000574/190152713-0254f77f-af44-45fc-8f34-e4b8a57742d5.jpg)


For example, using a block of N=12 samples, all fractions of length L=10 and above can be detected (with autocorrelation order M={6,7}). N=8 detects all fractions longer than 8 samples (1 ms) with M=4.


## Discussion

If you have any questions, or would like to share your thoughts, 
request new features, etc. - please post them to [Discussions](https://github.com/dataandsignal/libmusic_m/discussions).


## Issues

If you would like to report an issue, please do it on [issues](https://github.com/dataandsignal/libmusic_m/issues) page.


## C library

A C library built on these results is [libmusic](https://github.com/dataandsignal/libmusic)


## Repository 

URL: https://github.com/dataandsignal/libmusic_m


## Further reading, references

A good references about spectral analysis and space decomposition methods are:

- Hayes M. H., Statistical Digital Signal Processing And Modeling, Georgia Institute of Technology, Wiley, 2008
- Lawrence Marple S. Jr., Digital Spectral Analysis, Dover Publications, 2019
- Schmidt R. O., Multiple Emitter Location and Signal Parameter Estimation, IEEE Transactions on Antennas and Propagation, Vol. AP-34, No. 3, 1986

These references are missing (or skipping it intentionally) a crucial result about autocorrelation and sinusoids embedded in a vector space whose elements are shifted samples of that same sinusoid (with all the phases). If you are asking yourself why this is autocorrelation that is being exploited in spectral analysis, you won't find this answer there - at least not explicit, or I could not. If these papers skip it deliberately - they should not, cause this is a fundamental finding space decomposition methods are built on. This is explained in:

- Penny W. D., Signal Processing Course, University College London, 2000

- and also in my own [engineering thesis](https://github.com/dataandsignal/libmusic_m/files/9567833/praca_inz_gregor.pdf)
, (it's in polish, will be translated to english) 


## Copyright 

LIBMUSIC

Copyright (C) 2018-2022, Piotr Gregor piotr@dataandsignal.com

August 2022
