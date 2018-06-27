% Copyright (c) 2014 TU Dresden
% All rights reserved.
% See accompanying license.txt for details.
%


function x = modulate_oqam(p, D)
K = p.K; M = p.M;
N = M*K;
g = get_transmitter_pulse(p);

% Use Xia or not?
useXia = ~isempty(strfind(p.pulse,'xia'));

% Use reversed pulses or not?
useReversed = ~isempty(strfind(p.pulse,'_td'));

D1=zeros(K,M);
D2=zeros(K,M);
if useXia
     D1 = real(D);
     D2 = 1i*imag(D);
else
     if useReversed
         D1(:,1:2:end) =    real(D(:,1:2:end));
         D1(:,2:2:end) = 1i*imag(D(:,2:2:end));
         D2(:,1:2:end) = 1i*imag(D(:,1:2:end));
         D2(:,2:2:end) =    real(D(:,2:2:end));
     else
         D1(1:2:end,:) =    real(D(1:2:end,:));
         D1(2:2:end,:) = 1i*imag(D(2:2:end,:));
         D2(1:2:end,:) = 1i*imag(D(1:2:end,:));
         D2(2:2:end,:) =    real(D(2:2:end,:));
     end
end

if ~isfield(p, 'cache.go')
    if useReversed
        go = g.*exp(1i*2*pi*0.5/K*(0:N-1)');
    else
        go = circshift(g, p.K/2);
    end
else
    go = p.cache.go;
end

x1 = modulate_in_time(p, D1, g);
x2 = modulate_in_time(p, D2, go);
x = x1 + x2;


end