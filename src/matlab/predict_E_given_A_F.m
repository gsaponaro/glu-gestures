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

%% experiment 1: small sphere
% enter node evidence for Action and Features (object) nodes
nodevaluepairs = {'Action', 'tap', 'Shape', 'circle', 'Size', 'small'};
netobj_lab = BNEnterNodeEvidence(netobj_lab, nodevaluepairs, 0);

% extract predictions (posteriors)
posteriornodes = {'ObjVel'};
pred_lab_circle = BNSoftPredictionAccuracy2(netobj_lab, posteriornodes);
figure;
bar(pred_lab_circle.T);
set(gca, 'FontSize', 20);
set(gca, 'xticklabel', {'slow','medium','fast'});
% sphere = circle
ylabel('$p(E \mid A=\mathrm{tap}, F=\mathrm{sphere, small})$', 'Interpreter', 'latex');
ylim([0 1]);
print('-depsc', 'effectpred_sphere.eps');

%% experiment 2: big box
% enter node evidence for Action and Features (object) nodes
nodevaluepairs = {'Action', 'tap', 'Shape', 'box', 'Size', 'big'};
netobj_lab = BNEnterNodeEvidence(netobj_lab, nodevaluepairs, 0);

% extract predictions (posteriors)
pred_lab_box = BNSoftPredictionAccuracy2(netobj_lab, posteriornodes);
figure;
bar(pred_lab_box.T);
set(gca, 'FontSize', 20);
set(gca, 'xticklabel', {'slow','medium','fast'});
ylabel('$p(E \mid A=\mathrm{tap}, F=\mathrm{box, big})$', 'Interpreter', 'latex');
print('-depsc', 'effectpred_box.eps');