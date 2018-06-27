% Copyright (c) 2014 TU Dresden
% All rights reserved.
% See accompanying license.txt for details.
%


% This example shows how the lib can be used to simulate the SER in
% an FSC channel
% Notes: 1) The theoretical SER are still in progress
%        2) The proper channel equalization approach is a open topic to
%        work with

snr = 0:5:35;
p=get_defaultGFDM('OFDM');
p.pulse='rc_fd';
p.a=0.3;%roll-off factor for the RRC and RC filters.
p.K=99;%Number of subcarriers.
p.L=2;%Number of overlapping subcarrier for frequency domain GFDM implementation..
p.Kon=p.K;%Number of actives subcarriers.
p.M=9;%Number of subsymbols.
p.mu=4;%16QAM.

serMF = [];
serZF = [];

its = 10;

errorsMF = zeros(length(snr), 1);
errorsZF = zeros(length(snr), 1);

chan =  ricianchan(1,0,0,0:16,linspace(0,-20, 16+1));
%chan = get_defaultChannel(p.K,'EXP');

for si=1:length(snr)
    for i=1:its
        % create symbols
        s = get_random_symbols(p);

        % map them to qam and to the D matrix
        D = do_map(p, do_qammodulate(s, p.mu));

        x = do_modulate(p, D);

        % channel
        y = do_channel(x, chan.PathGains.', snr(si));H=fft(chan.PathGains.',length(y));
        %y = do_channel(x, chan, snr(si));H=fft(chan.PathGains(si,:).',length(y))
        xch = ifft(fft(y)./H);

        dhat_mf = do_unmap(p, do_demodulate(p, xch, 'MF'));
        dhat_zf = do_unmap(p, do_demodulate(p, xch, 'ZF'));

        shm = do_qamdemodulate(dhat_mf, p.mu);
        shz = do_qamdemodulate(dhat_zf, p.mu);

        % Count the errors
        errorsMF(si) = errorsMF(si) + sum(shm ~= s);
        errorsZF(si) = errorsZF(si) + sum(shz ~= s);
    end

    serMF = [serMF errorsMF(si)];
    serZF = [serZF errorsZF(si)];
end

if 1
% Plot the results
hold off;
semilogy(snr, [serMF; serZF]'/(its*p.M*p.K));
hold on;
h=10.^(chan.AvgPathGaindB/10);
semilogy(snr, calc_ser_ofdm_rayleigh(p.mu, snr', 1, h), 'k--');
grid;
legend({'Matched filter', 'Zero forcing', 'OFDM'});
end