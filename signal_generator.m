function signal = signal_generator(input)
    % process parameters
    input.frequency = frequency_alignment(input);
    frequency_components = length(input.amplitude);
    n = 0:input.sample_numbers - 1;
    T_s = 1/(input.sample_frequency);
    signal = zeros(1, length(n)) + input.dc_bias;
    if (strcmp(input.waveform, 'sin')); waveform = 1; else; waveform = 2; end
    if (strcmp(input.noise_type, 'White')); noise_type = 1; else; noise_type = 2; end
    % generating noisless waveform
    switch(waveform)
        case 1
            for i = 1:frequency_components
                component = input.amplitude(i)*sin(2*pi*input.frequency(i)*n*T_s);
                signal = signal + component;
            end
        case 2
            for i = 1:frequency_components
                m = 0;
                wave = [];
                for j = 0:input.sample_numbers - input.zero_pad - 1
                    if (j*T_s - m/(2*input.frequency(i)) <= 1/(2*input.frequency(i)))
                        if (mod(m, 2) == 0); wave = [wave, input.amplitude(i)]; else; wave = [wave, -input.amplitude(i)]; end
                        if ((j+1)*T_s - m/(2*input.frequency(i)) > 1/(2*input.frequency(i))); m = m + 1; end
                    end
                end
                signal = signal + wave;
            end
    end
    % generating noise
    switch(noise_type)
        case 1
            noise = pinknoise(length(n))';
            noise_power = sum(noise.^2,1)/size(noise,1);
            signal_power = sum(signal.^2,2)/size(signal, 2);
            if (signal_power ~= 0)
                noise_floor_linear = 10*((input.noise_floor/10) + 2.3);
                desired_SNR = 10*log10(signal_power./(10.^(noise_floor_linear/10)));
                scale_factor = sqrt(signal_power./(noise_power.*(10.^(desired_SNR/10))));
                noise = noise.*scale_factor;
            end
        case 2
            noise_floor_linear = 10*((input.noise_floor/10) + 2.3);
            noise = wgn(length(n), 1, noise_floor_linear, 'real')';
    end
    % adding noise to waveform
    signal = signal + noise;
    signal = [signal, zeros(1, input.zero_pad + 1)];
    % quantising - generating signal 
    if (input.quantise_status)
        signal = quantizenumeric(signal, input.signed_status, input.word_length, input.fraction_width, 'nearest');
    end
    % generating plot
    n = 0:1:length(signal)-1;
    if (input.signal_plot_status)
        figure;
        plot(n, signal, 'blue');
        title('Time Series Plot of Signal');
        xlabel('Sample number (n)');
        ylabel('Signal Amplitude (V)'); 
        grid on;
end