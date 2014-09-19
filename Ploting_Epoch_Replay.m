clear
close all

%wordtoVerify = {'CLAW'}% 'CRICKET' 'FLAG' 'FORK' 'LION' 'MEDAL' 'OYSTER' 'SERPENT' 'SHELF' 'SHIRT'};
wordtoVerify = {'CLAW' 'CRICKET' 'FLAG' 'FORK' 'LION' 'MEDAL' 'OYSTER' 'SERPENT' 'SHELF' 'SHIRT'};

unit_sel = [5, 6, 7, 8, 9, 23, 42, 43, 55, 57, 60, 61, 62, 66, 67, 71];
%unit_sel = [1, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 23, 24, 30, 33, 39, 40, 41, 42, 44, 45, 46, 47, 49, 50, 51, 53, 57, 60, 65, 66, 67, 68, 69, 70, 73, 74, 75, 76, 77, 78, 80, 82, 83, 84, 86, 87, 88, 89, 93, 94, 95, 97, 102, 103, 104, 105, 111, 112, 113, 114, 118, 120, 121, 129, 130, 131, 132, 134, 135, 136, 138, 141, 144, 145, 151, 154, 155, 157, 158, 159, 166, 167, 168, 169, 170, 171, 174, 181, 189, 193];
%unit_sel = [1:199];
bin_sel = [1:19];

def_epoch_name   = 'PRE';
def_binsize = 50;
def_bin_count = length(bin_sel);
def_cell_count = length(unit_sel);
def_linkaxes_on = 1; 
def_firing_control = 1;
def_trigger_threshold = 1;
def_trigger_feature = (19 * (find(unit_sel == 5) - 1)) + 3;

load(['./data/AvgSpikePerSec_' def_epoch_name '_bin' int2str(def_binsize) '.mat']);                     % load firing bin map of the epoch
load(['../2WaySVM/stat_total_balance_' int2str(def_cell_count) '_' int2str(def_binsize) 'ms.mat']);     % load SVM files
load('../SA_Units/mg49_sa_event.mat')

mkdir('./data');
mkdir('./plots');


