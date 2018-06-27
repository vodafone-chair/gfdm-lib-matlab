% Copyright (c) 2014 TU Dresden
% All rights reserved.
% See accompanying license.txt for details.
%


function f = get_noise_enhancement_factor(p)
% Calculate noise enhancement as the norm of the ZF receiver pulse

f = sum(abs(get_receiver_pulse(p, 'ZF')).^2);
