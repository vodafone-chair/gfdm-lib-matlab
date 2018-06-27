% Copyright (c) 2014 TU Dresden
% All rights reserved.
% See accompanying license.txt for details.
%


function tx = do_concatenate(p, x)
% cyclically concatenate GFDM blocks to create a tx stream

overlap_blocks = p.overlap_blocks;

tx = x(1:(end - overlap_blocks),:);

if overlap_blocks > 0
tx(1:overlap_blocks,:) = tx(1:overlap_blocks,:) + circshift(x(1:overlap_blocks,:),[0 1]);
end;

tx = reshape(tx,[],1);
