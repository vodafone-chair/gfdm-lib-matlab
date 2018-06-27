% Copyright (c) 2014 TU Dresden
% All rights reserved.
% See accompanying license.txt for details.
%


% This example shows how the lib can be used to simulate the SER in
% an AWGN channel

snr = 0:3:15;
p=get_defaultGFDM('OFDM');
p.oQAM=1;
p.pulse='rrc_fd';
p.a=0.3;%roll-off factor for the RRC and RC filters.
p.K=128;%Number of subcarriers.
p.L=p.K;%Number of overlapping subcarrier for frequency domain GFDM implementation..
p.Kon=p.K;%Number of actives subcarriers.
p.M=9;%Number of subsymbols.
p.mu=4;%16QAM.

ser = [];

its = 10;

errors = zeros(length(snr), 1);

tic
for si=1:length(snr)
    for i=1:its
        % create symbols
        s = get_random_symbols(p);

        % map them to qam and to the D matrix
        D = do_map(p, do_qammodulate(s, p.mu));

        x = do_modulate(p, D);

        % channel -> AWGN
        xch = do_channel(x, 1, snr(si));

        dhat = do_unmap(p, do_demodulate(p, xch));

        sh = do_qamdemodulate(dhat, p.mu);

        % Count the errors
        errors(si) = errors(si) + sum(sh ~= s);
    end

    ser = [ser errors(si)];
    
end
toc

if 1
% Plot the results
hold off;
semilogy(snr, ser'/(its*p.M*p.K));
hold on;
semilogy(snr, calc_ser_ofdm_awgn(p.mu, snr), 'k--');
grid;
if p.oQAM
    legend({'GFDM OQAM', 'OFDM'});
else
    legend({'GFDM', 'OFDM'});
end
end
