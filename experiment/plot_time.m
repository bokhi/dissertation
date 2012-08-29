accuracy = [0.6680,0.6910,0.5020,0.6150,0.6200,0.81000,0.65800, 0.68100, 0.65100];
reduction_time = [0,403.690831,3590.046512,1312.103790,1427.979230,0.149054,356.005313,1042.893822, 2582.651400];
accuracy_time = [12.275001,1.356252,1.253261,1.347082,1.267401,1.270781,1.287870,1.275466,1.272666];
pca_time = [0,0,0,0,0,403.690831,403.690831,403.690831,403.690831];

data = [pca_time; reduction_time; accuracy_time];

data = data';

stackedbar = @(x, A) bar(x, A, 'stack');
prettyline = @(x, y) plot(x, y, 'k', 'LineWidth', 5);

[ax, h1, h2] = plotyy(1:9, data, 1:9, accuracy, stackedbar, prettyline);

Labels = {'SIFT-3456', 'PCA', 'LDA-2', 'Isomap-79', 'LLE-12', 'LDA-78/25', 'Isomap-50/42', 'LLE-58/35', 'Isomap-adaptative-20/17'};
set(gca, 'XTick', 1:9, 'XTickLabel', Labels);


legend ('Accuracy', 'pca time', 'reduction time', 'accuracy time');

print ('-dpng',  'time_result.png');