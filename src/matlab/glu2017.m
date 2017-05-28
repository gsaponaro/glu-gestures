% GLU 2017
% Giovanni Saponaro

%% configure BNT and other paths
addpath(genpath('~/matlab/toolbox/FullBNT-1.0.4'))
addpath('./matlab')

test_path = '/home/g/Dropbox/phd/work-2017/work-2017-05/glu2017_oni_videos';

%% load HMM gesture models trained for CR-HRI 2013 article
load HMM_M3_Q6_mixsplit;

%% load 2017 test data (removing first 2 columns)
tap1_fid = fopen([test_path '/tap1_hand/data.log']);
tap1 = textscan(tap1_fid, '%d %f %f %f %f');
tap1{1,1} = [];
tap1{1,2} = [];
tap1 = cell2mat(tap1);
clear tap1_fid;

%% test data segmentation
% TODO real values
tap1_seglim = [90 132;
              100 135];

tap1_cell = separate_sequence(tap1, tap1_seglim);

%% transpose to BNT format
% i.e. from data{example}(frame,coord) to data{example}(coord,frame)
tap1_BNT = transpose_cell_array(tap1_cell);

%% classification
fprintf('===============================================================\n\n');

% TODO: also test with hmm0 (garbage)

fprintf('classification of segmented sequence tap1 (ground truth: class1):\n');
counter = zeros(4,1);
for ex = 1:length(tap1_BNT)
    score(1) = mhmm_logprob(tap1_BNT{ex}, hmm1_prior, hmm1_trans, hmm1_mu, hmm1_Sigma, hmm1_mixmat);
    %score(2) = mhmm_logprob(tap1_BNT{ex}, hmm2_prior, hmm2_trans, hmm2_mu, hmm2_Sigma, hmm2_mixmat);
    score(3) = mhmm_logprob(tap1_BNT{ex}, hmm3_prior, hmm3_trans, hmm3_mu, hmm3_Sigma, hmm3_mixmat);
    score(4) = mhmm_logprob(tap1_BNT{ex}, hmm4_prior, hmm4_trans, hmm4_mu, hmm4_Sigma, hmm4_mixmat);
    [~,local_winner] = max(score);
    counter(local_winner) = counter(local_winner)+1;
    fprintf('sequence %d, winner: hmm%d\n', ex, local_winner);
    clear score winner;
end;
[~,global_winner] = max(counter);
fprintf('majority winner: hmm%d\n\n', global_winner);
clear ex counter global_winner;
