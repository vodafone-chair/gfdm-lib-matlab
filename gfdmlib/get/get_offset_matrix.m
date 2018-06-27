% Copyright (c) 2014 TU Dresden
% All rights reserved.
% See accompanying license.txt for details.
%


function Q = get_offset_matrix(p, dF, dT)
% Calculate a matrix that shifts a signal in time and frequency
% \param dF Frequency shift, relative to the subcarrier spacing
% \param dT Time shift, relative to one sub-symbol

n = 0:p.K*p.M-1;
w = exp(-2j*pi/(p.K*p.M));

D = dftmtx(p.K*p.M);
Q = diag(w.^(-p.M*dF*n)) * D' * diag(w.^(p.K*dT*n)) * D * eye(p.K*p.M);
Q = Q / (p.K*p.M);