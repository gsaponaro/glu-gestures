% GLU 2017, experiments with predictions of words
% Giovanni Saponaro, Giampiero Salvi

%% configure BNT and other paths
addpath(genpath('~/matlab/toolbox/FullBNT-1.0.4'))
addpath('.');

% set to full path to <vislab svn repository>/app/baltazar/Affordances/speech/bayesian_net
LanguageBoostrapping_root = ('~/NOBACKUP/vislab/app/baltazar/Affordances/speech/bayesian_net');

addpath(genpath([LanguageBoostrapping_root '/matlab']))

%% load Bayesian Network from .mat
load('BN_lab.mat');

netobj_lab = BNEnterNodeEvidence(netobj_lab, {'Color', 'yellow', ...
    'Size', 'big', 'Shape', 'circle', 'ObjVel', 'fast'});
probs = BNGetWordProbs(netobj_lab);
netobj_lab = BNEnterNodeEvidence(netobj_lab, {'Action', 'tap'});
probs2 = BNGetWordProbs(netobj_lab);

probdiff = probs2-probs;
figure;
bar(probdiff)
set(gca, 'xtick', 1:length(netobj_lab.WORDNODES))
set(gca, 'xticklabel', netobj_lab.nodeNames(netobj_lab.WORDNODES))
xtickangle(90)
%print -dsvg fullfig
print('-depsc', 'fullfig.eps');

toplot = abs(probdiff)>0.02;
figure;
bar(probdiff(toplot));
set(gca, 'xtick', 1:length(netobj_lab.WORDNODES(toplot)))
set(gca, 'xticklabel', netobj_lab.nodeNames(netobj_lab.WORDNODES(toplot)))
ylabel('$\Delta p(w_i)$', 'Interpreter','latex', 'FontSize', 20);
xtickangle(90)
print('-depsc', 'partialfig.eps');