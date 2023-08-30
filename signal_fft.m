function signal_fft(input)
    % generating signal for fft
    signal = signal_generator(input);
    window = window_generator(input);    
    % process parameters
    m = 0:length(signal)/2-1;
    analysis_frequency = input.sample_frequency*m/input.sample_numbers;
    window_components = size(window,1);
    signal_fft = [];
    % determining fft of signal
    for i = 1:window_components
        component(1:length(signal) - input.zero_pad) = signal(1:length(signal) - input.zero_pad).*window(i, 1:length(signal) - input.zero_pad);
        component(length(signal) - input.zero_pad + 1: length(signal)) = signal(length(signal) - input.zero_pad + 1: length(signal));
        signal_magnitude_fft = abs(fft(component)/(length(signal)));
        if (input.dB_status)
            signal_fft(i, 1) = 20*log10(signal_magnitude_fft(1));
            signal_fft(i, 2:length(m)) = 20*log10(2*signal_magnitude_fft(2:length(m)));
            label = 'Amplitude (dB)';
        else
            signal_fft(i, 1) = signal_magnitude_fft(1);
            signal_fft(i, 2:length(m)) = 2*signal_magnitude_fft(2:length(m));
            label = 'Amplitude (V)';
        end
    end
    % plotting spectrums
    if (input.fft_plot_status)
        figure;
        hold on
        for i = 1:window_components
            subplot(round(window_components/2), 2, i)
            plot(analysis_frequency, signal_fft(i, 1:length(m)), 'magenta');
            title(append('Signal FFT with ', input.window_type{i}, ' Window'));
            xlabel('FFT bin (Hz)');
            ylabel(append(label));
            grid on;
        end
        hold off
    end
end