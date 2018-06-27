% Copyright (c) 2014 TU Dresden
% All rights reserved.
% See accompanying license.txt for details.
%


% This example shows how a random GFDM signal can be
% created. Additionally, an OFDM signal with an equal length is
% created, and the Spectrum of both is compared.

%% Create parameter sets for GFDM and OFDM
gfdm = get_defaultGFDM('TTI');
gfdm.K = 512;
gfdm.Kset = 100:200;  % Only allocate some subcarriers
gfdm.pulse = 'rc';
gfdm.a = 0.1;
gfdm.Mon = 14;


ofdm = gfdm;
ofdm.K = 512;
ofdm.Kset = 100:200;  % Only allocate some subcarriers
ofdm.pulse = 'rc_td';  % use RC_TD with rolloff 0 to make a
ofdm.a = 0;            % rectangular filter
ofdm.M = 1;
ofdm.Mon = 1;

gfdm.B = 3; % Number of GFDM blocks to generate
ofdm.B = 3*15; % Number of OFDM blocks to generate

%% Generate the signals

sGFDM = gen_gfdm(gfdm);
sOFDM = gen_gfdm(ofdm);

%% Plot the resulting PSD
f = linspace(-gfdm.K/2, gfdm.K/2, 2*length(sGFDM)+1); f = f(1:end-1)';
plot(f, mag2db(fftshift(abs(fft(sOFDM, 2*length(sOFDM)))))/2, 'b');
hold on;
plot(f, mag2db(fftshift(abs(fft(sGFDM, 2*length(sGFDM)))))/2, 'r');
hold off;
ylim([-40, 30]);
xlabel('f/F'); ylabel('PSD [dB]');
grid()
legend({'OFDM', 'GFDM'});
