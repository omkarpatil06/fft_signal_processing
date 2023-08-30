% clearing and closing data from last script run
clear all;
close all;

% input parameters and configurigations for FFT
input_config = struct;
% QUANTISATION
input_config.signed_status = 1;
input_config.word_length = 24;
input_config.fraction_width = 20;
% SIGNAL PARAMETER
input_config.waveform = 'sin';                      % Options: 'sin' or 'square'
input_config.amplitude = [1];                 % linear scale
input_config.frequency = [2000];        % units are in Hz
input_config.dc_bias = 1;                           % linear scale
input_config.zero_pad = 0;                 
% NOISE PARAMETER
input_config.noise_type = 'white';                  % Options: 'white' or 'pink'
input_config.noise_floor = -50;                     % dB scale
% WINDOW PARAMETER
input_config.window_type = {'Rectangular'};
input_config.zeros_symmetric = 0;                  % IMPORTANT: Always 0 for FFT and even otherwise
% FFT SETUP
input_config.sample_numbers = 2.^12 - 1;             % IMPORTANT: Odd number
input_config.sample_frequency = 48000;              % units are in Hz 
input_config.frequency_alignment = 0;               % align frequency bins on or off
% CONFIGURATION
input_config.quantise_status = 0;                   % quantise signal data or not
input_config.dB_status = 1;                         % graph dB status or not
input_config.signal_plot_status = 1;                % Figure 1
input_config.window_plot_status = 0;                % Figure 2
input_config.fft_plot_status = 1;                   % Figure 3
input_config.dft_plot_status = 0;                   % Figure 4

signal_fft(input_config);
% signal_dft(input_config);
