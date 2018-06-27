% Copyright (c) 2014 TU Dresden
% All rights reserved.
% See accompanying license.txt for details.
%


function B = get_receiver_matrix(p, type)
% Return the receiver matrix for a given receiver type
% \param type can be 'MF', 'ZF', or 'MMSE'
    
    if strcmp(type, 'MF')
        g00 = get_transmitter_pulse(p);
    elseif strcmp(type, 'ZF')
        g00= get_receiver_pulse(p, 'ZF');
    elseif strcmp(type, 'MMSE')
        g00 = get_receiver_pulse(p, 'MMSE');
    else
        error('Unknown receiver type!')
    end
    B = tfshifted_filter_matrix(p, g00)';
end
