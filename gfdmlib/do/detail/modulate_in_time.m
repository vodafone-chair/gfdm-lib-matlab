% Copyright (c) 2014 TU Dresden
% All rights reserved.
% See accompanying license.txt for details.
%


function x = modulate_in_time(p, D, g)
K = p.K; M = p.M;
N = M*K;

DD = repmat(K*ifft(D), M, 1);
 
x = zeros(N,1);

for m=1:M
	symbol = DD(:,m) .* g;
  
 	symbol = circshift(symbol,K*(m-1));
 	x = x + symbol;
end


end
