% Copyright (c) 2014 TU Dresden
% All rights reserved.
% See accompanying license.txt for details.
%

function Dhat = do_demodulate(p, x, recType)
% Demodulate a GFDM signal
%
% \param recType can be
%    - MF: matched filter demodulation
%    - ZF: zero forcing demodulation (default)
%    - MMSE: mmse demodulation
%    .
%    both receiver types are implemented in the frequency domain
% \param x the signal to demodulate
%
%
oQAM = p.oQAM;
if p.K>16 || (p.K/16-floor(p.K/16))>0
    L = p.K;
else
    L = 16;
end

if ~oQAM
    if nargin == 2 || strcmp(recType, 'ZF')
        if ~isfield(p, 'cache.GdL')
            g = get_receiver_pulse(p, 'ZF'); g = g(1:p.K/L:end);
            G = fft(g);
        else
            G = p.cache.GdL;
        end
    elseif strcmp(recType, 'MF')
        if ~isfield(p, 'cache.GL')
             g = get_transmitter_pulse(p); g = g(round(1:p.K/p.L:end));
             G = conj(fft(g));
        else
             G = conj(p.cache.GL);
        end
    elseif strcmp(recType, 'MMSE')
        g = get_receiver_pulse(p, 'MMSE'); g = g(round(1:p.K/L:end)); 
        G = fft(g);
    else
        error('Receiver Type not implemented!');
    end
    Dhat = demodulate_in_frequency(p, G, x);
else
    Dhat = demodulate_oqam(p, x);
end
end

