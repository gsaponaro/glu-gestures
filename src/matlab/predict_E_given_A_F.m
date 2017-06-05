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