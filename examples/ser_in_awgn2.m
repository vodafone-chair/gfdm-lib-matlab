% Copyright (c) 2014 TU Dresden
% All rights reserved.
% See accompanying license.txt for details.
%


% This example shows how the lib can be used to simulate the SER in
% an AWGN channel

snr = 0:12;
p = get_defaultGFDM('BER');
p.K = 100;
p.Kon = 100;
p.M = 9;
p.pulse = 'rc_fd';
p.a = 0.5;
p.B = 50;
po = p;
po.oQAM = 1;
po.K = 90;
po.Kon = 90;
po.M = 10;
po.pulse = 'rrc_fd';

seroQAM = [];
serMF   = [];
serZF   = [];
serMMSE = [];

errorsoQAM = zeros(length(snr), 1);
errorsMF   = zeros(length(snr), 1);
errorsZF   = zeros(length(snr), 1);
errorsMMSE = zeros(length(snr), 1);

for si=1:length(snr)
    fprintf('.');
    [txo so] = gen_gfdm(po);
    [tx  s ] = gen_gfdm(p);

    % channel -> AWGN
    rxo = do_channel(txo, 1, snr(si));
    rx  = do_channel(tx , 1, snr(si));

    p.sigmaN = 10^(-snr(si)/20);
    shoqam = proc_gfdm(po, rxo, 'MF'  );
    shm    = proc_gfdm(p , rx , 'MF'  );
    shz    = proc_gfdm(p , rx , 'ZF'  );
    shmmse = proc_gfdm(p , rx , 'MMSE');

    % Count the errors
    errorsoQAM(si) = errorsoQAM(si) + sum(sum(shoqam ~= so));
    errorsMF  (si) = errorsMF(si)   + sum(sum(shm    ~= s ));
    errorsZF  (si) = errorsZF(si)   + sum(sum(shz    ~= s ));
    errorsMMSE(si) = errorsMMSE(si) + sum(sum(shmmse ~= s ));
 
    seroQAM = [seroQAM errorsoQAM(si)];
    serMF   = [serMF   errorsMF(si)];
    serZF   = [serZF   errorsZF(si)];
    serMMSE = [serMMSE errorsMMSE(si)];
end
fprintf('\n');

if 1
% Plot the results
hold off;
semilogy(snr, [seroQAM; serMF; serZF; serMMSE]'/(p.B*p.M*p.K));
hold on;
semilogy(snr, calc_ser_ofdm_awgn(p.mu, snr), 'b--');
semilogy(snr, calc_ser_awgn(p,'MF', snr), 'g--');
semilogy(snr, calc_ser_awgn(p,'ZF', snr), 'r--');
grid;
legend({'oQAM','Matched filter', 'Zero forcing', 'MMSE', 'OFDM'});
end
