function setPath
d = fileparts(mfilename('fullpath'));
fprintf('Setting path for GFDM lib\n');
addpath(genpath(fullfile(d, 'gfdmlib')));

addpath(fullfile(d, '3rdparty'));
addpath(fullfile(d, '3rdparty/xunit'));
end