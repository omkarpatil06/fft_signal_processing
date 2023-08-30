# Fourier Transform: Signal Processing
This project aims to explore the software implementation of the Fourier transform using MATLAB. It involves several key concepts like quantization, noise, spectral leakage, windowing, scalloping loss, processing losses, zero-padding, and different matrix implementations.

The initial phase focused on creating a signal generator capable of producing quantized control signals with variable frequency components. These signals underwent conditioning using various window functions. Subsequently, the frequency transformed versions of these signals were computed. To achieve this, a Discrete Fourier Transform (DFT) function was developed. This function calculated the single-sided DFT by utilizing matrix multiplication involving an NxN twiddle factor matrix and an Nx1 signal vector. Finally, the outcomes were validated against a reliable reference by utilizing the built-in MATLAB FFT function.

## File Structure
The sequence of documents employed in this project are described bellow in a chronological order of obtaining the transform:

1. `main.m`: Allows to configure the signal and processing parameters. These are namely: word size and fraction width for quantization, signal amplitude and frequency, noise type (white or pink) and its level, window options, as well as sampling number and frequency.

2. `frequency_alignment.m`: If activated in `main`, this module adjusts the frequencies to align with the nearest spectrum bin frequency.

3. `signal_generator.m`: Using the parameters in `main`, this script generates the desired signal. It accommodates two waveform choices: sine and square waves.

4. `window_generator.m`: Taking inputs from `main`, this script generates the appropriate window function to be applied to the signal. It supports multiple window types, including notable ones such as Hanning, Hamming, Flat-top, Blackman-Harris 3-term and 4-term.

5. `signal_dft.m`: This script processes the windowed signal by multiplying with a twiddle factor matrix to compute the DFT. The result is transformed into a single-sided magnitude spectrum.

6. `signal_fft.m`: In this step, the windowed signal serves as input to MATLAB's built-in FFT function. The signal is transformed into a single-sided magnitude spectrum, similar to the previous step.

## Results after each step
The paramters configured in `main` are specified in their respective section bellow.
### Signal Generator
The signal parameters listed bellow yields the following figure: 

- *Quantisation*: `signed = 1`, `word_size = 24`, `fraction_width = 20`
- *Signal*: `waveform = sin`, `amplitude = [1, 1, 1]` V, `frequency = [2000, 6000, 10000]` Hz, `dc_bias = 1` V, `zero_pad = 100`
- *Noise*: `noise_type = white`, `noise_floor = -50 dB`
- *Sampling*: `sample_numbers = 1024`, `sample_frequency = 48000 Hz`

<img src="https://github.com/omkarpatil06/fft_signal_processing/assets/94877472/acae7384-ab73-4c2e-85d7-65f309fde154" width="600" height="400" />

### Window Generator
The window selected bellow, have the following window spectrums. A trade-off is observed between main-lobe width, first side-lobe level and side-lobe fall-off.

<img src="https://github.com/omkarpatil06/fft_signal_processing/assets/94877472/f1b4a92d-a308-4ed9-9126-bc650bb188d0" width="600" height="400" />

### Fourier Transform
After applying the selected windows to the signal, their corresponding single-sided DFT and FFT magnitude spectrums are shown bellow.

#### Discrete Fourier Transform
<img src="https://github.com/omkarpatil06/fft_signal_processing/assets/94877472/f39c6055-72a6-4140-b6ed-29f035fedf8c" width="600" height="400" />

#### Fast Fourier Transform
<img src="https://github.com/omkarpatil06/fft_signal_processing/assets/94877472/90268804-3af5-4848-8a90-045123fa41d8" width="600" height="400" />

This project provided an excellent oppurtunity to experiment with the basics of signal processing. It also gave me a practical understanding of concepts such as aliasing and processing gain, which occurs after increasing the sample numbers.
