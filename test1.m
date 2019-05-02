%% Initialize analysing
clc; clear; close all;

% File Properties
fileName = 'sounds_sound_pixel_tf1.txt'; % sounds_sound_pixel sounds_sound_6_freq.txt  sounds_sound_6_test_noise.txt
sampling_freq = 48000;
marginF = 50;
startF = 2000;
analyser = SpectrumAnalyser(fileName, sampling_freq);
%% Ploting
clc;
analyser = analyser.calculateFrequencyData();
figure(200)
subplot(2,1,1)
analyser = analyser.analyseSpectrum(startF, marginF);
calculatedCode = IndexMapper(analyser.frequencies/1000, 'code',startF, marginF);
disp(calculatedCode)

%%
clear; clc;
% File Properties
fileName = 'sounds_sound_mac_tf22.txt'; % sounds_sound_pixel sounds_sound_6_freq.txt  sounds_sound_6_test_noise.txt
sampling_freq = 48000;
marginF = 50;
startF = 2000;
analyser = SpectrumAnalyser(fileName, sampling_freq);
%% Ploting
analyser = analyser.calculateFrequencyData();
subplot(2,1,2)
analyser = analyser.analyseSpectrum(startF, marginF);
calculatedCode = IndexMapper(analyser.frequencies/1000, 'code',startF, marginF);
disp(calculatedCode)

displacement = [2340-2150, 3048-2800, 3701-3400, 3918-3600, 4844-4450, 4952-4550]