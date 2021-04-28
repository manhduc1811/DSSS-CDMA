%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Direct Sequence Spread Spectrum
% mducng/SoC/D2/G2touch
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clc;
clear;
close all;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% '0'  58F9A42B
% using MATLAB to generate binary form hexToBinaryVector('58F9A42B')
% 0   1   0   1   1   0   0   0   1   1   1   1   1   0   0   1   1   0   1   0   0   1   0   0   0   0   1   0   1   0   1   1
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Beacon bits 
%b             = [0, 0, 0, 0, 1, 1, 0, 0, 1, 1, 0, 0, 1, 0, 0, 0, 0, 1, 1, 0, 1, 1, 1, 0, 1, 1, 1, 1, 1, 1, 0, 0, 0];
b             = [0,1,1,0];
bitLen        = length(b);
% partern from Beacon bits
pattern       = [];
for k = 1:bitLen
    if b(1,k)==0
        sig = zeros(1,31);
    else
        sig = ones(1,31);
    end
    pattern   = [pattern sig];
end
% DSSS spreading code
dsssZero      = [1 0 1 1 0 0 0 1 1 1 1 1 0 0 1 1 0 1 0 0 1 0 0 0 0 1 0 1 0 1 1];
%dsssOne       = [1 0 1 0 0 1 1 1 0 0 0 0 0 1 1 0 0 1 0 1 1 0 1 1 1 1 0 1 0 1 0 0];
spread_sig    = [];
for k = 1:bitLen
    spread_sig   = [spread_sig dsssZero];
end
% XORing the pattern with the spread signal
hopped_sig    = xor(pattern,spread_sig);
% Modulating the hopped signal
dt            = 10^(-8);
N             = 100;
t             = (0:1:N-1)*dt;
c1            = square(t);
c0            = 0*square(t);
dsss_sig      = [];
for k = 1 : bitLen*31
    if hopped_sig(1,k)==1
        dsss_sig = [dsss_sig c1];
    else
        dsss_sig = [dsss_sig c0];
    end
end
tVec         = (0:1:length(dsss_sig)-1)*dt;
Nfft         = length(dsss_sig);
df           = 1/(Nfft*dt);
fVec         = (0:1:length(dsss_sig)-1)*df;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure(1);
subplot(3,1,1);
stem(pattern);
axis([-100 bitLen*31+100 -0.5 1.5]);
title('\bf\it Original Bit Sequence');
subplot(3,1,2);
stem(spread_sig);
axis([-100 bitLen*31+100 -0.5 1.5]);
title('\bf\it Pseudorandom Bit Sequence');
subplot(3,1,3);
stem(hopped_sig);
axis([-100 bitLen*31+100 -0.5 1.5]);
title('\bf\it Hopped Bit Sequence');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure(2);
subplot(2,1,1);
plot(tVec,dsss_sig,'r');
axis([-100*dt (length(dsss_sig)+10)*dt -0.5 1.5]);
title('\bf\it DSSS Signal');
%Plotting the FFT of DSSS signal
subplot(2,1,2);
plot(fVec,abs(fft(dsss_sig - mean(dsss_sig))));
title('\bf\it FFT of DSSS Signal');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%