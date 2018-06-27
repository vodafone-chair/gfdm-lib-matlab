% Copyright (c) 2014 TU Dresden
% All rights reserved.
% See accompanying license.txt for details.
%


function xch = do_channel(x, chan, snr)
% Apply channel convolution and noise to a signal X
%
% \param x the signal (column vector) that goes through the channel
% \param impResponse impulse response if the channel, sampled at
%                    the system frequency. The resulting signal is
%                    calculated by circular convolution of x with
%                    the CIR.
% \param snr SNR in dB. Assumes the signal has unit energy,
%            i.e. the noise variance is accordingly calculated by
%            10^(-snr/10).

assert(all(size(snr) == [1,1]));
assert(size(x,2) == 1);
sigmaN2 = 10^(-snr/10);




if isa(chan,'numeric')
    if length(chan)==1
        xch = awgn(chan.*x,snr);
    else
        xch = awgn(ifft(fft(x).*fft(chan,length(x))),snr);
    end
else
    xch = awgn(filter(chan,x),snr);
end
