% Copyright (c) 2014 TU Dresden
% All rights reserved.
% See accompanying license.txt for details.
%


function ser = calc_ser_ofdm_awgn(mu, snr, varargin)
% Calculate Symbol error rate for OFDM in FSC.
%
% It assumes that the CP of the OFDM system is longer than the
% channel impulse response.
%
%   @param mu modulation scheme (bits per symbol)
%   @param snr snr value in DB (E_s/N_0)
%   @param channel (optional) the channel impulse response, sampled at
%            the sampling frequency of the system
%   @param fftLen (optional) samples per OFDM symbol
%
% Example:
%   - calc_ser_ofdm_awgn(2, 11)  - SER for QPSK with 11dB SNR
%   - calc_ser_ofdm_awgn(4, 1:8, [1, 0, 0, 0, 1], 16) - SER for
%     snr=1..8, channel=[1, 0, 0, 0, 1], 16 samples per OFDM symbol

snrlin = 10 .^ (snr/10);
M = 2^mu;
sM = sqrt(M);
arg = snrlin * 3/(2*(M-1));



if nargin == 2
    ser = 2 * (1-1/sM) * erfc(sqrt(arg)) .* (1 - 0.5 *(1 -1/sM)*erfc(sqrt(arg)));
else
    channel = varargin{1};
    fftLen = varargin{2};
    H = abs(fft(channel, fftLen)) .^ 2;

    res = zeros([length(H), length(snr)]);
    for i = 1:length(H)
        res(i,:) = calc_ser_ofdm_awgn(mu, snr+10*log10(H(i)));
    end
    ser = mean(res);
end