classdef SoundCreater
  properties 
    code
    sound_data
    time_vec
    sampling_freq
  end
  methods 
    function this = SoundCreater(sampling_freq, frequencies, noise, amplitude, T)
      this.time_vec = 0:(1/sampling_freq):T;
      this.sampling_freq = sampling_freq;
      sound_data = zeros(size(this.time_vec));
      for index = 1:length(frequencies)
        sound_data = amplitude(index) * sin(this.time_vec .* frequencies(index) * 2* pi * noise(index)) + sound_data;
      end
      this.sound_data = sound_data;
    end
    function [sound, time] = getData(this)
      sound = this.sound_data;
      time = this.time_vec;
    end
    function this = plotSound(this)
      plot(this.time_vec, this.sound_data, 'Marker','none', 'LineWidth', 1.5);
            xlabel('Time [s]'); ylabel('Amplitude'); xlim([0 0.008]); ylim([-5.5 5.5]);
    end
    function this = noisify(this)
      sound_data = this.sound_data;
      noise = wgn(1,length(sound_data), 1);
      sound_data = sound_data + noise*10;
      this.sound_data = sound_data;
    end
  end
end