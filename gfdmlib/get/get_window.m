function w = get_window(p)
% GET_WINDOW - Return w for the given GFDM paramater set.
%
% See the code for available filter names

Ncp = p.Ncp; Ncs = p.Ncs; window = p.window; b = p.b; K = p.K; M = p.M;
N = M*K;

switch window
    case   'r1st', type= 0;
    case    '1st', type= 1;
    case   'r4th', type= 2;
    case    '4th', type= 3;
    case    'rrc', type= 4;
    case     'rc', type= 5;
    case 'rrc4th', type= 6;
    case  'rc4th', type= 7;
    case 'xia1st', type= 8;
    case 'xia4th', type= 9;
    case   'r1st', type=10;
    otherwise error('Unknown window!');      
end;

[rise,fall]=get_ramp(b,1,type);
w=[rise;ones(N+Ncp+Ncs-2*b,1);fall];

