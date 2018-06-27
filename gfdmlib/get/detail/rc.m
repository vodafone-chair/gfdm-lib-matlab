% Copyright (c) 2014 TU Dresden
% All rights reserved.
% See accompanying license.txt for details.
%


function g = rc(M, K, a)
% RC - Return Raised Cosine filter (time domain)
%
t = linspace(-M/2, M/2, M*K+1); t = t(1:end-1); t = t';

g = (sinc(t) .* cos(pi*a*t) ./ (1-4*a*a*t.*t));
g = fftshift(g);
g(K+1:K:end) = 0;

g = g / sqrt(sum(g.*g));
