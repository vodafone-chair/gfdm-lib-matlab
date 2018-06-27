% Copyright (c) 2014 TU Dresden
% All rights reserved.
% See accompanying license.txt for details.
%


function g = rampbasedfir(M, K, a, pulse)
% rampbasedfir - Return Ramp Based filter

switch pulse
    case   'r1st_fd', type= 0;
    case    '1st_fd', type= 1;
    case   'r4th_fd', type= 2;
    case    '4th_fd', type= 3;
    case    'rrc_fd', type= 4;
    case     'rc_fd', type= 5;
    case 'rrc4th_fd', type= 6;
    case  'rc4th_fd', type= 7;
    case 'xia1st_fd', type= 8;
    case 'xia4th_fd', type= 9;
    case   'r1st_td', type=10;
    case    '1st_td', type=11;
    case   'r4th_td', type=12;
    case    '4th_td', type=13;
    case    'rrc_td', type=14;
    case     'rc_td', type=15;
    case 'rrc4th_td', type=16;
    case  'rc4th_td', type=17;
    case 'xia1st_td', type=18;
    case 'xia4th_td', type=19;
    otherwise error('Unknown transmitter filter!');      
end;

if type<10
[rise,fall]=get_ramp(M,a,type);
g=ifft(([fall;zeros((K-2)*M,1);rise]));%sum(g.^2)=1
else
    if M>1,
        type=type-10;
        g=zeros(M*K,1);
        [rise,fall]=get_ramp(K,a,type);
        g(1:K)=fall;
        g(end-K+(1:K))=rise;
    else
        g=ones(K,1);
    end;
end
g=g/sqrt(sum(abs(g).^2));
