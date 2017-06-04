% GLU 2017, p(W | E, F)
% Giovanni Saponaro, Giampiero Salvi

%% configure BNT and other paths
addpath(genpath('~/matlab/toolbox/FullBNT-1.0.4'))
addpath('.');

% set to full path to <vislab svn repository>/app/baltazar/Affordances/speech/bayesian_net
LanguageBoostrapping_root = ('~/NOBACKUP/vislab/app/baltazar/Affordances/speech/bayesian_net');

addpath(genpath([LanguageBoostrapping_root '/matlab']))

%% load Bayesian Network from .mat
load('BN_lab.mat');

%% old experiment
% %% enter node evidence for Action, Effect and Features (object) nodes
% nodevaluepairs = {'ObjVel', 'fast', 'ObjHandVel', 'medium', 'Color', 'yellow', 'Shape', 'circle', 'Size', 'small'};
% netobj_lab = BNEnterNodeEvidence(netobj_lab, nodevaluepairs, 0);
% 
% %% print Word node names
% wordNames = netobj_lab.nodeNames(1,9:end);
% 
% %% extract predictions (posteriors) of Words being said
% wordProbsWithoutA = BNGetWordProbs(netobj_lab);
% 
% %% print Word->prob table
% numWords = 49;
% resultWithoutA = cell(numWords,2);
% for (w = 1:numWords)
%     resultWithoutA{w,1} = string(wordNames(w));
%     resultWithoutA{w,2} = wordProbsWithoutA(1,w);
% end
% resultWithoutA