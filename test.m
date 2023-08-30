clear all
close all

N= 32;                            % number of time samples
win= hanning(N,'periodic');       % hanning window
win_norm= win/sum(win);           % scale window for |h(0)| = 1
% NFFT-point FFT of N-point window function
fs= 16;                               % Hz sample frequency
L= 32;
NFFT= L*N;
k= 0:NFFT/2-1;                        % freq index for NFFT-point FFT
f= k*fs/NFFT;                         % Hz frequency vector
h = fft(win_norm,NFFT);                    % FFT of length NFFT (zero padded)
h= h(1:NFFT/2);                       % retain points from 0 to fs/2
HdB= 20*log10(abs(h));                % dB magnitude of fft

 

subplot(2,1,1); stem(win); grid on; xlim([0 L]); ylim([0 1.1]); 
title('Window in time domain'); xlabel('n');
subplot(2,1,2); plot(HdB); grid on; xlim([0 512]); ylim([-80 5]);
title('Spectrum of the Window'); xlabel('f'); ylabel('dB');
xticks([0:64:512]);xticklabels({'0', '2fs/N', '4fs/N', '8fs/N', '10fs/N', '12fs/N', '14fs/n', '16fs/N'})