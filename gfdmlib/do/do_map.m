% Copyright (c) 2014 TU Dresden
% All rights reserved.
% See accompanying license.txt for details.
%


function D = do_map(p, s)
% Map the linear symbol stream to the GFDM data matrix.
%
% Respects the kset and mset values. Fills the matrix sub-symbol
% wise, i.e. the first symbols in the stream belong to the first
% sub-symbol, the next symbols belong to the 2nd and so on.

kset = get_kset(p)+1;
mset = get_mset(p)+1;

if length(kset)==p.K && length(mset) == p.M
    D = reshape(s, [p.K, p.M]);
else
    Dm = reshape(s, [length(kset), length(mset)]);
    res1 = zeros(p.K, length(mset));
    res1(kset, :) = Dm;
    res = zeros(p.K, p.M);
    res(:,mset) = res1;
    D = res;
end
