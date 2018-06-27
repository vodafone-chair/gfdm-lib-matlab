% Copyright (c) 2014 TU Dresden
% All rights reserved.
% See accompanying license.txt for details.
%


function Dhat = demodulate_oqam(p, x)
K = p.K; M = p.M;
N = M*K;
g = get_transmitter_pulse(p);

% Use Xia or not?
useXia = ~isempty(strfind(p.pulse,'xia'));

% Use reversed pulses or not?
useReversed = ~isempty(strfind(p.pulse,'_td'));

Dhat=zeros(K,M);
if ~isfield(p, 'cache.go')
    if useReversed
        go = g.*exp(1i*2*pi*0.5/K*(0:N-1)');
    else
        go = circshift(g, p.K/2);
    end
else
    go = p.cache.go;
end

Dhat1 = demodulate_in_frequency(p, conj(fft(g)), x);
Dhat2 = demodulate_in_frequency(p, conj(fft(go)), x);

if useXia
     Dhat = real(Dhat1) + 1i*imag(Dhat2);
else
     if useReversed
         Dhat(:,1:2:end) = real(Dhat1(:,1:2:end)) + 1i*imag(Dhat2(:,1:2:end));
         Dhat(:,2:2:end) = real(Dhat2(:,2:2:end)) + 1i*imag(Dhat1(:,2:2:end));
     else
         Dhat(1:2:end,:) = real(Dhat1(1:2:end,:)) + 1i*imag(Dhat2(1:2:end,:));
         Dhat(2:2:end,:) = real(Dhat2(2:2:end,:)) + 1i*imag(Dhat1(2:2:end,:));
     end
end


end
