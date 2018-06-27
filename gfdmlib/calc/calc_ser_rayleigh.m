% Copyright (c) 2014 TU Dresden
% All rights reserved.
% See accompanying license.txt for details.
%


function ser = calc_ser_rayleigh(p, recType, snr, numRx, channel)
% Calculate the SER for a GFDM system in a Rayleigh channel.
%
% \param recType can be
%    - ZF  - Zero-Forcing receiver
% \param snr SNR in dB
% \param numRX number of receiver antennas for MRC
% \param channel Average channel impulse response, sampled at the system
%                sampling frequency. The CP is assumed to be longer
%                than the channel.

fftLen = p.M*p.K;
nLin = 10 .^ (-snr/10);
snrS = size(snr);
snr = reshape(snr, [numel(snr), 1]);

if nargin == 4
    channel = 1;
end

if size(channel) == [1 1]
    fftLen = 1;
end

if strcmp(recType, 'ZF')
    noiseEnhancement = get_noise_enhancement_factor(p);
elseif strcmp(recType, 'MF')
    error('For MF receiver, no SER can be calculated!');
else
    error('Receiver type not implemented!');
end

H = abs(fft(channel, fftLen).^2);
res = zeros(length(snr), fftLen);
for i=1:fftLen
    if strcmp(recType, 'ZF')
        effSNR = snr + 10 * log10(H(i)/noiseEnhancement);
    else
        error('Receiver type not implemented!');
    end
    res(:,i) = calc_ser_ofdm_rayleigh(p.mu, effSNR, numRx);
end

ser = mean(res, 2);
ser = reshape(ser, snrS);
