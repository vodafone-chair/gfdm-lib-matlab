% Copyright (c) 2014 TU Dresden
% All rights reserved.
% See accompanying license.txt for details.
%


function s = get_random_symbols(p)
% Return linear stream of random symbols

num = length(get_mset(p)) * length(get_kset(p));
high = 2 ^ p.mu;

s = randi(high, [num, 1])-1;
