% Copyright (c) 2014 TU Dresden
% All rights reserved.
% See accompanying license.txt for details.
%


function H = get_channel_matrix(h, L)
    r1 = zeros(1, L);
    r1(1:length(h)) = h;
    H = zeros(L, L);
    r1 = r1(1+mod(-(0:L-1), L));
    for r = 1:L
        H(r, :) = circshift(r1, [0, r-1]);
    end
end
