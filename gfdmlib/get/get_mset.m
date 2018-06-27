% Copyright (c) 2014 TU Dresden
% All rights reserved.
% See accompanying license.txt for details.
%


function mset = get_mset(p)
% GET_MSET - Return the set of allocated sub-symbols of the GFDM system
% Mset contains an sequency of valid subsymbols and when Mon<M the corner
% positions are sucessively removed (starting with the first, then
% last, second, penultimate, etc)
% The tail biting effects will vanish resulting in a regular FBMC burst.
% Example: M = Mon = 6, Mset = [0 1 2 3 4 5]; Mon = 3, Mset = [2 3 4]
if isfield(p, 'Mset')
    mset=mod(p.Mset, p.M);
    assert(length(mset) <= p.M);
elseif isfield(p, 'Mon')
    mset = ceil((p.M-p.Mon)/2):p.M-1-floor((p.M-p.Mon)/2);
    assert(p.Mon <= p.M);
else
    mset = 0:p.M-1;
end

% Check, if the values are unique
assert(length(mset) == length(unique(mset)));
