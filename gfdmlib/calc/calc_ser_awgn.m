% Copyright (c) 2014 TU Dresden
% All rights reserved.
% See accompanying license.txt for details.
%


function ser = calc_ser_awgn(p, recType, snr, channel)
% Calculate the SER for a GFDM system in an AWGN channel.
%
% \param recType can be
%    - ZF  - Zero-Forcing receiver
%    - MF  - Matched-Filter receiver
%
% \param channel is the impulse response of the channel, sampled at the
%   system sampling frequency. It is assumed, that the CP is longer
%   than the channel response. If the channel is omitted, a CIR of
%   [1] is assumed.
% \param snr Signal-To-Noise ratio in dB.

%fftLen = p.M*p.K;
fftLen = p.K;
nLin = 10 .^ (-snr/10);
snrS = size(snr);
snr = reshape(snr, [numel(snr), 1]);

if nargin == 3
    channel = 1;
end

if size(channel) == [1 1]
    fftLen = 1;
end

if strcmp(recType, 'ZF')
    noiseEnhancement = get_noise_enhancement_factor(p);
elseif strcmp(recType, 'MF')
    Am = get_ambgfun(p);
    sigmaI = sum(abs(Am(:)).^2)-1;
else
    error(sprintf('Receiver type %s not implemented!', recType));
end

H = abs(fft(channel, fftLen).^2);
res = zeros(length(snr), fftLen);
for i=1:fftLen
    if strcmp(recType, 'ZF')
        effSNR = snr + 10 * log10(H(i)/noiseEnhancement);
    elseif strcmp(recType, 'MF')
        effSNR = -10* log10(1/H(i)*nLin+sigmaI);
    else
        error('Receiver type not implemented!');
    end
    res(:,i) = calc_ser_ofdm_awgn(p.mu, effSNR);
end

ser = mean(res, 2);
ser = reshape(ser, snrS);
