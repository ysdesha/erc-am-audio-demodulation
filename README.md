# erc-am-audio-demodulation
ERC Convener Assignment – AM Audio Demodulation. This is a part of the ERC Convener Assignment. It involves demodulating a noisy AM (Amplitude Modulated) audio signal using MATLAB. The steps include FFT analysis, sine carrier demodulation, low-pass and band-pass filtering to recover and clean the original audio.

Software used: Matlab

Approach:
1.Loaded the modulated noisy signal using audioread function in matlab.

2. Performed fft to obtain the frequency spectrum and analysed the frequency peaks to determine the carrier frequency (highest peak was found to be around 10000hz)
   Carrier frequencyFc ~ 10000hz
   
3. Demodulation - multiplied the signal with a sine wave at the carrier frequency(Fc)- shifted the spectrum to baseband.
   
4.Low-pass filtering - applied a low-pass filter to isolate the baseband signal.

5.Band-pass filtering – applied a band-pass filter (300 Hz – 3400 Hz) to isolate the human speech frequency range.

6.Plotted all intermediate steps — including FFT, demodulated signal, low-pass filtered output, and final cleaned signal.(using matlab functions)

7.Saved the final cleaned audio using audiowrite.

![Screenshot 2025-04-10 012913](https://github.com/user-attachments/assets/0210dae9-0bff-4053-93e8-3247dbc67f47)



