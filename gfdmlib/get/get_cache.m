% Copyright (c) 2014 TU Dresden
% All rights reserved.
% See accompanying license.txt for details.
%


function cache = get_cache(p)
% Generate cache parameter sets for GFDM transmission.
%
% Generated fields of cache:
%   g:      pre-calculated impulse response in time
%   gL:     pre-calculated decimated impulse response in time
%   go:     pre-calculated offset impulse response in time
%   G:      pre-calculated impulse response in frequency
%   GL:     pre-calculated decimated impulse response in frequency
%   Go:     pre-calculated offset impulse response in frequency
%   gd:     pre-calculated dual impulse response in time
%   Gd:     pre-calculated dual impulse response in frequency
%   gdL:    pre-calculated decimated dual impulse response in time
%   GdL:    pre-calculated decimated dual impulse response in frequency


  cache = struct;

  
  % pre-calculated filters
  cache.g = get_transmitter_pulse(p);
  cache.G = fft(cache.g);

  cache.gL = cache.g(round(1:p.K/p.L:end));
  cache.GL = fft(cache.gL);
  
  cache.gd = get_receiver_pulse(p, 'ZF');
  cache.Gd = fft(cache.gd);
  
  if p.K>16 || (p.K/16-floor(p.K/16))>0
    L = p.K;
  else
    L = 16;
  end
  cache.gdL = cache.gd(1:p.K/L:end);
  cache.GdL = fft(cache.gdL);

  N = p.K*p.M;
  if ~isempty(strfind(p.pulse,'_td'))
    cache.go = cache.g.*exp(1i*2*pi*0.5/p.K*(0:N-1)');
  else
    cache.go = circshift(cache.g, p.K/2);
  end
  cache.Go = fft(cache.go);

  
end
