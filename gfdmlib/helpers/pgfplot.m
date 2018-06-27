% Copyright (c) 2014 TU Dresden
% All rights reserved.
% See accompanying license.txt for details.
%


function pgfplot( fname )

	c = get( gca, 'Children' );
	xdatas = get( c, 'xdata' );
	ydatas = get( c, 'ydata' );

	for i = 1:numel( xdatas )
		dlmwrite( [ fname sprintf( '%03i', i ) '.txt' ], [ xdatas{i}.' ydatas{i}.' ], ' ' );
	end

end
