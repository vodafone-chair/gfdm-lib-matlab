% Copyright (c) 2014 TU Dresden
% All rights reserved.
% See accompanying license.txt for details.
%


function x = modulate_in_frequency(p, D, G)
K = p.K; M = p.M;
N = M*K;
L = length(G) / M;

block = D.';

DD = repmat(fft(block, [], 1), L, 1);
X = zeros(N,1);

for k=1:K
    carrier = zeros(N,1);
    carrier(1:L*M) = fftshift(DD(:,k) .* G);

    carrier = circshift(carrier, -floor(L*M/2) + M*(k-1));
    X = X + carrier;
end

X = (K/L) * X;
x = ifft(X);


end
