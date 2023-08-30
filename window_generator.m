function [window] = window_generator(input)
    % process parameters
    n = 0:input.sample_numbers;
    input.zeros_symmetric = input.sample_numbers^2;
    window_components = length(input.window_type);
    colour = {'blue', 'red', 'green', 'cyan', 'black', 'magenta'};
    % generating window
    for i = 1:window_components
        switch input.window_type{i}
            case 'Rectangular'
                component = ones(1, length(n));
            case 'Triangular'
                component = conv(ones(1, length(n)/2+1), ones(1, length(n)/2)+1)/length(n);
            case 'Cos'
                component = sin(pi*n/length(n));
            case 'Hanning'
                component = 0.5 - 0.5*cos(2*pi*n/length(n));        
            case 'Cos^3'
                component = sin(pi*n/length(n)).^3;
            case 'Cos^4'
                component = sin(pi*n/length(n)).^4;
            case 'Hamming'
                component = 0.54 - 0.46*cos(2*pi*n/length(n));
            case 'Exact Blackman'
                component = 0.4266 - 0.4966*cos(2*pi*n/length(n)) + 0.07685*cos(4*pi*n/length(n));
            case 'Blackman'
                component = 0.42 - 0.50*cos(2*pi*n/length(n)) + 0.08*cos(4*pi*n/length(n));
            case 'Flat-top'
                component = 0.2156 - 0.4166*cos(2*pi*n/length(n)) + 0.27726*cos(4*pi*n/length(n)) - 0.08358*cos(6*pi*n/length(n)) + 0.00695*cos(8*pi*n/length(n));
            case 'Blackman-Harris 2-term'
                component = 0.53856 - 0.46144*cos(2*pi*n/length(n));
            case 'Blackman-Harris 3-term'
                component = 0.42323 - 0.49755*cos(2*pi*n/length(n)) + 0.07922*cos(4*pi*n/length(n));
            case 'Blackman-Harris 4-term'
                component = 0.36 - 0.49*cos(2*pi*n/length(n)) + 0.14*cos(4*pi*n/length(n)) - 0.01*cos(6*pi*n/length(n));
        end
        window(i, 1:input.sample_numbers + 1) = component;
        window_plot(i, 1:input.sample_numbers + input.zeros_symmetric + 1) = [component, zeros(1,input.zeros_symmetric)];
    end
    % generating a plot for window and their FFT
    if (input.window_plot_status)
        % Finding FFT for plot
        m = 0:(input.sample_numbers + input.zeros_symmetric + 1)/2;
        for i = 1:window_components
            window_magnitude_fft(i, 1:input.sample_numbers + input.zeros_symmetric) = abs(fft(window_plot(i, 1:input.sample_numbers + input.zeros_symmetric))/(input.sample_numbers + input.zeros_symmetric));
            window_fft(i, 1:length(m)) = zeros(1, length(m));
            window_fft(i, 1) = 20*log10(window_magnitude_fft(i, 1));
            window_fft(i, 2:length(m)) = 20*log10(2*window_magnitude_fft(i, 2:length(m)));
        end
        % window graph and FFT
        figure;
        n = 0:input.sample_numbers;
        subplot(2, 1, 1);   % time series of window function
        hold on
        for i = 1:window_components
            plot(n, window(i, 1:length(n)), colour{i}, 'DisplayName', input.window_type{i});
        end
        legend(input.window_type, 'Location', 'Best');
        hold off
        title(append('Time Series Plot of Window'));
        xlabel('Sample number (n)');
        ylabel('Amplitude (V)');
        grid on;
        subplot(2, 1, 2);   % window function FFT
        hold on
        for i = 1:window_components
            plot(log(m), window_fft(i, 1:length(m)), colour{i}, 'DisplayName', input.window_type{i});
        end
        legend(input.window_type, 'Location', 'Best');
        hold off
        title(append('Single Sided FFT of Window'));
        xlim([5, 10]); 
        ylim([-180, -30]);
        xlabel('FFT bin (log_{10}(m)');
        ylabel('Amplitude (dB)');
        grid on;
    end
end