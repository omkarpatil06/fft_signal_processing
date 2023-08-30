function signal_dft(input)
    % generating signal for dft
    input.signal_plot_status = 0;                
    input.window_plot_status = 0;               
    signal = signal_generator(input);
    window = window_generator(input);
    window_components = size(window,1);
    signal_dft = [];
    % process parameters
    m = 0:length(signal)/2-1;
    analysis_frequency = input.sample_frequency*m/input.sample_numbers;
    fundamental_frequency = exp(-1j*2*pi/(length(signal)));
    [k, n] = meshgrid(1:length(signal), 1:length(signal));
    matrix_dft = fundamental_frequency.^((k-1).*(n-1));
    % determining dft of signal
    for i = 1:window_components
        component(1:length(signal) - input.zero_pad) = signal(1:length(signal) - input.zero_pad).*window(i, 1:length(signal) - input.zero_pad);
        component(length(signal) - input.zero_pad + 1: length(signal)) = signal(length(signal) - input.zero_pad + 1: length(signal));
        component_vector = component';
        signal_dft_raw = matrix_dft*component_vector;
        signal_magnitude_dft = abs(signal_dft_raw'/length(signal));
        if (input.dB_status)
            signal_dft(i, 1) = 20*log10(signal_magnitude_dft(1));
            signal_dft(i, 2:length(m)) = 20*log10(2*signal_magnitude_dft(2:length(m)));
            label = 'Amplitude (dB)';
        else
            signal_dft(i, 1) = signal_magnitude_dft(1);
            signal_dft(i, 2:length(m)) = 2*signal_magnitude_dft(2:length(m));
            label = 'Amplitude (V)';
        end
    end
    % plotting spectrums
    if (input.dft_plot_status)
        figure;
        hold on
        for i = 1:window_components
            subplot(round(window_components/2), 2, i)
            plot(analysis_frequency, signal_dft(i, 1:length(m)), 'magenta');
            title(append('Signal DFT with ', input.window_type{i}, ' Window'));
            xlabel('DFT bin (Hz)');
            ylabel(append(label));
            grid on;
        end
        hold off
    end
end