% Copyright (c) 2014 TU Dresden
% All rights reserved.
% See accompanying license.txt for details.
%


function xcp = do_addcp(p, x)
% Add the cyclic prefix multiply the resulting block with the block window

Ncp = p.Ncp; Ncs = p.Ncs;

b = p.b;

if b > 0
    w = get_window(p);
    xcp = [x(end-Ncp+(1:Ncp),:); x; x(1:Ncs)].*w;
else
    xcp = [x(end-Ncp+(1:Ncp),:); x; x(1:Ncs)];
end