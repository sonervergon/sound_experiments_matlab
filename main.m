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
fileName = 'sounds_sound_6_test_noise.txt'; % sounds_sound_6_freq.txt  sounds_sound_6_test_noise.txt
noises = [1 1 1 1 1 1];
amplitudes = [1 1 1 1 1 1];
code = [5 2 3 4 6 9];
sampling_freq = 44100;
[frequencies, code] = IndexMapper(code, 'array');
fileName = SoundCreater(sampling_freq, frequencies, noises, amplitudes);
fileName = fileName.plotSound();
SA = SpectrumAnalyser(fileName, sampling_freq);

%%
% Use class

SA = SA.calculateFrequencyData();
SA.plotFreqSpectrum();
[amp, freq] = SA.getAmpFreq();
figure(200)
SA = SA.analyseSpectrum();

calculatedCode = IndexMapper(SA.frequencies/1000, 'code');
if strcmp(code, calculatedCode)
    disp('Calculated code matches the sound signature!') 
    disp(code)
else
    disp(calculatedCode)
end







