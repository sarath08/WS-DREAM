clc; close all; clear;

addpath('src');
logger('===============================');
logger('PMF: Probabilistic Matrix Factorization.');
logger('===============================');

% * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
% config area 
density = [0.01 : 0.01 : 0.05, 0.1 : 0.05 : 0.5]; % matrix density
rounds = 20; % how many runs are performed at each matrix density
dimension = 10; % dimenisionality of the latent factors
etaInit = 0.01; % inital learning rate. We use line search to find the best eta at each iteration
lambda = 30; % regularization parameter
maxIter = 400; % the max iterations
saveTimeInfo = false; % whether to keep track of the running time
debugMode = false; % whether to log some debugging info
% * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *

% set parameters of PMF algorithms
paraStruct = struct('rounds', rounds, 'dimension', dimension, 'etaInit', etaInit, 'lambda', lambda,... 
    'maxIter', maxIter, 'saveTimeInfo', saveTimeInfo, 'debugMode', debugMode); 

% create resultFolder
if exist('resultFolder', 'dir') == 0
    system('mkdir resultFolder');
end

% load the dataset
dataPath = '../data/dataset#1/rawData/rtMatrix.txt';
logger(sprintf('Load data: %s', dataPath));
dataMatrix = load(dataPath);

% run for each density
runTime = tic; % start timing
for i = 1 : length(density)
    dataFolder = sprintf('../data/dataset#1/generatedData/RT/density_%.2f', density(i));
    outPath = sprintf('resultFolder/rtResult_%.2f.txt', density(i));
    PMF(dataMatrix, dataFolder, outPath, density(i), paraStruct);
end  

logger('===============================');
logger(sprintf('All done. Total running time: %f s', toc(runTime)));
logger('===============================');
rmpath('src');

 