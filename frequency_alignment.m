function [frequency] = frequency_alignment(input)
    % process parameters
    frequency_components = length(input.amplitude);
    aligned_frequency = [];
    % create an array of aligned frequency
    if(input.frequency_alignment)
        for i = 1:frequency_components
            spectral_resolution = input.sample_frequency/input.sample_numbers;
            frequency_bin_index = round(input.frequency(i)/spectral_resolution);
            aligned_frequency = [aligned_frequency, frequency_bin_index*spectral_resolution];
        end    
    else
        aligned_frequency = input.frequency;
    end
    % set frequencies to aligned frequencies
    frequency = aligned_frequency;
    return    
end