% Copyright (c) 2014 TU Dresden
% All rights reserved.
% See accompanying license.txt for details.
%


function g = rect_td(M, K)
    g = zeros(M*K, 1);
    g(1:K) = 1;
    g = g / sqrt(sum(g.*g));
end
