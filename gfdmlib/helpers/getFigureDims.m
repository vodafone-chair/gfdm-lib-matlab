% Copyright (c) 2014 TU Dresden
% All rights reserved.
% See accompanying license.txt for details.
%


function getFigureDims( nfigx, nfigy, varargin )
% =========================================================
% Call this function before using 'getFigureHandle()'.
% It creates a global variable 'fdims' that contains
% information relevant for the positioning of the figures.
% ---------------------------------------------------------
%   USAGE
%     getFigureDims( nfigx, nfigy, [Attribute1], [Value1], ... )
%
%   INPUTS
%     nfigx             number of horizontal figure slots
%                         any integer > 0
%     nfigy             number of vertical figure slots
%                         any integer > 0
%     [Attribute1]       optional figure attribute, is set
%                       to all figures
%     [Value1]           corresponding value, is set
%                       to all figures
%   OUTPUTS
%     fdims [global]    structure
%       .attributes       list of all optional figure attributes
%       .values           list of all corresponding values
%       .yoffset          absolute offset due to windows menubar
%       .nfigx            number of horizontal figure slots
%       .nfigy            number of vertical figure slots
%       .figxspacing      horizontal gap between figures
%       .figyspacing      vertical gap between figures
%       .figwidth         widht of figures
%       .figheight        height of figures
% =========================================================

	global fdims



	% take care of optional arguments
  	if numel( varargin ) > 0
		fdims.attributes = varargin( 1:2:end );
		fdims.values     = varargin( 2:2:end );
	else
		fdims.attributes = {};
		fdims.values 	 = {};
	end



    s = get( 0, 'ScreenSize' );
    xmax = s( 3 );
    ymax = s( 4 );

	% offset because of windows toolbar
	fdims.yoffset = 20;

    fdims.nfigx = nfigx;
    fdims.nfigy = nfigy;

	fdims.figxspacing = 20;
    fdims.figyspacing = 100;

	% check for 'MenuBar'='none' and 'ToolBar'='none' arguments
	% as those impact the height of the figures
	for i = 1:numel( fdims.attributes )
		if strcmp( lower( fdims.attributes{ i } ), 'menubar' ) && ...
		   strcmp( lower( fdims.values{ i } ), 'none' )
			fdims.figxspacing = 20;
      		fdims.figyspacing = 40;
		elseif strcmp( lower( fdims.attributes{ i } ), 'toolbar' ) && ...
		       strcmp( lower( fdims.values{ i } ), 'none' )
      		fdims.figxspacing = 20;
      		fdims.figyspacing = 80;
  		end
	end

    fdims.figwidth  = round( ( xmax - nfigx*fdims.figxspacing ) / nfigx );
    fdims.figheight = round( ( ymax - nfigy*fdims.figyspacing - fdims.yoffset ) / nfigy );

end
