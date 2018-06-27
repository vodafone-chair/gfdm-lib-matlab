% Copyright (c) 2014 TU Dresden
% All rights reserved.
% See accompanying license.txt for details.
%


function tau_rms = calc_rms_delay_spread( p, tau )
% Calculate root mean square delay spread of a given power-delay profile.
%
%	Use:
%		tau_rms = calc_rms_delay_spread( p, tau )
%
%     \return tau_rms:   root mean square delay spread
%     \param p	        vector containing channel power delay profile
%     \param tau        vector containing channel delays
%
% 	[1]	http://en.wikipedia.org/wiki/Delay_spread
% 	[2]	Goldsmith, Andrea (2004), Wireless Communications
% 		ISBN 978-0-521-83716-3, p. 82
% 		available at http://www.cs.ucdavis.edu/~liu/289I/Material/book-goldsmith.pdf
%
    p   = reshape(p,[numel(p),1]);
    tau = reshape(tau,[numel(tau),1]);

    tau_mean = sum(tau.*p) / sum(p);
    tau_rms = sqrt( sum( (tau-tau_mean).^2 .* p ) / sum(p) );
