clear
close all

%wordtoVerify = {'CLAW'}% 'CRICKET' 'FLAG' 'FORK' 'LION' 'MEDAL' 'OYSTER' 'SERPENT' 'SHELF' 'SHIRT'};
wordtoVerify = {'CLAW' 'CRICKET' 'FLAG' 'FORK' 'LION' 'MEDAL' 'OYSTER' 'SERPENT' 'SHELF' 'SHIRT'};

%unit_sel = [5, 6, 7, 8, 9, 23, 42, 43, 55, 57, 60, 61, 62, 66, 67, 71];
unit_sel = [1, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 23, 24, 30, 33, 39, 40, 41, 42, 44, 45, 46, 47, 49, 50, 51, 53, 57, 60, 65, 66, 67, 68, 69, 70, 73, 74, 75, 76, 77, 78, 80, 82, 83, 84, 86, 87, 88, 89, 93, 94, 95, 97, 102, 103, 104, 105, 111, 112, 113, 114, 118, 120, 121, 129, 130, 131, 132, 134, 135, 136, 138, 141, 144, 145, 151, 154, 155, 157, 158, 159, 166, 167, 168, 169, 170, 171, 174, 181, 189, 193];
%unit_sel = [1:199];
bin_sel = [1:19];

def_epoch_name   = 'PRE';
def_binsize = 50;
def_bin_count = length(bin_sel);
def_cell_count = length(unit_sel);

def_ylim = [0 0.1; 0 0.1; 0.5 0.8; 0.2 0.4; 0.6 0.8; 0.5 0.7; 0 0.1; 0.7 0.9; 0.4 0.8; 0.2 0.5];

load(['./data/AvgSpikePerSec_' def_epoch_name '_bin' int2str(def_binsize) '.mat']);                               % load firing bin map of the epoch
load(['../2WaySVM/stat_total_balance_' int2str(def_cell_count) '_' int2str(def_binsize) 'ms.mat']);     % load SVM files
load('../SA_Units/mg49_sa_event.mat')

mkdir('./data');
mkdir('./plots');

