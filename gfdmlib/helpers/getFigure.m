% Copyright (c) 2014 TU Dresden
% All rights reserved.
% See accompanying license.txt for details.
%


function h = getFigure( xpos, ypos )
% =========================================================
% This function returns the handle of a figure in a 
% particular position on the screen. Call 'getFigureDims()'
% before using this.
% ---------------------------------------------------------
%   USAGE
%     getFigure( xpos, ypos )
%
%   INPUTS
%     xpos              horizontal position
%                         0 < xpos < nfigx
%     ypos              vertical position
%                         0 < ypos < nfigy
%   OUTPUTS
%     h                 figure handle
% =========================================================

	global fdims;

    ypos = fdims.nfigy + 1 - ypos;
    figx = fdims.figxspacing/2 + (xpos-1)*(fdims.figwidth  + fdims.figxspacing);
    figy = fdims.yoffset + fdims.figyspacing/2 + (ypos-1)*(fdims.figheight + fdims.figyspacing);


    h = figure( 'Position', [ figx figy fdims.figwidth fdims.figheight ] );
	for i = 1: numel( fdims.attributes )
		set( h, fdims.attributes{ i }, fdims.values{ i } );
	end

end
