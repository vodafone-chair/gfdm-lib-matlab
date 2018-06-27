% Copyright (c) 2014 TU Dresden
% All rights reserved.
% See accompanying license.txt for details.
%


function Dhat = demodulate_in_frequency(p, G, x)
M = p.M; K = p.K;
L = length(G) / M;

Xhat = fft(x);
Dhat = zeros(K, M);
for k=1:K
    carrier = circshift(Xhat, ceil(L*M/2) - M*(k-1));
    carrier = fftshift(carrier(1:L*M));
    carrierMatched = carrier .* G;
    %dhat = downsample(ifft(carrierMatched), L);
    dhat = ifft(sum(reshape(carrierMatched,M,L),2)/L);%M samples ifft
    Dhat(k,:) = dhat;
end


end