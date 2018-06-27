% Copyright (c) 2014 TU Dresden
% All rights reserved.
% See accompanying license.txt for details.
%


function g = rrc(M, K, a)
% RRC - Return Root Raised Cosine filter (time domain)
%

t = linspace(-M/2, M/2, M*K+1); t = t(1:end-1); t = t';

g = (sin(pi*t*(1-a))+4*a.*t.*cos(pi*t*(1+a)))./(pi.*t.*(1-(4*a*t).^2));
g(find(t==0)) = 1-a+4*a/pi;
g(find(abs(t) == 1/(4*a))) = a/sqrt(2)*((1+2/pi)*sin(pi/(4*a))+(1-2/pi)*cos(pi/(4*a)));

g = fftshift(g);
g = g / sqrt(sum(g.*g));