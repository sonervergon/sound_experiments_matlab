classdef SoundCreater
  properties 
    code
    sound_data
    time_vec
    sampling_freq
  end
  methods 
    function this = SoundCreater(sampling_freq, frequencies, noise, amplitude)
      this.time_vec = 0:(1/sampling_freq):4;
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
            xlabel('Time [s]'); ylabel('Amp'); xlim([0 0.008]); ylim([-5.5 5.5]);
            set(gca,'fontsize',20)
                width=1310;
                height=750;
                set(gcf,'units','points','position',[10,10,width,height])
    end
    function this = noisify(this)
      sound = this.sound_data;
      sound = awgn(sound, 1, 'measured');
      this.sound_data = sound;
    end
  end
end