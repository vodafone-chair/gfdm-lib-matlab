% Copyright (c) 2014 TU Dresden
% All rights reserved.
% See accompanying license.txt for details.
%


function g = izak(Zg)
    
    K = size(Zg, 1);
    M = size(Zg, 2);
    
    gg = ifft(Zg, [], 2) * sqrt(M);
    g = reshape(gg, K*M, 1);
end

