clear
close all

load(['./data/AvgSpikePerSec_PRE_bin50.mat'])
PRE_bin = PRE_bin(:, ceil(length(PRE_bin) /3 ):length(PRE_bin) );
load(['./data/AvgSpikePerSec_TASK_bin50.mat'])
load(['./data/AvgSpikePerSec_POST_bin50.mat'])

%unit_sel = [5, 6, 7, 8, 9, 23, 42, 43, 55, 57, 60, 61, 62, 66, 67, 71];
%unit_sel = [1, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 23, 24, 30, 33, 39, 40, 41, 42, 44, 45, 46, 47, 49, 50, 51, 53, 57, 60, 65, 66, 67, 68, 69, 70, 73, 74, 75, 76, 77, 78, 80, 82, 83, 84, 86, 87, 88, 89, 93, 94, 95, 97, 102, 103, 104, 105, 111, 112, 113, 114, 118, 120, 121, 129, 130, 131, 132, 134, 135, 136, 138, 141, 144, 145, 151, 154, 155, 157, 158, 159, 166, 167, 168, 169, 170, 171, 174, 181, 189, 193];
unit_sel = [1:199];

def_cell_count = length(unit_sel);
def_binsize = 50;

mkdir('./plots/epoch');

figure, imagesc(PRE_bin(unit_sel, :)), title(['PRE ' int2str(length(unit_sel)) ' Cells'])
xlabel('channel number'); ylabel('bin number');
caxis([0 9]);
colorbar;
saveas(gcf, ['./plots/epoch/PRE_' int2str(def_cell_count) 'u_' int2str(def_binsize) 'ms.fig'], 'fig');

figure, imagesc(TASK_bin(unit_sel, :)), title(['TASK ' int2str(length(unit_sel)) ' Cells'])
xlabel('channel number'); ylabel('bin number');
caxis([0 9]);
colorbar;
saveas(gcf, ['./plots/epoch/TASK_' int2str(def_cell_count) 'u_' int2str(def_binsize) 'ms.fig'], 'fig');

figure, imagesc(POST_bin(unit_sel, :)), title(['POST ' int2str(length(unit_sel)) ' Cells'])
xlabel('channel number'); ylabel('bin number');
caxis([0 9]);
colorbar;
saveas(gcf, ['./plots/epoch/POST_' int2str(def_cell_count) 'u_' int2str(def_binsize) 'ms.fig'], 'fig');

figure;
%Y = [sum(PRE_bin, 2); sum(TASK_bin, 2); sum(POST_bin, 2)]
Y = sum(PRE_bin, 2);
Y = [Y sum(TASK_bin, 2)];
Y = [Y sum(POST_bin, 2)];
bar(Y);
xlabel('# of firings'); ylabel('channel number');

%{
plot(sum(PRE_bin, 2), 'r');
hold on;
plot(sum(TASK_bin, 2), 'g');
hold on;
plot(sum(POST_bin, 2), 'b');
%}