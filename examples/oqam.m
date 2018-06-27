%% Offset QAM experiment
% GFDM Parameters
p = get_defaultGFDM('BER');
p.M = 32;
p.K = p.M+2;
p.mu = 4; % 1024-QAM
p.L = p.K;
p.a = 1;

p.Kon = p.K; p.Mon = p.M;
N = p.K*p.M;

% Use Xia or not?
useXia = 0;

% Use reversed pulses or not?
useReversed = 1;

if useXia
    p.pulse = 'xia1st_fd';
else
    p.pulse = 'rrc_fd';
end

% Calculate the filter and a half-symbol shifted version
g = get_transmitter_pulse(p);
g2 = circshift(g, p.K/2);

% generate data
data = do_map(p, do_qammodulate(get_random_symbols(p), p.mu));
data1 = real(data); % Split into real and imag
data2 = imag(data);

col1j=exp(1j*pi/2*mod(0:N-1, 2));
mat1j = repmat(col1j, [N, 1]);
matj1 = circshift(mat1j, [0, 1]);

% generate matrix for first subsubsymbols (2 subsubsymbols make one subsymbol) 
A = tfshifted_filter_matrix(p, g);
if useXia
    A = A;   
else
    A = A.*mat1j; % multiply every 2nd filter by j, starting at the first
end

% generate matrix for scend subsubsymbols
A2 = tfshifted_filter_matrix(p, g2);
if useXia
    A2 = 1j*A2;       % recognize the significant simplification with Xia filters
else
    A2 = A2.*matj1; % multiply every 2nd filter by j, starting at the second
end

if useReversed
    A=sqrt(p.M*p.K)*ifft(A);
    A2=sqrt(p.M*p.K)*ifft(A2);
end

data1_f = data1(:);
data2_f = data2(:);

% generate signal for both parts
sig1 = A*data1_f;
sig2 = A2*data2_f;

sig = sig1+sig2; % sum them up

% receive them, without interference
R1 = A'*sig; R1 = reshape(R1, p.K, p.M); R1 = real(R1);
R2 = A2'*sig; R2 = reshape(R2, p.K, p.M); R2 = real(R2);

% show that its really working (last column is zero all the time
if p.M < 9
    round(10*[data1, R1, data1-R1])
    round(10*[data1, R2, data2-R2])
end

const = R1+1j*R2;
fprintf('Difference transmit-received: %f\n', sum(abs(const(:)-data(:))));

figure(1)
subplot(1,2,1); plot(data, 'x');
axis equal;
subplot(1,2,2); plot(R1+1j*R2, 'x');
axis equal;
figure(2)
subplot(1,2,1); plot(real([A(:,1:2) A2(:,1:3)]));
subplot(1,2,2); plot(imag([A(:,1:2) A2(:,1:3)]));

