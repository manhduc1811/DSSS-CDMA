% number of samples in t o t a l
N = 4096;
% s c a l e for 8 b i t unsigned int e g e r
S = 2^8 - 1;
% samples per b i t
M = 256;
% number of bits
B = round(N/M);
% select either PRBS or PN
%x = S*randi([0 1],[B,1]); % PRBS ? v a l u e s 0 or 1
x = randi([0 S],[B,1]); % PN ? v a l u e s in range 0 to S?1
x = repmat(x',[M,1]);
x = x(:);
xi = uint16(x) ;
plot(xi) ;
axis([0 N 0 S+1]);
title('Sampled Pseudo?Random Binary Sequence');