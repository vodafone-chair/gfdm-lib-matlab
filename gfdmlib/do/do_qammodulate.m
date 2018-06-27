% Copyright (c) 2014 TU Dresden
% All rights reserved.
% See accompanying license.txt for details.
%


function d = do_qammodulate(s, mu)
% modulate to unit energy qam constellation with mu bits per symbol
%
% The elements in s correspond to the symbols in the constellation
% (gray-mapped) and range from 0...2^mu-1
    d = qammod(s, 2^mu, 0, 'gray');
    d = d / sqrt(2/3 * (2^mu - 1));