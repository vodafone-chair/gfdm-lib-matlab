% Copyright (c) 2014 TU Dresden
% All rights reserved.
% See accompanying license.txt for details.
%


function p = get_defaultGFDM(type)
% Generate default parameter sets for GFDM transmission.
%
% Generated fields of p:
%   K:              Number of samples per sub-symbol
%   Kon:            Number allocated subcarriers
%   M:              Number of sub-symbols
%   Ncp:            Number of cyclic prefix samples
%   Ncs:            Number of cyclic suffix samples
%   window:         window that multiplies the GFDM block with CP
%   b:              window factor (rolloff of the window in samples)
%   overlap_blocks: overlaped blocks (number of overlaped edge samples)
%   matched_window: matched windowing (root raised windowing in AWGN)
%   pulse:          Pulse shaping filter
%   sigmaN:         noise variance information for MMSE receiver
%   a:              rolloff of the pulse shaping filter
%   L:              Number of overlapping subcarriers
%   mu:             Modulation order (number of bits in the QAM symbol)
%   oQAM:           offset QAM Modulation/Demodulation
%   B:              number of concatenated GFDM blocks


  p = struct;
  % Always use a RRC filter with rolloff 0.5 (if not otherwise stated)
  p.pulse = 'rrc';
  p.sigmaN = 0;
  p.a = 0.5;
  p.L = 2;
  p.Ncp = 0;
  p.Ncs = 0;
  p.window = 'rc';
  p.b = 0;
  p.overlap_blocks = 0 ;
  p.matched_window = 0 ;
  p.mu = 2;
  p.oQAM = 0;
  p.B = 1;
  

  if strcmp(type, 'TTI')
    % GFDM parameters that fit into one TTI of LTE
    p.K = 2048;
    p.M = 15;
    p.Kon = 1200;
  elseif strcmp(type, 'small')
    p.K = 4;
    p.M = 3;
    p.Kon = 4;
  elseif strcmp(type, 'BER')
    % P parameters as in the paper "BER Performance of GFDM" from Nicola
    p.K = 128;
    p.Kon = 128;
    p.M = 5;
  elseif strcmp(type, 'oQAM')
    p.K = 6;
    p.Kon = 6;
    p.M = 4;
    p.pulse = 'rrc_fd';
    p.a = 1;
    p.oQAM = 1;
  elseif strcmp(type, 'OFDM')
    p.K = 2048;
    p.Kon = 1200;
    p.M = 1;
    p.pulse = 'rc_td';
    p.a = 0;
  elseif strcmp(type, 'GFDM stream')
    p.K = 64;
    p.Kon = 54;
    p.M = 15;
    p.Mon = 13;
    p.pulse = 'rc_td';
    p.a = 0;
    p.Ncp = 64;
    p.window = 'rc';
    p.b = 0;
    p.B = 20;
    p.Bon = 5;
  elseif strcmp(type, 'OFDM stream')
    p.K = 2048;
    p.Kon = 1200;
    p.M = 1;
    p.Ncp = 146;
    p.B = 20;
    p.Bon = 5;
  else
    error('Unknown GFDM type!');
  end

  
end
