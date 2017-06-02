% GLU 2017, p(W | E, F)
% Giovanni Saponaro, Giampiero Salvi

%% configure BNT and other paths
addpath(genpath('~/matlab/toolbox/FullBNT-1.0.4'))
addpath('.');

% set to full path to <vislab svn repository>/app/baltazar/Affordances/speech/bayesian_net
LanguageBoostrapping_root = ('~/NOBACKUP/vislab/app/baltazar/Affordances/speech/bayesian_net');

addpath([LanguageBoostrapping_root '/matlab'])

%% load Bayesian Network from .mat
load('BN_lab.mat');

%% go to directory with BN functions
cd(LanguageBoostrapping_root);

%% enter node evidence for Action, Effect and Features (object) nodes
nodevaluepairs = {'ObjVel', 'fast', 'ObjHandVel', 'fast', 'Color', 'yellow', 'Shape', 'circle', 'Size', 'small'};
netobj_lab = BNEnterNodeEvidence(netobj_lab, nodevaluepairs, 0);

%% extract predictions (posteriors) of Words being said
wordProbsWithoutA = BNGetWordProbs(netobj_lab)