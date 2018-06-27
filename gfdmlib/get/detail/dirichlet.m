% Copyright (c) 2014 TU Dresden
% All rights reserved.
% See accompanying license.txt for details.
%


function g = dirichlet(M, K)
% DIRICHLET - Return Dirichlet Kernel

o = ones(1, M);
z = zeros(1, K*M-M);

G = [o z];
G = circshift(G, [0, -floor(M/2)]);

g = ifft(G);
g = g / sqrt(sum(abs(g).^2));
g = g';