% Copyright (c) 2014 TU Dresden
% All rights reserved.
% See accompanying license.txt for details.
%


function Z = zak(g, a)
    assert(mod(length(g), a) == 0);
    
    gg = reshape(g, a, []);
    GG = fft(gg, [], 2) / sqrt(size(gg, 2));
    Z = GG;
end