for iWord=1:length(wordtoVerify)
    
    % find the best SVM
    best_SVM = [];
    best_PC = [];
    best_Accuracy = 0;
    
    for nPC=1:length(stat_total{1, iWord}.data)
        if(max(stat_total{1, iWord}.data(1, nPC).HR) > best_Accuracy)
            best_Accuracy = max(stat_total{1, iWord}.data(1, nPC).HR);
            best = find(stat_total{1, iWord}.data(1, nPC).HR == max(stat_total{1, iWord}.data(1, nPC).HR), 1);
            
            best_SVM = stat_total{1, iWord}.data(1, nPC).svm{1, best};
            best_PC = stat_total{1, iWord}.data(1, nPC).pc{1, best};
        end
    end
    
    % verifcation
    %%%PRE
    load(['./data/PRE_winArr_' int2str(def_cell_count) 'u_' int2str(def_binsize) 'bs.mat']);
    stampSet = stampSet(ceil(length(stampSet)*1/3):length(stampSet), :);   % pick only late 2/3 epoch
    
    figure(iWord);
    score_plot{iWord} = [];
    accusum = [];
    for iTime=1:length(stampSet(:, 1))
        if(~def_firing_control)
            resultSet = svmclassify(best_SVM, stampSet(iTime, :) * best_PC);
            score_plot{iWord} = [score_plot{iWord}; sum(resultSet)];
        elseif(stampSet(iTime, def_trigger_feature) >= def_trigger_threshold )
            resultSet = svmclassify(best_SVM, stampSet(iTime, :) * best_PC);
            score_plot{iWord} = [score_plot{iWord}; sum(resultSet)];
        else
            score_plot{iWord} = [score_plot{iWord}; 0];
        end
    end
    B = cumsum(score_plot{iWord});
    for iTime=1:length(stampSet(:, 1))
        accusum(iTime) = B(iTime)/iTime;
    end
    %save(['./data/score_plot_balance_' def_epoch_name '_' int2str(def_cell_count) 'u_' int2str(def_binsize) 'ms' ], 'score_plot', '-v7.3')

    
    if def_linkaxes_on
        linkaxes([subplot(1,3,1) subplot(1,3,2) subplot(1,3,3)] ,'y');
    end

    subplot(1, 3, 1), plot(accusum);
    %plot(cumsum(score_plot{iWord}))
    xlabel('Bin #'); ylabel('Average # of Hits');
    title(['PRE ' int2str(def_cell_count) 'u ' int2str(def_binsize) 'ms']);

    %%% TASK
    load(['./data/TASK_winArr_' int2str(def_cell_count) 'u_' int2str(def_binsize) 'bs.mat']);
    
    score_plot{iWord} = [];
    accusum = [];
    for iTime=1:length(stampSet(:, 1))
        if(~def_firing_control)
            resultSet = svmclassify(best_SVM, stampSet(iTime, :) * best_PC);
            score_plot{iWord} = [score_plot{iWord}; sum(resultSet)];
        elseif(stampSet(iTime, def_trigger_feature) >= def_trigger_threshold )
            resultSet = svmclassify(best_SVM, stampSet(iTime, :) * best_PC);
            score_plot{iWord} = [score_plot{iWord}; sum(resultSet)];
        else
            score_plot{iWord} = [score_plot{iWord}; 0];
        end
    end
    B = cumsum(score_plot{iWord});
    for iTime=1:length(stampSet(:, 1))
        accusum(iTime) = B(iTime)/iTime;
    end
    %save(['./data/score_plot_balance_' def_epoch_name '_' int2str(def_cell_count) 'u_' int2str(def_binsize) 'ms' ], 'score_plot', '-v7.3')

    subplot(1, 3, 2), plot(accusum);
    %plot(cumsum(score_plot{iWord}))
    xlabel('Bin #'); ylabel('Average # of Hits');
    title(['TASK ' int2str(def_cell_count) 'u ' int2str(def_binsize) 'ms']);

    % plot timing dots
    hold on
    % add dots
    for iEvent=1:length(event)
        if strcmp(event(iEvent).type, wordtoVerify{iWord})
            t = (event(iEvent).timestamp - 78974160)/(30*def_binsize);
            plot(t, accusum(floor(t)+1), 'or');
            hold on
        end
    end
    
    %%%POST
    
    load(['./data/POST_winArr_' int2str(def_cell_count) 'u_' int2str(def_binsize) 'bs.mat']);
    
    score_plot{iWord} = [];
    accusum = [];
    for iTime=1:length(stampSet(:, 1))
        if(~def_firing_control)
            resultSet = svmclassify(best_SVM, stampSet(iTime, :) * best_PC);
            score_plot{iWord} = [score_plot{iWord}; sum(resultSet)];
        elseif(stampSet(iTime, def_trigger_feature) >= def_trigger_threshold )
            resultSet = svmclassify(best_SVM, stampSet(iTime, :) * best_PC);
            score_plot{iWord} = [score_plot{iWord}; sum(resultSet)];
        else
            score_plot{iWord} = [score_plot{iWord}; 0];
        end
    end
    B = cumsum(score_plot{iWord});
    for iTime=1:length(stampSet(:, 1))
        accusum(iTime) = B(iTime)/iTime;
    end
    %save(['./data/score_plot_balance_' def_epoch_name '_' int2str(def_cell_count) 'u_' int2str(def_binsize) 'ms' ], 'score_plot', '-v7.3')

    subplot(1, 3, 3), plot(accusum);
    %plot(cumsum(score_plot{iWord}))
    xlabel('Bin #'); ylabel('Average # of Hits');

    title(['POST ' int2str(def_cell_count) 'u ' int2str(def_binsize) 'ms']);

    saveas(gcf, ['./plots/' wordtoVerify{iWord} '_accu_' int2str(def_cell_count) '_' int2str(def_binsize) 'ms.jpg'], 'jpg');
    saveas(gcf, ['./plots/' wordtoVerify{iWord} '_accu_' int2str(def_cell_count) '_' int2str(def_binsize) 'ms.fig'], 'fig');
end
%}