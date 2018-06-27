% Copyright (c) 2014 TU Dresden
% All rights reserved.
% See accompanying license.txt for details.
%


function x = do_removecp(p, xcp)
% Remove the cyclic prefix of the signal according to the parameters in p.
% NOT implemented yet : Depending on the block window, the rolloff-parts are added together to restore the correct signal.
Ncp = p.Ncp; Ncs = p.Ncs;
b = p.b; mtchw = p.mtchw;

if mtchw==0
    x=xcp((Ncp+1):(end-Ncs));
else
    w = conj(get_window(p));
    xcp = xcp.*w;
    xm = xcp;
    xm(1:b) = xcp(1:b)+xcp(end-b+(1:b));
    xm(end-b+(1:b)) = xm(1:b);
    x=xm((Ncp+1):(end-Ncs));
end