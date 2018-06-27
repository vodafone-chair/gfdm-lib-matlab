% Copyright (c) 2014 TU Dresden
% All rights reserved.
% See accompanying license.txt for details.
%


function rx = do_split(p, tx)
% cyclically split GFDM stream to create a column-wise rx blocks with CP
% and CS extensions

Ncp = p.Ncp; Ncs = p.Ncs; N = p.M*p.K;
overlap_blocks = p.overlap_blocks;

rx = reshape(tx,Ncp+Ncs+N-overlap_blocks,[]);

if overlap_blocks > 0
rx = [rx; circshift(rx(1:overlap_blocks,:),[0 -1])];
end;
