% Copyright (c) 2014 TU Dresden
% All rights reserved.
% See accompanying license.txt for details.
%


function ser = calc_ser_ofdm_rayleigh(mu, snr, numRx, varargin)
% Calculate SER for OFDM in Rayleigh channel
%
% It assumes that the CP of the OFDM system is longer than the
% channel impulse response.
%
%   \param mu: modulation scheme (bits per symbol)
%   \param snr: snr value in DB (E_s/N_0)
%   \param numRx: number of antennas for MRC
%   \param channel: (optional) the average channel impulse response, sampled at
%            the sampling frequency of the system
%   \param fftLen: (optional) samples per OFDM symbol
%
% Example:
%   - calc_ser_ofdm_rayleigh(2, 11, 1)  - SER for QPSK with 11dB SNR, one RX antenna
%   - calc_ser_ofdm_awgn(4, 1:8, 1, [1, 0, 0, 0, 1], 16) - SER for
%     snr=1..8, channel=[1, 0, 0, 0, 1], 1RX antenna, 16 samples per OFDM symbol
ser = 0;


if nargin == 3
    snrlin = 10 .^ (snr/10);
    gamma = snrlin / mu;
    M = 2^mu;
    sM = sqrt(M);
    k = mu;
    beta = 3 * k/(2*(M-1));
    L = numRx;

    mu = sqrt(beta*gamma./(1+beta*gamma));
    mu = reshape(mu, numel(mu), 1);

    I1 = ((1-mu)/2).^L;
    tmp = zeros(length(mu), L);
    for m=0:L-1
        tmp(:,m+1) = nchoosek(L-1+m,m).*((1+mu)/2).^m;
    end
    I1 = I1 .* sum(tmp, 2);

    if L == 1
        I2 = 4 / pi .* mu .* atan(mu);
    else
        error('MRC for Rayleigh is not yet implemented');
    end

    ser = (sM-1)/M * (sM-1+4*I1-(sM-1)*I2);
    ser = reshape(ser, size(snr));
else
% Old code (dead)
%    channel = varargin{1};
%    ser = calc_ser_ofdm_rayleigh(mu, snr+10*log10(sum(abs(channel).^2)), 1);
%
    v = 1;%Distance in between the symbol and the decision threshold.
    J = 2^mu;%Number of symbols in the QAM constelattion.
    L = sqrt(J);%Number of projecction in each axis of the J-QAM constellation.
    Es = 2/(3)*v^2*(J-1);%Average energy per symbol of the J-QAM constellation.
    SN = (10.^((snr)/10))';%Linear Eb/N0 vector.
    No = Es./(SN);%Noise standard deviation.
    sr = sqrt(0.5);
    h = varargin{1};
    srt = sqrt(sr^2*sum(h.^2));
    gama = 3*srt.^2/(J-1).*SN;%Average SNR.
    partA = 1-sqrt(gama./(1+gama));
    partB = 1-4/pi*sqrt(gama./(1+gama)).*atan(sqrt((1+gama)./gama));
    ser = 2*(L-1)/(L)*partA-((L-1)/L)^2*partB;%SER
end
