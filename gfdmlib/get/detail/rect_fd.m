% Copyright (c) 2014 TU Dresden
% All rights reserved.
% See accompanying license.txt for details.
%


function g = rect_fd(M, K)
% rect_fd - Return filter that is a symmetric rect in the frequency domain.
assert(mod(M, 2) == 0);
G = zeros(M*K, 1);
G(1:M/2) = 1;
G(end-M/2+1:end) = 1;
g = ifft(G);
g = g / sqrt(sum(abs(g.*g)));
