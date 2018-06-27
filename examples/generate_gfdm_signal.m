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
ofdm.pulse = 'rc_td';  % use RC_TD with rolloff 0 to make a
ofdm.a = 0;            % rectangular filter
ofdm.M = 1;
ofdm.Mon = 1;
ofdm.L = ofdm.K;

nB = 3; % Number of GFDM blocks to generate

%% Generate the signals
% Currently only works without CP
assert(~isfield(gfdm, 'Ncp') || gfdm.Ncp == 0);

% Allocate enough space for the signals
blockLen = gfdm.M*gfdm.K;
sGFDM = zeros(nB * blockLen, 1);
sOFDM = zeros(size(sGFDM));

for b = 1:nB
    % Create GFDM signal by modulation of random data
    D = do_map(gfdm, do_qammodulate(get_random_symbols(gfdm), gfdm.mu));
    x = do_modulate(gfdm, D);
    sGFDM((b-1)*blockLen+(1:blockLen)) = x;

    % Create an OFDM signal
    for m = 1:gfdm.M
        D2 = do_map(ofdm, do_qammodulate(get_random_symbols(ofdm), ofdm.mu));
        x2 = do_modulate(ofdm, D2);
        sOFDM((b-1)*blockLen+(m-1)*gfdm.K+(1:gfdm.K)) = x2;
    end
end

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