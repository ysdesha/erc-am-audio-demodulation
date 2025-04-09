% Step 1: Load the modulated audio signal
[mod_signal, Fs] = audioread('modulated_noisy_audio.wav');
t = (0:length(mod_signal)-1)/Fs;
% Step 2: FFT to find carrier frequency
N = length(mod_signal);
Y = fft(mod_signal);
Y_mag = abs(Y)/N;
f = Fs*(0:(N/2))/N;
% Plot FFT to identify carrier frequency
figure;
plot(f, 2*Y_mag(1:N/2+1));
title('FFT of Modulated Signal');
xlabel('Frequency (Hz)');
ylabel('Magnitude');
grid on;
% Estimate Fc from spectrum obtained from fft
Fc = 10000;

% Step 3: Demodulate using sine carrier 
carrier = sin(2 * pi * Fc * t(:));
demod_signal = mod_signal .* carrier;

% Step 4: Apply low-pass filter to recover baseband
lpFilt = designfilt('lowpassiir', 'FilterOrder', 8, ...
         'PassbandFrequency', 4000, 'PassbandRipple', 0.2, ...
         'SampleRate', Fs);
recovered_signal = filter(lpFilt, demod_signal);

% Plot demodulation steps 
figure;

subplot(3,1,1);
plot(t(1:3000), mod_signal(1:3000));
title('1. Original Modulated Signal');
xlabel('Time (s)');
ylabel('Amplitude');

subplot(3,1,2);
plot(t(1:3000), demod_signal(1:3000));
title('2. After Mixing with Carrier (Demodulated)');
xlabel('Time (s)');
ylabel('Amplitude');

subplot(3,1,3);
plot(t(1:3000), recovered_signal(1:3000));
title('3. After Low-pass Filter (Recovered Baseband)');
xlabel('Time (s)');
ylabel('Amplitude');


% Step 5: Apply bandpass filter to clean speech band (300–3400 Hz)
bpFilt = designfilt('bandpassiir','FilterOrder',6, ...
         'HalfPowerFrequency1',300,'HalfPowerFrequency2',3400, ...
         'SampleRate',Fs);
cleaned_signal = filter(bpFilt, recovered_signal);

% Step 6: Plot comparison — unfiltered vs filtered
figure;
subplot(2,1,1);
plot(t(1:3000), mod_signal(1:3000));
title('Original Modulated Signal');
xlabel('Time (s)');
ylabel('Amplitude');

subplot(2,1,2);
plot(t(1:3000), cleaned_signal(1:3000));
title('Filtered Recovered Signal');
xlabel('Time (s)');
ylabel('Amplitude');

% Step 7: Save final filtered audio
audiowrite('9cleaned_audio.wav', cleaned_signal, Fs);
