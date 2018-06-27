% Copyright (c) 2014 TU Dresden
% All rights reserved.
% See accompanying license.txt for details.
%


function kset = get_kset(p)
% GET_KSET - Return the set of allocated subcarriers for the GFDM system
% Kset contains a sequence of valid subcarriers and when Kon<K the central 
% positions (corner subcarries in the matlab baseband notation) are
% successively removed up to the last one centered at DC.
% 
% Exemple: K = Kon = 6, Kset = [0 1 2 3 4 5]; Kon = 3, Kset = [0 1 5]
if isfield(p, 'Kset')
    kset = mod(p.Kset, p.K);
    assert(length(kset) <= p.K);
elseif isfield(p, 'Kon')
    kset = [1:ceil(p.Kon/2) (p.K+1-floor(p.Kon/2)):p.K]-1;
    assert(p.Kon <= p.K);
else
    kset = 0:p.K-1;
end

% Check, if the values are unique
assert(length(kset) == length(unique(kset)));

