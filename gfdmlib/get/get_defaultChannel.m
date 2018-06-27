% Copyright (c) 2014 TU Dresden
% All rights reserved.
% See accompanying license.txt for details.
%


function chan = get_defaultChannel(L,type)
% Generate a channel object
% L    : normalized sample index of the last multipath (1<L<=100;index=0:L)
% type :
%       -Indoor (5GHz)
%       'EXP' (exponential decay, 0 to -8.7dB)
%       'HLA' (HyperLAN, maximum delay 390ns)
%
%       -LTE (2GHz) 
%       'EPA' (extended pedestrian A model, maximum delay 410ns)
%       'EVA' (extended vehicular A model, maximum delay 2510ns)
%       'ETU' (extended typical urban model, maximum delay 5000ns)
%
%       -Car-2-X (6GHz, 6 tap double dispersive empirical channels)
%       'RLOS' (rural line of sight, maximum delay 183ns)
%       'HLOS' (highway line of sight, maximum delay 500ns)
%       'UALOS' (urban approaching line of sight, maximum delay 333ns)
%       'HNLOS' (highway non line of sight, maximum delay 700ns)
%       'CNLOS' (Crossing non line of sight, maximum delay 533ns)
%

dexp =  0:L;
gexp =  linspace(0,-20, L+1);
        
dhla =  [   0   10      20      30      40      50      60      70     80       90      110     140     170     200     240     290     340     390                                 ];
ghla =  [   0   -0.9    -1.7    -2.6    -3.5    -4.3    -5.2    -6.1   -6.9     -7.8    -4.7    -9.3    -9.9    -12.5   -13.7   -18     -22.4   -26.7                               ];
                                                                                                                                                                                    
depa =  [   0                   30                              70              90      110                     190                             410                                 ];
gepa =  [   0                   -1                              -2              -3      -8                      -17.2                           -20.8                               ];
                                                                                                                                                                                    
deva =  [   0                   30                                                                      150                     310     370     710     1090    1730    2510        ];
geva =  [   0                   -1.5                                                                    -1.4                    -3.6    -0.6    -9.1    -7      -12     -16.9       ];
        
detu =  [   0                                   50                                      120                     200     230                     500             1600    2300    5000];
getu =  [   -1                                  -1                                      -1                      0       0                       0               -3      -5      -7  ];

drlos = [   0                                                          83                               183                                                                         ];
grlos = [   0                                                          -14                              -10                                                                         ];
frlos = [   0                                                          492                              -295                                                                        ]; 
                                                                                                                                                                                    
dhlos = [   0                                                                           100             167                                     500                                 ];
ghlos = [   0                                                                           -10             -15                                     -20                                 ];
fhlos = [   0                                                                           689             -492                                    886                                 ]; 
                                                                                                                                                                                    
dualos= [   0                                                                           117             183                                     333                                 ];
gualos= [   0                                                                           -8              -10                                     -15                                 ];
fualos= [   0                                                                           236             -157                                    492                                 ]; 
                                                                                                                                                                                    
dhnlos= [   0                                                                                                   200                     433     700                                 ];
ghnlos= [   0                                                                                                   -2                      -5      -7                                  ];
fhnlos= [   0                                                                                                   689                     -492    886                                 ]; 
                                                                                                                                                                                    
dcnlos= [   0                                                                                                                   267     400     533                                 ];
gcnlos= [   0                                                                                                                   -3      -5      -10                                 ];
fcnlos= [   0                                                                                                                   295     -98      591                                ]; 

switch type
    case 'EXP'  , fd =   5/1.08e9*5e9; k = 0                             ; tau = dexp  ; pdb = gexp  ;  fdLOS = 0     ;
    case 'HLA'  , fd =   5/1.08e9*5e9; k = 0                             ; tau = dhla  ; pdb = ghla  ;  fdLOS = 0     ;
    case 'EPA'  , fd =   5/1.08e9*2e9; k = 0                             ; tau = depa  ; pdb = gepa  ;  fdLOS = 0     ;
    case 'EVA'  , fd =  50/1.08e9*2e9; k = 0                             ; tau = deva  ; pdb = geva  ;  fdLOS = 0     ;
    case 'ETU'  , fd =  50/1.08e9*2e9; k = 0                             ; tau = detu  ; pdb = getu  ;  fdLOS = 0     ;
    case 'RLOS' , fd = 144/1.08e9*6e9; k = [10 zeros(1,length(frlos)-1) ]; tau = drlos ; pdb = grlos ;  fdLOS = frlos ;  
    case 'HLOS' , fd = 252/1.08e9*6e9; k = [10 zeros(1,length(fhlos)-1) ]; tau = dhlos ; pdb = ghlos ;  fdLOS = fhlos ;  
    case 'UALOS', fd = 119/1.08e9*6e9; k = [10 zeros(1,length(fualos)-1)]; tau = dualos; pdb = gualos;  fdLOS = fualos; 
    case 'HNLOS', fd = 252/1.08e9*6e9; k = zeros(1,length(fualos))       ; tau = dhnlos; pdb = ghnlos;  fdLOS = fhnlos;
    case 'CNLOS', fd = 126/1.08e9*6e9; k = zeros(1,length(fualos))       ; tau = dcnlos; pdb = gcnlos;  fdLOS = fcnlos;
    otherwise error('Channel Type not implemented!');
end
ts=max(tau)/L*1e-9;

chan = ricianchan(ts,fd,k,tau*1e-9,pdb,fdLOS);
chan.StoreHistory = true;

end
