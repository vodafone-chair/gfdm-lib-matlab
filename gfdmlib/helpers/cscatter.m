% Copyright (c) 2014 TU Dresden
% All rights reserved.
% See accompanying license.txt for details.
%


function cscatter( x, style )
% 
% scatter complex values in a more convenient way than scatter() or scatterplot
% 

if nargin < 2
    style = '.';
end



xre = real( x );
xim = imag( x );

plot( xre, xim, style );
axis square



end

