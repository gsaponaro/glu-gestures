% GLU 2017, p(E | A, F)
% Giovanni Saponaro, Giampiero Salvi

%% configure BNT and other paths
addpath(genpath('~/matlab/toolbox/FullBNT-1.0.4'))
addpath('.');

% set to full path to <vislab svn repository>/app/baltazar/Affordances/speech/bayesian_net
LanguageBoostrapping_root = ('~/NOBACKUP/vislab/app/baltazar/Affordances/speech/bayesian_net');

addpath([LanguageBoostrapping_root '/matlab'])
cd(LanguageBoostrapping_root);

%% 1) create initial word-affordance network
netobj_lab = createBN('config/networkDefinition.txt');

%% 2) set default properties (node types, initial connections...)
netobj_lab = BNSetDefaults(netobj_lab);

%% 3) load data from text file (coming from ../asr_htk/workdir)
netobj_lab = BNLoadData(netobj_lab, 'data/sent-1-5_lab_aff_bag.txt');

%% 3) learn the structure of the net
netobj_lab = BNLearnStructure(netobj_lab);

%% 4) learn the parameters of the net
netobj_lab = BNLearnParameters(netobj_lab);

%% enter node evidence for Action and Features (object) nodes
nodevaluepairs = {'Action', 'tap', 'Color', 'yellow', 'Shape', 'circle', 'Size', 'small'};
netobj_lab = BNEnterNodeEvidence(netobj_lab, nodevaluepairs, 0);

%% extract predictions as in the first part of BNSoftPredictionAccuracy, now called BNSoftPredictionAccuracy2
pred_lab_circle = BNSoftPredictionAccuracy2(netobj_lab);
pred_lab_circle.T

%% enter node evidence for Action and Features (object) nodes
nodevaluepairs = {'Action', 'tap', 'Color', 'blue', 'Shape', 'box', 'Size', 'big'};
netobj_lab = BNEnterNodeEvidence(netobj_lab, nodevaluepairs, 0);

%% extract predictions as in the first part of BNSoftPredictionAccuracy, now called BNSoftPredictionAccuracy2
pred_lab_box = BNSoftPredictionAccuracy2(netobj_lab);
pred_lab_box.T