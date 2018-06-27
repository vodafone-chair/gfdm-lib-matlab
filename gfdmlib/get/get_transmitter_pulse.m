% Copyright (c) 2014 TU Dresden
% All rights reserved.
% See accompanying license.txt for details.
%


function g = get_transmitter_pulse(p)
% GET_TRANSMITTER_PULSE - Return g00 for the given GFDM paramater set.
%
% See the code for available filter names

if ~isfield(p, 'cache.g')
    if strcmp(p.pulse, 'rc')
        g = rc(p.M, p.K, p.a);
    elseif strcmp(p.pulse, 'rrc')
        g = rrc(p.M, p.K, p.a);
    elseif strcmp(p.pulse, 'dirichlet')
        g = dirichlet(p.M, p.K);
    elseif strcmp(p.pulse, 'rect_fd')
        g = rect_fd(p.M, p.K);
    elseif strcmp(p.pulse, 'rect_td')
        g = rect_td(p.M, p.K);
    elseif ~isempty(regexp(p.pulse, '_[tf]d$'))
        g = rampbasedfir(p.M, p.K, p.a, p.pulse);
    else
        error('Unknown pulse shaping filter')
    end
else
    g = p.cache.g;
end
