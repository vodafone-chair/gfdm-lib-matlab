% Copyright (c) 2014 TU Dresden
% All rights reserved.
% See accompanying license.txt for details.
%


function [ tx d ] = gen_gfdm( p )
% generates a complex GFDM signal stream, returning the time signal and the
% mapped data source in a 3D structure: 
% [rows = subcarriers, column = subsymbols, block index] 

bset = get_bset(p)+1;

d = zeros(length(get_mset(p)) * length(get_kset(p)),p.B);
xcp = zeros(p.M*p.K+p.Ncp+p.Ncs,p.B);

p.cache = get_cache(p);
for j=1:length(bset)

    d(:,bset(j)) = get_random_symbols(p);
    s = do_qammodulate(d(:,bset(j)), p.mu);
    D = do_map(p, s);

    x = do_modulate(p, D);

    xcp(:,bset(j)) = do_addcp(p, x);

end

tx = do_concatenate(p, xcp);


end


