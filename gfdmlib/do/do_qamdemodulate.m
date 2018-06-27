% Copyright (c) 2014 TU Dresden
% All rights reserved.
% See accompanying license.txt for details.
%


function sh = do_qamdemodulate(d, mu)
% demodulate QAM constellation with unit energy and mu bits per symbol.
%
% The elements in sh correspond to the symbols in the constellation
% (gray-mapped) and range from 0...2^mu-1.
    d = d * sqrt(2/3 * (2^mu - 1));
    sh = qamdemod(d, 2^mu, 0, 'gray');