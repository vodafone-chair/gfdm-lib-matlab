% Copyright (c) 2014 TU Dresden
% All rights reserved.
% See accompanying license.txt for details.
%


function [ d s D ] = proc_gfdm( p, rx, recType)
% process a received GFDM signal stream, returning the recovered IQ in 
% several columns and the detected symbols in a 3D structure: 
% [rows = subcarriers, column = subsymbols, block index] 

%% Find symbol timing offset (STO) & carrier frequency offset (CFO)
CFO = 0; % to be obtained...
STO = 0; % to be obtained...
x = circshift(rx.*exp(1i*2*pi*CFO*(1:length(rx))'),STO);

%% Extract the data blocks
y = do_split(p, x);

bset = get_bset(p)+1;

IQ = zeros(p.K,p.M,p.B);
D = zeros(p.K,p.M,p.B);
s = zeros(p.K*p.M,p.B);

p.cache = get_cache(p);
for j=1:length(bset)

    % Channel estimation
    Hhat = 1; % to be implemented

    % do channel equalization
    yhat = y(:,j); % to be implemented

    D(:,:,bset(j)) = do_demodulate(p, yhat, recType);
    s(:,bset(j)) = do_unmap(p, D(:,:,bset(j)));
    d(:,bset(j)) = do_qamdemodulate(s(:,bset(j)), p.mu);

end


end

