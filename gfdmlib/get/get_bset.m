% Copyright (c) 2014 TU Dresden
% All rights reserved.
% See accompanying license.txt for details.
%


function bset = get_bset(p)
% GET_BSET - Return the set of allocated GFDM blocks for the GFDM stream signal
if isfield(p, 'Bset')
    bset = mod(p.Bset, p.B);
    assert(length(bset) <= p.B);
elseif isfield(p, 'Bon')
    bset = [0:p.Bon-1];
    assert(p.Bon <= p.B);
else
    bset = 0:p.B-1;
end

% Check, if the values are unique
assert(length(bset) == length(unique(bset)));
