%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Direct Sequence Spread Spectrum
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clc;
clear;
close all;
% Generating the bit pattern with each bit 4 samples long
b             = [0,1,1,0,0];
bitLen        = length(b);
pattern       = [];
for k = 1:bitLen
    if b(1,k)==0
        sig = zeros(1,4);
    else
        sig = ones(1,4);
    end
    pattern   = [pattern sig];
end
% Generating the pseudo random bit pattern for spreading
spread_sig   = round(rand(1,bitLen*4));
% XORing the pattern with the spread signal
hopped_sig   = xor(pattern,spread_sig);
% Modulating the hopped signal
dsss_sig     = [];
N            = 30;
n            = 0:1:N-1;
fs           = 48000;  %% Sampling frequency
fc           = 2000;   %% frequency 1
dt           = 1/fs;
t            = n*dt;
c1           = cos(2*pi*fc*t);
c2           = cos(2*pi*fc*t+pi);
for k =1:bitLen*4
    if hopped_sig(1,k)==0
        dsss_sig = [dsss_sig c1];
    else
        dsss_sig = [dsss_sig c2];
    end
end
df           = fs/(bitLen*4*N);
tVec         = (0:1:bitLen*4*N-1)*dt;
fVec         = (0:1:bitLen*4*N-1)*df;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure(1);
subplot(2,1,1);
stem(pattern);
axis([-1 22 -0.5 1.5]);
title('\bf\it Original Bit Sequence');
subplot(2,1,2);
stem(spread_sig);
axis([-1 22 -0.5 1.5]);
title('\bf\it Pseudorandom Bit Sequence');
figure(2);
subplot(2,1,1);
plot(tVec,dsss_sig);
title('\bf\it DSSS Signal');
% Plotting the FFT of DSSS signal
subplot(2,1,2);
plot(fVec,abs(fft(dsss_sig)));
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%