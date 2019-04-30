classdef SpectrumAnalyser
    properties
        name
        raw_data
        code
        sampling_frequency
        measured_time
        time_vector
        freq_spectrum
        frequencies
        amplitudes
        amplified_amplitudes
    end
    methods
        function this = SpectrumAnalyser(name, sampling_freq)
            disp('Importing sound...')
            if ischar(name)
                    if strcmp(name, this.name)
                    disp('Sound loaded.')
                else
                    this.name = name;
                    sound_data = DataImporter(name);
                    this.raw_data = sound_data;
                    this.sampling_frequency = sampling_freq;
                    this.measured_time = (length(sound_data)-1)/sampling_freq;
                    this.time_vector = 0:1/sampling_freq:this.measured_time;
                    this.raw_data = sound_data;
                    disp('Sound imported! Class initalized!')
                    disp(' ')
                end
            else
                this.raw_data = awgn(name.sound_data, 10, 'measured');
                this.time_vector = name.time_vec;
                this.sampling_frequency = name.sampling_freq;
                disp('Sound imported! Class initalized!'); disp(' ')
            end
            disp('__________________________________________________________________________'); disp(' ')
        end
        function this = analyseSpectrum(this)
            freq = this.frequencies;
            amp = this.amplitudes;
            freq = freq*1000;
            index = find(freq < 300); index = index(end);
            endVal = round((length(amp)/this.sampling_frequency) * 6300*2);
            freq = freq(index:endVal);
            amp = amp(index:endVal);
            [amplitudes, frequencies] = findpeaks(amp, freq, 'MinPeakDistance', 0.08*10^3, 'NPeaks', 6, 'MinPeakHeight', max(amp)/4);
            findpeaks(amp, freq, 'MinPeakDistance', 0.1*10^3, 'NPeaks', 6, 'MinPeakHeight', max(amp)/4);
            this.amplitudes = amplitudes;
            this.frequencies = frequencies;
        end
        function this = calculateFrequencyData(this)
            NFFT = round(length(this.raw_data));
            signal = this.raw_data;
            fs = this.sampling_frequency;
            X = fft(signal, NFFT) / NFFT;
            df = fs / NFFT;
            Amp = abs(X) / sqrt(2);
            AmpSingel = Amp;
            half = round(NFFT/2);
            AmpSingel(2:half) = 2 * Amp(2:half);
            this.amplitudes = AmpSingel(1 : half+1); 
            this.frequencies = (0:half)*df/10^3;
        end
        function this = plotFreqSpectrum(this)
            plot(this.frequencies, this.amplitudes, 'Marker','none', 'LineWidth', 1.5);
            xlabel('Frequency [kHz]'); ylabel('Amp');
            legendcell = strcat('NFFT = ',string(num2cell(length(this.raw_data))));
            legend(legendcell)
            set(gca,'fontsize',20)
                width=1310;
                height=750;
                set(gcf,'units','points','position',[10,10,width,height])
        end
        function this = amplifyActiveFrequencies(this)
            spectrum_data = this.amplitudes;
            spectrum_mean = mean(spectrum_data);
            spectrum_data = round(spectrum_data)./spectrum_mean;
            spectrum_data(spectrum_data < 0) = 0;
            this.amplitudes = (spectrum_data)./log10(spectrum_data);
        end
        function [amp, freq] = getAmpFreq(this)
            amp = this.amplitudes;
            freq = this.frequencies;
        end
    end
end