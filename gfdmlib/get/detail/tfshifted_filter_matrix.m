% Copyright (c) 2014 TU Dresden
% All rights reserved.
% See accompanying license.txt for details.
%


function A = tfshifted_filter_matrix(p, g00)
A = zeros(p.M*p.K, p.M*p.K);

n = 0:p.M*p.K-1; n=n';
w = exp(1j*2*pi/p.K);

for k=0:p.K-1
    for m=0:p.M-1
        A(:,m*p.K+k+1) = circshift(g00, m*p.K) .* w.^(k*n);
    end
end
    