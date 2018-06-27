% Copyright (c) 2014 TU Dresden
% All rights reserved.
% See accompanying license.txt for details.
%


function s = do_unmap(p, D)
% Convert data matrix to linear symbol stream
%
% Respects the values of kset and mset. The first column of D
% constitutes the first symbols of s, using only these rows that
% exist in kset.


kset = get_kset(p)+1;
mset = get_mset(p)+1;

if length(kset) == p.K && length(mset) == p.M
    s = reshape(D, numel(D), 1);
else
    Dm = D(kset,mset);
    s = reshape(Dm, numel(Dm), 1);
end