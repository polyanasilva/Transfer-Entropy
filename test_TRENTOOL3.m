% esse aqui deu tudo certo até agora

% Assuming data is already preprocessed with FieldTrip
OutputDataPath = 'D:\codigos\lab\';
InputDataPath = 'PreprocessedData.mat';
load(InputDataPath);

% Adicionar FieldTrip e TRENTOOL ao caminho
addpath('D:\codigos\lab\fieldtrip-20240603');
addpath('D:\codigos\lab\TRENTOOL3-3.4.2');
ft_defaults;

%% define cfg for TEprepare
cfgTEP         = [];

% data
cfgTEP.toi     = [min(preprocessed_data.time{1,1}), max(preprocessed_data.time{1,1})]; % time of interest

cfgTEP.sgncmb  = {'Chan1' 'Chan2'}; % channels to be analyzed

% scanning of interaction delays u 
cfgTEP.predicttime_u       = 100;
cfgTEP.predicttimemin_u    = 40; %minimum u to be scanned
cfgTEP.predicttimemax_u    = 50;
cfgTEP.predicttimestepsize = 1;

% estimator
cfgTEP.TEcalctype      = 'VW_ds'; % por algum motivo eu tinha comentado isso

% use ensemble method
cfgTEP.ensemblemethod  = 'no';

% ACT estimation and constraints on allowed ACT(autocorreation time)
cfgTEP.actthrvalue     = 40; %threshold for ACT
cfgTEP.maxlag          = 100; %default value
cfgTEP.minnrtrials     = 5; 

% optimizing embedding
cfgTEP.optimizemethod  = 'ragwitz';
cfgTEP.ragdim          = 2:8;      % range of embedding dimensions to scan vector from 1 to n
cfgTEP.ragtaurange     = [0.2 0.4];   % range for tau
cfgTEP.ragtausteps     = 15;        % steps for ragwitz tau steps
cfgTEP.repPred         = 100;      % points used for optimization the embedding dimensions

% kernel-based TE estimation
cfgTEP.flagNei         = 'Mass';   % type of neighbor search
cfgTEP.sizeNei         = 4;        % neighbors to analyse IMPORTANTE!!!

% fim da parte TEprepare
data_prepared = TEprepare(cfgTEP, preprocessed_data);
disp(data_prepared);