%{
%%%%%%%%%%%%%%%%%%%%%%%%% 16 / pre

unit_sel = [5, 6, 7, 8, 9, 23, 42, 43, 55, 57, 60, 61, 62, 66, 67, 71];
%unit_sel = [1, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 23, 24, 30, 33, 39, 40, 41, 42, 44, 45, 46, 47, 49, 50, 51, 53, 57, 60, 65, 66, 67, 68, 69, 70, 73, 74, 75, 76, 77, 78, 80, 82, 83, 84, 86, 87, 88, 89, 93, 94, 95, 97, 102, 103, 104, 105, 111, 112, 113, 114, 118, 120, 121, 129, 130, 131, 132, 134, 135, 136, 138, 141, 144, 145, 151, 154, 155, 157, 158, 159, 166, 167, 168, 169, 170, 171, 174, 181, 189, 193];
%unit_sel = [1:199];
bin_sel = [1:19];

def_epoch_name   = 'PRE';
def_binsize = 50;
def_bin_count = length(bin_sel);
def_cell_count = length(unit_sel);

load(['./data/AvgSpikePerSec_' def_epoch_name '_bin' int2str(def_binsize) '.mat']);                               % load firing bin map of the epoch
%load(['../2WaySVM/stat_total_balance_' int2str(def_cell_count) '_' int2str(def_binsize) 'ms.mat']);     % load SVM files

OBJ     = PRE_bin;
OBJ_sel = OBJ(unit_sel, :);

trialSet = [];
wordSet = [];

% PCA WxT

mkdir('PCA_SVM/')

% build time-stamp matrix
stampSet = []
for iTime=1:(length(OBJ_sel(1,:))-(def_bin_count-1))
    A = OBJ_sel(:, iTime:(iTime+def_bin_count-1))';
    stampSet = [stampSet; A(:)'];
end

save(['./data/' def_epoch_name '_winArr_' int2str(def_cell_count) 'u_' int2str(def_binsize) 'bs.mat'], 'stampSet', '-v7.3');

%%%%%%%%%%%%%%%%%%%%%%%%% 16 / post

unit_sel = [5, 6, 7, 8, 9, 23, 42, 43, 55, 57, 60, 61, 62, 66, 67, 71];
%unit_sel = [1, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 23, 24, 30, 33, 39, 40, 41, 42, 44, 45, 46, 47, 49, 50, 51, 53, 57, 60, 65, 66, 67, 68, 69, 70, 73, 74, 75, 76, 77, 78, 80, 82, 83, 84, 86, 87, 88, 89, 93, 94, 95, 97, 102, 103, 104, 105, 111, 112, 113, 114, 118, 120, 121, 129, 130, 131, 132, 134, 135, 136, 138, 141, 144, 145, 151, 154, 155, 157, 158, 159, 166, 167, 168, 169, 170, 171, 174, 181, 189, 193];
%unit_sel = [1:199];
bin_sel = [1:19];

def_epoch_name   = 'POST';
def_binsize = 50;
def_bin_count = length(bin_sel);
def_cell_count = length(unit_sel);

load(['./data/AvgSpikePerSec_' def_epoch_name '_bin' int2str(def_binsize) '.mat']);                               % load firing bin map of the epoch
load(['../2WaySVM/stat_total_balance_' int2str(def_cell_count) '_' int2str(def_binsize) 'ms.mat']);     % load SVM files

OBJ     = POST_bin;
OBJ_sel = OBJ(unit_sel, :);

trialSet = [];
wordSet = [];

% PCA WxT

mkdir('PCA_SVM/')

% build time-stamp matrix
stampSet = []
for iTime=1:(length(OBJ_sel(1,:))-(def_bin_count-1))
    A = OBJ_sel(:, iTime:(iTime+def_bin_count-1))';
    stampSet = [stampSet; A(:)'];
end

save(['./data/' def_epoch_name '_winArr_' int2str(def_cell_count) 'u_' int2str(def_binsize) 'bs.mat'], 'stampSet', '-v7.3');


%%%%%%%%%%%%%%%%%%%%%%%%% 91 / pre

%unit_sel = [5, 6, 7, 8, 9, 23, 42, 43, 55, 57, 60, 61, 62, 66, 67, 71];
unit_sel = [1, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 23, 24, 30, 33, 39, 40, 41, 42, 44, 45, 46, 47, 49, 50, 51, 53, 57, 60, 65, 66, 67, 68, 69, 70, 73, 74, 75, 76, 77, 78, 80, 82, 83, 84, 86, 87, 88, 89, 93, 94, 95, 97, 102, 103, 104, 105, 111, 112, 113, 114, 118, 120, 121, 129, 130, 131, 132, 134, 135, 136, 138, 141, 144, 145, 151, 154, 155, 157, 158, 159, 166, 167, 168, 169, 170, 171, 174, 181, 189, 193];
%unit_sel = [1:199];
bin_sel = [1:19];

def_epoch_name   = 'PRE';
def_binsize = 50;
def_bin_count = length(bin_sel);
def_cell_count = length(unit_sel);

load(['./data/AvgSpikePerSec_' def_epoch_name '_bin' int2str(def_binsize) '.mat']);                               % load firing bin map of the epoch
load(['../2WaySVM/stat_total_balance_' int2str(def_cell_count) '_' int2str(def_binsize) 'ms.mat']);     % load SVM files

OBJ     = PRE_bin;
OBJ_sel = OBJ(unit_sel, :);

trialSet = [];
wordSet = [];

% PCA WxT

mkdir('PCA_SVM/')

% build time-stamp matrix
stampSet = []
for iTime=1:(length(OBJ_sel(1,:))-(def_bin_count-1))
    A = OBJ_sel(:, iTime:(iTime+def_bin_count-1))';
    stampSet = [stampSet; A(:)'];
end

save(['./data/' def_epoch_name '_winArr_' int2str(def_cell_count) 'u_' int2str(def_binsize) 'bs.mat'], 'stampSet', '-v7.3');


%%%%%%%%%%%%%%%%%%%%%%%%% 91 / post

%unit_sel = [5, 6, 7, 8, 9, 23, 42, 43, 55, 57, 60, 61, 62, 66, 67, 71];
unit_sel = [1, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 23, 24, 30, 33, 39, 40, 41, 42, 44, 45, 46, 47, 49, 50, 51, 53, 57, 60, 65, 66, 67, 68, 69, 70, 73, 74, 75, 76, 77, 78, 80, 82, 83, 84, 86, 87, 88, 89, 93, 94, 95, 97, 102, 103, 104, 105, 111, 112, 113, 114, 118, 120, 121, 129, 130, 131, 132, 134, 135, 136, 138, 141, 144, 145, 151, 154, 155, 157, 158, 159, 166, 167, 168, 169, 170, 171, 174, 181, 189, 193];
%unit_sel = [1:199];
bin_sel = [1:19];

def_epoch_name   = 'POST';
def_binsize = 50;
def_bin_count = length(bin_sel);
def_cell_count = length(unit_sel);

load(['../data/AvgSpikePerSec_' def_epoch_name '_bin' int2str(def_binsize) '.mat']);                               % load firing bin map of the epoch
load(['../2WaySVM/stat_total_balance_' int2str(def_cell_count) '_' int2str(def_binsize) 'ms.mat']);     % load SVM files

OBJ     = POST_bin;
OBJ_sel = OBJ(unit_sel, :);

trialSet = [];
wordSet = [];

% PCA WxT

mkdir('PCA_SVM/')

% build time-stamp matrix
stampSet = []
for iTime=1:(length(OBJ_sel(1,:))-(def_bin_count-1))
    A = OBJ_sel(:, iTime:(iTime+def_bin_count-1))';
    stampSet = [stampSet; A(:)'];
end

save(['./data/' def_epoch_name '_winArr_' int2str(def_cell_count) 'u_' int2str(def_binsize) 'bs.mat'], 'stampSet', '-v7.3');

%%%%%%%%%%%%%%%%%%%%%%%%% 199 / pre

%unit_sel = [5, 6, 7, 8, 9, 23, 42, 43, 55, 57, 60, 61, 62, 66, 67, 71];
%unit_sel = [1, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 23, 24, 30, 33, 39, 40, 41, 42, 44, 45, 46, 47, 49, 50, 51, 53, 57, 60, 65, 66, 67, 68, 69, 70, 73, 74, 75, 76, 77, 78, 80, 82, 83, 84, 86, 87, 88, 89, 93, 94, 95, 97, 102, 103, 104, 105, 111, 112, 113, 114, 118, 120, 121, 129, 130, 131, 132, 134, 135, 136, 138, 141, 144, 145, 151, 154, 155, 157, 158, 159, 166, 167, 168, 169, 170, 171, 174, 181, 189, 193];
unit_sel = [1:199];
bin_sel = [1:19];

def_epoch_name   = 'PRE';
def_binsize = 50;
def_bin_count = length(bin_sel);
def_cell_count = length(unit_sel);

load(['./data/AvgSpikePerSec_' def_epoch_name '_bin' int2str(def_binsize) '.mat']);                               % load firing bin map of the epoch
load(['../2WaySVM/stat_total_balance_' int2str(def_cell_count) '_' int2str(def_binsize) 'ms.mat']);     % load SVM files

OBJ     = PRE_bin;
OBJ_sel = OBJ(unit_sel, :);

trialSet = [];
wordSet = [];

% PCA WxT

mkdir('PCA_SVM/')

% build time-stamp matrix
stampSet = []
for iTime=1:(length(OBJ_sel(1,:))-(def_bin_count-1))
    A = OBJ_sel(:, iTime:(iTime+def_bin_count-1))';
    stampSet = [stampSet; A(:)'];
end

save(['./data/' def_epoch_name '_winArr_' int2str(def_cell_count) 'u_' int2str(def_binsize) 'bs.mat'], 'stampSet', '-v7.3');

%%%%%%%%%%%%%%%%%%%%%%%%% 199 / task

%unit_sel = [5, 6, 7, 8, 9, 23, 42, 43, 55, 57, 60, 61, 62, 66, 67, 71];
%unit_sel = [1, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 23, 24, 30, 33, 39, 40, 41, 42, 44, 45, 46, 47, 49, 50, 51, 53, 57, 60, 65, 66, 67, 68, 69, 70, 73, 74, 75, 76, 77, 78, 80, 82, 83, 84, 86, 87, 88, 89, 93, 94, 95, 97, 102, 103, 104, 105, 111, 112, 113, 114, 118, 120, 121, 129, 130, 131, 132, 134, 135, 136, 138, 141, 144, 145, 151, 154, 155, 157, 158, 159, 166, 167, 168, 169, 170, 171, 174, 181, 189, 193];
unit_sel = [1:199];
bin_sel = [1:19];

def_epoch_name   = 'TASK';
def_binsize = 50;
def_bin_count = length(bin_sel);
def_cell_count = length(unit_sel);

load(['./data/AvgSpikePerSec_' def_epoch_name '_bin' int2str(def_binsize) '.mat']);                               % load firing bin map of the epoch
load(['../2WaySVM/stat_total_balance_' int2str(def_cell_count) '_' int2str(def_binsize) 'ms.mat']);     % load SVM files

OBJ     = TASK_bin;
OBJ_sel = OBJ(unit_sel, :);

trialSet = [];
wordSet = [];

% PCA WxT

mkdir('PCA_SVM/')

% build time-stamp matrix
stampSet = []
for iTime=1:(length(OBJ_sel(1,:))-(def_bin_count-1))
    A = OBJ_sel(:, iTime:(iTime+def_bin_count-1))';
    stampSet = [stampSet; A(:)'];
end

save(['./data/' def_epoch_name '_winArr_' int2str(def_cell_count) 'u_' int2str(def_binsize) 'bs.mat'], 'stampSet', '-v7.3');

%%%%%%%%%%%%%%%%%%%%%%%%% 199 / post

%unit_sel = [5, 6, 7, 8, 9, 23, 42, 43, 55, 57, 60, 61, 62, 66, 67, 71];
%unit_sel = [1, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 23, 24, 30, 33, 39, 40, 41, 42, 44, 45, 46, 47, 49, 50, 51, 53, 57, 60, 65, 66, 67, 68, 69, 70, 73, 74, 75, 76, 77, 78, 80, 82, 83, 84, 86, 87, 88, 89, 93, 94, 95, 97, 102, 103, 104, 105, 111, 112, 113, 114, 118, 120, 121, 129, 130, 131, 132, 134, 135, 136, 138, 141, 144, 145, 151, 154, 155, 157, 158, 159, 166, 167, 168, 169, 170, 171, 174, 181, 189, 193];
unit_sel = [1:199];
bin_sel = [1:19];

def_epoch_name   = 'POST';
def_binsize = 50;
def_bin_count = length(bin_sel);
def_cell_count = length(unit_sel);

load(['./data/AvgSpikePerSec_' def_epoch_name '_bin' int2str(def_binsize) '.mat']);                               % load firing bin map of the epoch
load(['../2WaySVM/stat_total_balance_' int2str(def_cell_count) '_' int2str(def_binsize) 'ms.mat']);     % load SVM files

OBJ     = POST_bin;
OBJ_sel = OBJ(unit_sel, :);

trialSet = [];
wordSet = [];

% PCA WxT

mkdir('PCA_SVM/')

% build time-stamp matrix
stampSet = []
for iTime=1:(length(OBJ_sel(1,:))-(def_bin_count-1))
    A = OBJ_sel(:, iTime:(iTime+def_bin_count-1))';
    stampSet = [stampSet; A(:)'];
end

save(['./data/' def_epoch_name '_winArr_' int2str(def_cell_count) 'u_' int2str(def_binsize) 'bs.mat'], 'stampSet', '-v7.3');
%}
%%%%%%%%%%%%%%%% stop!!!

load(['./data/PRE_winArr_' int2str(def_cell_count) 'u_' int2str(def_binsize) 'bs.mat']);

for iWord=1:length(wordtoVerify)
    
    figure;
    
    %%%PRE
    % find the best SVM
    best_SVM = [];
    best_PC = [];
    best_Accuracy = 0;
    
    score_plot{iWord} = [];
    for nPC=1:length(stat_total{1, iWord}.data)
        if(max(stat_total{1, iWord}.data(1, nPC).HR) > best_Accuracy)
            best_Accuracy = max(stat_total{1, iWord}.data(1, nPC).HR);
            best = find(stat_total{1, iWord}.data(1, nPC).HR == max(stat_total{1, iWord}.data(1, nPC).HR), 1);
            
            best_SVM = stat_total{1, iWord}.data(1, nPC).svm{1, best};
            best_PC = stat_total{1, iWord}.data(1, nPC).pc{1, best};
        end
    end
    % verifcation

    accusum = [];
    for iTime=1:length(stampSet(:, 1))
        resultSet = svmclassify(best_SVM, stampSet(iTime, :) * best_PC);
        score_plot{iWord} = [score_plot{iWord}; sum(resultSet)];
    end
    B = cumsum(score_plot{iWord});
    for iTime=1:length(stampSet(:, 1))
        accusum(iTime) = B(iTime)/iTime;
    end
    %save(['./data/score_plot_balance_' def_epoch_name '_' int2str(def_cell_count) 'u_' int2str(def_binsize) 'ms' ], 'score_plot', '-v7.3')

    subplot(1, 3, 1), plot(accusum);
    %plot(cumsum(score_plot{iWord}))
    xlabel('Bin #'); ylabel('Average # of Hits');
    ylim(def_ylim(iWord, :));
    title(['PRE ' int2str(def_cell_count) 'u ' int2str(def_binsize) 'ms']);

    %%% TASK
    load(['./data/TASK_winArr_' int2str(def_cell_count) 'u_' int2str(def_binsize) 'bs.mat']);
   
    % find the best SVM
    best_SVM = [];
    best_PC = [];
    best_Accuracy = 0;
    
    score_plot{iWord} = [];
    for nPC=1:length(stat_total{1, iWord}.data)
        if(max(stat_total{1, iWord}.data(1, nPC).HR) > best_Accuracy)
            best_Accuracy = max(stat_total{1, iWord}.data(1, nPC).HR);
            best = find(stat_total{1, iWord}.data(1, nPC).HR == max(stat_total{1, iWord}.data(1, nPC).HR), 1);
            
            best_SVM = stat_total{1, iWord}.data(1, nPC).svm{1, best};
            best_PC = stat_total{1, iWord}.data(1, nPC).pc{1, best};
        end
    end
    % verifcation
    
    accusum = [];
    for iTime=1:length(stampSet(:, 1))
        resultSet = svmclassify(best_SVM, stampSet(iTime, :) * best_PC);
        score_plot{iWord} = [score_plot{iWord}; sum(resultSet)];
    end
    B = cumsum(score_plot{iWord});
    for iTime=1:length(stampSet(:, 1))
        accusum(iTime) = B(iTime)/iTime;
    end
    %save(['./data/score_plot_balance_' def_epoch_name '_' int2str(def_cell_count) 'u_' int2str(def_binsize) 'ms' ], 'score_plot', '-v7.3')

    subplot(1, 3, 2), plot(accusum);
    %plot(cumsum(score_plot{iWord}))
    xlabel('Bin #'); ylabel('Average # of Hits');
    ylim(def_ylim(iWord, :));
    title(['TASK ' int2str(def_cell_count) 'u ' int2str(def_binsize) 'ms']);

    hold on
    % add dots
    for iEvent=1:length(event)
        if strcmp(event(iEvent).type, wordtoVerify{iWord})
            t = event(iEvent).timestamp - 78974160)/(30*def_binsize);
            plot(t, accusum(floor(t)), 'or');
            hold on
        end
    end
    
    %%%POST
    
    load(['./data/POST_winArr_' int2str(def_cell_count) 'u_' int2str(def_binsize) 'bs.mat']);
    
    % find the best SVM
    best_SVM = [];
    best_PC = [];
    best_Accuracy = 0;
    
    score_plot{iWord} = [];
    for nPC=1:length(stat_total{1, iWord}.data)
        if(max(stat_total{1, iWord}.data(1, nPC).HR) > best_Accuracy)
            best_Accuracy = max(stat_total{1, iWord}.data(1, nPC).HR);
            best = find(stat_total{1, iWord}.data(1, nPC).HR == max(stat_total{1, iWord}.data(1, nPC).HR), 1);
            
            best_SVM = stat_total{1, iWord}.data(1, nPC).svm{1, best};
            best_PC = stat_total{1, iWord}.data(1, nPC).pc{1, best};
        end
    end
    % verifcation

    accusum = [];
    for iTime=1:length(stampSet(:, 1))
        resultSet = svmclassify(best_SVM, stampSet(iTime, :) * best_PC);
        score_plot{iWord} = [score_plot{iWord}; sum(resultSet)];
    end
    B = cumsum(score_plot{iWord});
    for iTime=1:length(stampSet(:, 1))
        accusum(iTime) = B(iTime)/iTime;
    end
    %save(['./data/score_plot_balance_' def_epoch_name '_' int2str(def_cell_count) 'u_' int2str(def_binsize) 'ms' ], 'score_plot', '-v7.3')

    subplot(1, 3, 3), plot(accusum);
    %plot(cumsum(score_plot{iWord}))
    xlabel('Bin #'); ylabel('Average # of Hits');
    ylim(def_ylim(iWord, :));
    title(['POST ' int2str(def_cell_count) 'u ' int2str(def_binsize) 'ms']);

    saveas(gcf, ['./plots/' wordtoVerify{iWord} '_accu_' int2str(def_binsize) 'ms.jpg'], 'jpg');
end
%}