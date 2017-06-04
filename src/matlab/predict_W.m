% GLU 2017, experiments with predictions of words
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

netobj_lab = BNEnterNodeEvidence(netobj_lab, {'Color', 'yellow', ...
    'Size', 'big', 'Shape', 'circle', 'ObjVel', 'fast'});
probs = BNGetWordProbs(netobj_lab);
probs = probs/sum(probs);
netobj_lab = BNEnterNodeEvidence(netobj_lab, {'Action', 'tap'});
probs2 = BNGetWordProbs(netobj_lab);
probs2 = probs2/sum(probs2);
plot(probs)
hold on
plot(probs2,'r')

% Word node names
wordNames = netobj_lab.nodeNames(1,9:end);