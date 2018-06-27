% Copyright (c) 2014 TU Dresden
% All rights reserved.
% See accompanying license.txt for details.
%


function A = get_transmitter_matrix(p)
% Calculate transmitter matrix
%
% The result is a square MKxMK matrix where each time-frequency shift
% of g00 is written to one column of the matrix.
%
g00 = get_transmitter_pulse(p);
A = tfshifted_filter_matrix(p, g00);

end
