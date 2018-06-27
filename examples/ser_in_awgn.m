% Copyright (c) 2014 TU Dresden
% All rights reserved.
% See accompanying license.txt for details.
%


% This example shows how the lib can be used to simulate the SER in
% an AWGN channel

snr = 0:8;
p = get_defaultGFDM('BER');
p.pulse = 'rc_fd';
p.a = 0.5;

serMF = [];
serZF = [];

its = 10;

errorsMF = zeros(length(snr), 1);
errorsZF = zeros(length(snr), 1);

for si=1:length(snr)
    for i=1:its
        % create symbols
        s = get_random_symbols(p);

        % map them to qam and to the D matrix
        D = do_map(p, do_qammodulate(s, p.mu));

        x = do_modulate(p, D);

        % channel -> AWGN
        xch = do_channel(x, 1, snr(si));

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
semilogy(snr, calc_ser_ofdm_awgn(p.mu, snr), 'k--');
semilogy(snr, calc_ser_awgn(p,'MF', snr), 'b--');
semilogy(snr, calc_ser_awgn(p,'ZF', snr), 'g--');
grid;
legend({'Matched filter', 'Zero forcing', 'OFDM'});
end
