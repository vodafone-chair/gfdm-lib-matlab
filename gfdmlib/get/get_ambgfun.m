% Copyright (c) 2014 TU Dresden
% All rights reserved.
% See accompanying license.txt for details.
%


function Am = get_ambgfun(p)
% Return the ambiguity function for the GFDM system.
%
% The element (m,k) of the returned matrix correspond to the
% interference from the GFDM sub-symbol that is k subcarriers and m
% sub-symbols away.
nF = p.K;
nT = p.M;
sF = p.M;
sT = p.K;
g00 = get_transmitter_pulse(p);
g00 = g00';

Am = zeros(nT, nF);
for tau=0:nT-1
    Atf = fft(g00 .* circshift(g00, [0, tau*sT]));
    Am(tau+1, :) = Atf(1:sF:end);
end
