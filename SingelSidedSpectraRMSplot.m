function [AmpSingel,df] = SingelSidedSpectraRMSplot(signal,N,fs)
i=0;
for NFFT = N
        i=i+1;
    X=fft(signal,NFFT)/NFFT;
    df=fs/NFFT;
    Amp = abs(X)/sqrt(2);
    AmpSingel = Amp;
    AmpSingel(2:NFFT/2) = 2*Amp(2:NFFT/2);
    plot((0:NFFT/2)*df/10^3,AmpSingel(1 : NFFT/2+1), 'Marker','none','LineWidth',1.5)
    hold on
end
legendcell = strcat('NFFT = ',string(num2cell(N)));
legend(legendcell)
set(gca,'fontsize',20)
    width=1310;
    height=750;
    set(gcf,'units','points','position',[10,10,width,height])
end

