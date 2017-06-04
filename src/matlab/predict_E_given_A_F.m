% GLU 2017, p(E | A, F)
% Giovanni Saponaro, Giampiero Salvi

%% configure BNT and other paths
addpath(genpath('~/matlab/toolbox/FullBNT-1.0.4'))
addpath('.');

% set to full path to <vislab svn repository>/app/baltazar/Affordances/speech/bayesian_net
LanguageBoostrapping_root = ('~/NOBACKUP/vislab/app/baltazar/Affordances/speech/bayesian_net');

addpath(genpath([LanguageBoostrapping_root '/matlab']))

%% load Bayesian Network from .mat
load('BN_lab.mat');

%% uncomment to re-train the network
% %% 1) create initial word-affordance network
% netobj_lab = createBN('config/networkDefinition.txt');
% 
% %% 2) set default properties (node types, initial connections...)
% netobj_lab = BNSetDefaults(netobj_lab);
% 
% %% 3) load data from text file (coming from ../asr_htk/workdir)
% netobj_lab = BNLoadData(netobj_lab, 'data/sent-1-5_lab_aff_bag.txt');
% 
% %% 3) learn the structure of the net
% netobj_lab = BNLearnStructure(netobj_lab);
% 
% %% 4) learn the parameters of the net
% netobj_lab = BNLearnParameters(netobj_lab);

%% save Bayesian Network to .mat
%save('BN_lab.mat', 'netobj_lab');

%% enter node evidence for Action and Features (object) nodes
nodevaluepairs = {'Action', 'tap', 'Color', 'yellow', 'Shape', 'circle', 'Size', 'small'};
netobj_lab = BNEnterNodeEvidence(netobj_lab, nodevaluepairs, 0);

%% extract predictions (posteriors)
posteriornodes = {'ObjVel', 'ObjHandVel'};
pred_lab_circle = BNSoftPredictionAccuracy2(netobj_lab, posteriornodes);
disp('p(ObjVel, ObjHandVel | A=tap, F=circle small)');
pred_lab_circle.T

%% enter node evidence for Action and Features (object) nodes
nodevaluepairs = {'Action', 'tap', 'Color', 'blue', 'Shape', 'box', 'Size', 'big'};
disp('p(ObjVel, ObjHandVel | A=tap, F=box big)');
netobj_lab = BNEnterNodeEvidence(netobj_lab, nodevaluepairs, 0);

%% extract predictions (posteriors)
posteriornodes = {'ObjVel', 'ObjHandVel'};
pred_lab_box = BNSoftPredictionAccuracy2(netobj_lab, posteriornodes);
pred_lab_box.T