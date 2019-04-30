function setup_paths()

% Add the neccesary paths
pathstr= fileparts(mfilename('fullpath'));

% Tracker implementation
addpath(genpath([pathstr '/implementation/']));

% Utilities
addpath(genpath([pathstr '/utils/']));

% The feature extraction
addpath(genpath([pathstr '/feature_extraction/']));

% Matconvnet
addpath([pathstr '/external_libs/matconvnet/matlab/mex/']);
addpath([pathstr '/external_libs/matconvnet/matlab']);
addpath([pathstr '/external_libs/matconvnet/matlab/simplenn']);

% PDollar toolbox
addpath(genpath([pathstr '/external_libs/toolbox/channels']));

% Mtimesx
addpath([pathstr '/external_libs/mtimesx/']);

% mexResize
addpath([pathstr '/external_libs/mexResize/']);
% vlfeat-0.9.21
addpath(genpath([pathstr '/external_libs/vlfeat-0.9.21/toolbox/']));
% 
% %SLEP
% addpath(genpath([ cd '/external_libs/SLEP_package_4.1/SLEP']));
% %CVX
% addpath(genpath([ cd '/external_libs/cvx/']));
