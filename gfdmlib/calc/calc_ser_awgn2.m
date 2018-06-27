% Copyright (c) 2014 TU Dresden
% All rights reserved.
% See accompanying license.txt for details.
%


function ser = calc_ser_awgn2(p, recType, snr, channel)
% Calculate the SER for a GFDM system in an AWGN channel.
%
% \param recType can be
%    - ZF  - Zero-Forcing receiver
%
% \param channel is the impulse response of the channel, sampled at the
%   system sampling frequency. It is assumed, that the CP is longer
%   than the channel response. If the channel is omitted, a CIR of
%   [1] is assumed.
% \param snr Signal-To-Noise ratio in dB.

fftLen = p.K*p.M;
snrS = size(snr);
snr = reshape(snr, [numel(snr), 1]);

if nargin == 3
    channel = 1;
end

if strcmp(recType, 'ZF')
    noiseEnhancement = get_noise_enhancement_factor(p);
elseif strcmp(recType, 'MF')
    error(sprintf('For MF receiver this is not (yet) implemented!'));
else
    error(sprintf('Receiver type %s not implemented!', recType));
end

H = fft(channel, fftLen).';
G = fft(get_receiver_pulse(p, recType));
res = zeros(length(snr), p.K);
for k=0:p.K-1
    i = k + 1;
    Gs = circshift(G, p.M*k);
    NEF = sum(abs(Gs./H).^2);
    NEF2 = NEF /(p.K*p.M);
    effSNR = snr + 10*log10(1/NEF2);
            
    res(:,i) = calc_ser_ofdm_awgn(p.mu, effSNR);
end

ser = mean(res, 2);
ser = reshape(ser, snrS);
