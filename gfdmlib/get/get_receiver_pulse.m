% Copyright (c) 2014 TU Dresden
% All rights reserved.
% See accompanying license.txt for details.
%


function g = get_receiver_pulse(p, recType)
% Return the first row of the receiver matrix.
% \param recType Receiver type: MMSE, ZF or MF
% \param noiseVariance variance of the noise (linear scale)
%

g00 = get_transmitter_pulse(p);
if strcmp(recType, 'MF')
    g = flipud(conj(g00));
elseif strcmp(recType, 'ZF')
    g = gabdual(g00, p.K);
elseif strcmp(recType, 'MMSE')
    g = get_mmse_pulse(p);
%    g = gabdual(g00 + noiseVariance*gabdual(g00, p.K), p.K);
else
    error('Unknown receiver pulse type!');
end


function gd = gabdual(g, K)
% employ simplified algorithm for calculation of the canonical dual
% gabor window in case of critical sampling.
assert(mod(length(g), K) == 0);
M = length(g) / K;

gm = reshape(g, K, M);
Gm = fft(gm, [], 2);
iGm = 1 ./ conj(Gm);
gmd = ifft(iGm, [], 2);
gd = reshape(gmd, K*M, 1) / K;
