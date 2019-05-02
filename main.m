warning off;

% Sound pressure data
% p_ref = 2*10^-5;
% Lp = 10*log(raw_data.^2/p_ref^2);

% Random microphone sounds from different devices.
% mac = DataImporter('sound_500Hz_20kHz.txt');
% op = DataImporter('sounds_sound_oneplus.txt'); % One plus

% One plus high freq, seems like there are some kind of filter 
% opHF = DataImporter('sounds_sound_oneplusHF.txt'); 
% op15000 = DataImporter('sounds_sound_op_1500.txt'); 
% op6500 = DataImporter('sounds_sound_op_6500.txt'); 
% op10000 = DataImporter('sounds_sound_op_10000.txt');
opNoise = DataImporter('sounds_sound_6_freq.txt');
% opR = DataImporter('sounds_sound_matte2.txt'); 

% smsng = DataImporter('sounds_sound_erik.txt'); % Samsung


%% Initialize analysing
clc; clear;

% File Properties
fileName = 'sounds_sound_pixel_wn.txt'; % sounds_sound_pixel sounds_sound_6_freq.txt  sounds_sound_6_test_noise.txt
noises = [1 1 1 1 1 1];
amplitudes = 0.5*[1 1 1 1 1 1];
code = [3 6 8 2 9 1];
sampling_freq = 44100;
T = 0.2;
startF = 2000;
marginF = 50;
[frequencies, code] = IndexMapper(code, 'array', startF, marginF);
fileName = SoundCreater(sampling_freq, frequencies, noises, amplitudes, T);
subplot(3,1,1)
title('')
fileName = fileName.plotSound();
grid;
subplot(3,1,2)
fileName.plotSound();
analyser = SpectrumAnalyser(fileName, sampling_freq);

%%
% Use class
close all;
analyser = analyser.calculateFrequencyData();
analyser.plotFreqSpectrum();
figure(200)
analyser = analyser.analyseSpectrum(startF, marginF);

calculatedCode = IndexMapper(analyser.frequencies/1000, 'code',startF, marginF);


% figure(200)
% title('FFT')
% SA = SA.analyseSpectrum();
% figure(300)
% title('PSD')
% SA = SA.calculateFrequencyDataWindowed();
% SA.plotFreqSpectrum();
% [amp, freq] = SA.getAmpFreq();
% figure(400)
% title('PSD')
% SA = SA.analyseSpectrum();

% calculatedCode = IndexMapper(SA.frequencies/1000, 'code');
% if strcmp(code, calculatedCode)
%     disp('Calculated code matches the sound signature!') 
%     disp(code)
% else
%     disp(calculatedCode)
% end

%% White noise test
clear; clc;

noises = [1 1 1 1 1 1];
amplitudes = 0*[1 1 1 1 1 1]; % Amplitude 0.
code = [1 3 3 4 6 9]; 
sampling_freq = 44100;
T = 2;
[frequencies, code] = IndexMapper(code, 'array');
sound = SoundCreater(sampling_freq, frequencies, noises, amplitudes, T);
noise = sound.noisify();
subplot(2,1,1);
noise.plotSound();
title('White Noise, frequency domain')
analyser = SpectrumAnalyser(noise, sampling_freq);
analyser = analyser.calculateFrequencyData();
subplot(2,1,2);
analyser.plotFreqSpectrum();
title('White Noise, time domain')

%% Play WN
clear; clc;
noises = [1 1 1 1 1 1];
amplitudes = 0*[1 1 1 1 1 1]; % Amplitude 0.
code = [1 3 3 4 6 9]; 
sampling_freq = 44100;
T = 3; 
[frequencies, code] = IndexMapper(code, 'array');
noise = SoundCreater(sampling_freq, frequencies, noises, amplitudes, T);
noise = noise.noisify();
noise = noise.sound_data;
sound(noise, sampling_freq);


%% Testing Spectrums
clear; clc; close;
% File Properties
fileName = 'sounds_sound_mac_wn.txt'; 
sampling_freq = 44100;
SA = SpectrumAnalyser(fileName, sampling_freq);
SA = SA.calculateFrequencyData();

noises = [1 1 1 1 1 1];
amplitudes = 0*[1 1 1 1 1 1]; % Amplitude 0.
code = [1 3 3 4 6 9]; 
sampling_freq = 44100;
T = 3; 
[frequencies, code] = IndexMapper(code, 'array');
noise = SoundCreater(sampling_freq, frequencies, noises, amplitudes, T);
noise = noise.noisify();
analyser = SpectrumAnalyser(noise, sampling_freq);
analyser = analyser.calculateFrequencyData();

% Plot white noise
figure(100);
subplot(3,1,1);
analyser.plotFreqSpectrum();
title('Generated white noise input')
grid;


% Plot GP3XL data
subplot(3,1,2);

SA.plotFreqSpectrum(); hold on;
plot(7.772*ones(size(0:4)), 0:4, 'r', 'linewidth', 1.5);
grid; legend('Signal', '7.77 kHz');
title('Spectrum (MacBook Pro, Chrome), analysed result');

% Plot MBP data
subplot(3,1,3);
fileName = 'sounds_sound_pixel_wn.txt'; 
sampling_freq = 48000;
SA = SpectrumAnalyser(fileName, sampling_freq);
SA = SA.calculateFrequencyData();

SA.plotFreqSpectrum(); hold on;
plot(7.772*ones(size(0:4)), 0:4, 'r', 'linewidth', 1.5);
grid; legend('Signal', '7.77 kHz');
title('Spectrum (Google Pixel 3XL, Chrome), analysed result');


%% Test signal and analyse test signal
clear; clc; close all;
noises = [1 1 1 1 1 1];
amplitudes = 0.5*[1 1 1 1 1 1];
code = [3 6 8 2 9 1];
sampling_freq = 44100;
T = 0.2;
startF = 2000;
marginF = 50;
[frequencies, code] = IndexMapper(code, 'array', startF, marginF);
fileName = SoundCreater(sampling_freq, frequencies, noises, amplitudes, T);
subplot(3,1,1)
fileName = fileName.plotSound();
title('Signal zoomed out')
grid;
subplot(3,1,2)
fileName.plotSound();
grid;
title('Close look at signal')
analyser = SpectrumAnalyser(fileName, sampling_freq);

analyser = analyser.calculateFrequencyData();
subplot(3,1,3);
analyser.plotFreqSpectrum();
title('Frequency spectrum of signal')
xlim([0 6]); ylim([0 0.4]);
grid;

figure(200)
analyser = analyser.analyseSpectrum(startF, marginF);
calculatedCode = IndexMapper(analyser.frequencies/1000, 'code',startF, marginF);
disp(calculatedCode)

%% Play test sound
clear; clc; close all;
noises = [1 1 1 1 1 1];
amplitudes = 0.5*[1 1 1 1 1 1];
code = [3 6 8 2 9 1];
sampling_freq = 44100;
T = 3;
startF = 2000;
marginF = 50;
[frequencies, code] = IndexMapper(code, 'array', startF, marginF);
sound_data = SoundCreater(sampling_freq, frequencies, noises, amplitudes, T);
sound(sound_data.sound_data, sampling_freq)









