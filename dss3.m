% Lab 06
% WiCom_3
% By Kashif Shahzad 
% 01-ET-31
% 3rd July 2004
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Direct Sequence Spread Spectrum
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clc
clear
% Generating the bit pattern with each bit 6 samples long
b=[0 1 1 0];
pattern=[];
for k=1:4
    if b(1,k)==0
        sig=zeros(1,31);
    else
        sig=ones(1,31);
    end
    pattern=[pattern sig];
end
subplot(2,2,1);
stem(pattern);
title('\bf\it Original Bit Sequence');

% Generating the pseudo random bit pattern for spreading
spread_sig=round(rand(1,124));
subplot(2,2,2);
stem(spread_sig);
title('\bf\it Pseudorandom Bit Sequence');
% XORing the pattern with the spread signal

hopped_sig=xor(pattern,spread_sig);
% Modulating the hopped signal
dsss_sig=[];
t=[0:1];    
fc=1/124;
c1=cos(2*pi*fc*t);
c2=cos(2*pi*fc*t+pi);
for k=1:124
    if hopped_sig(1,k)==0
        dsss_sig=[dsss_sig c1];
    else
        dsss_sig=[dsss_sig c2];
    end
end
subplot(2,2,3);
stem(dsss_sig);
title('\bf\it DSSS Signal');
% Plotting the FFT of DSSS signal
subplot(2,2,4);
stem(abs(fft(dsss_sig)));