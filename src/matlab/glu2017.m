% GLU 2017
% Giovanni Saponaro

%% configure BNT and other paths
addpath(genpath('~/matlab/toolbox/FullBNT-1.0.4'))
%addpath('./matlab')
test_path = [getenv('HOME') '/Dropbox/phd/work-2017/work-2017-05/glu2017_oni_videos'];

%% load HMM gesture models trained for CR-HRI 2013 article
% hmm1: tap
% [no touch model]
% hmm3: grasp
% hmm4: push
% [hmm0: garbage]
load HMM_M3_Q6_mixsplit;
fprintf('1: tap, 2: grasp, 3: push\n');
%% load 2017 test data (removing first 2 columns)
tap1_fid = fopen([test_path '/tap1_hand/data.log']);
tap1 = textscan(tap1_fid, '%d %f %f %f %f');
tap1{1,1} = [];
tap1{1,2} = [];
tap1 = cell2mat(tap1);
tap1 = tap1 / 1000; % compatibility with 2013 models
clear tap1_fid;

%% test data segmentation
shrink = 10;
tap1_seglim = [206+shrink 391+shrink 547+shrink;
               361-shrink 521-shrink 674-shrink];
% they were determined by inspecting yarp ppm image numbers:
% [345 530 686;
%  500 660 813]
% and corresponding timestamps:
% [1495933420.892006 1495933426.944280 1495933432.054602;
%  1495933425.965962 1495933431.200979 1495933436.206443]

tap1_cell = separate_sequence(tap1, tap1_seglim);

%% transpose to BNT format
% i.e. from data{example}(frame,coord) to data{example}(coord,frame)
tap1_BNT = transpose_cell_array(tap1_cell);

%% classification
fprintf('===============================================================\n\n');
fprintf('classification of segmented sequence tap1 (ground truth: 1):\n');
counter = zeros(4,1);
for ex = 1:length(tap1_BNT)
    score(1) = mhmm_logprob(tap1_BNT{ex}, hmm1_prior, hmm1_trans, hmm1_mu, hmm1_Sigma, hmm1_mixmat);
    %score(2) = mhmm_logprob(tap1_BNT{ex}, hmm0_prior, hmm0_trans, hmm0_mu, hmm0_Sigma, hmm0_mixmat); % garbage
    %score(3) = mhmm_logprob(tap1_BNT{ex}, hmm3_prior, hmm3_trans, hmm3_mu, hmm3_Sigma, hmm3_mixmat);
    %score(4) = mhmm_logprob(tap1_BNT{ex}, hmm4_prior, hmm4_trans, hmm4_mu, hmm4_Sigma, hmm4_mixmat);
    score(2) = mhmm_logprob(tap1_BNT{ex}, hmm3_prior, hmm3_trans, hmm3_mu, hmm3_Sigma, hmm3_mixmat);
    score(3) = mhmm_logprob(tap1_BNT{ex}, hmm4_prior, hmm4_trans, hmm4_mu, hmm4_Sigma, hmm4_mixmat);
    %score
    [~,local_winner] = max(score);
    counter(local_winner) = counter(local_winner)+1;
    fprintf('sequence %d, winner: %d\n', ex, local_winner);
    clear score winner;
end;
[~,global_winner] = max(counter);
fprintf('majority winner: %d\n\n', global_winner);
clear ex counter global_winner;
