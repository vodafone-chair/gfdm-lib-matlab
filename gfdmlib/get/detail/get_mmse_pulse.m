% Copyright (c) 2014 TU Dresden
% All rights reserved.
% See accompanying license.txt for details.
%


function gse = get_mmse_pulse(p)

g = get_transmitter_pulse(p);
gm = reshape(g, p.K, p.M);
Gm = fft(gm, [], 2);

Gse = 1 ./ conj(Gm + p.sigmaN./conj(p.K*Gm));
gse = ifft(Gse, [], 2) / p.K;
gse = reshape(gse, p.K*p.M, 1);
