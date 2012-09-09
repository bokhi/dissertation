accuracy = [     0.5020,     0.6150,     0.6200,    0.65100,   0.65800,   0.6680,    0.68100,    0.6910, 0.81000]';
reduction_time = [3590.046512,1312.103790,1427.979230,2582.651400,356.005313,        0  ,104.2893822,403.690831,0.149054]';
accuracy_time = [     0.5020,     0.6150,     0.6200,    0.65100,   0.65800,   0.6680,    0.68100,    0.6910, 0.81000]';
pca_time = [0,0,0,403.690831,403.690831,0,403.690831,0,403.690831]';


figure;

h = bar(1:9, [pca_time reduction_time], 'stack')
ylabel(h, 'seconds');

Labels = {'SP-LDA', 'ISO', 'LLE','ISO','ISO','SIFT','LLE','PCA','SP-LDA'};
set(gca, 'xtick', 1:9, 'XTickLabel', Labels);

legend ('pca time', 'reduction time');

print ('-dpng', 'time-result.png');

figure;
h = bar(1:9, accuracy)
ylabel(h, 'accuracy');

Labels = {'SP-LDA', 'ISO', 'LLE','ISO','ISO','SIFT','LLE','PCA','SP-LDA'};
set(gca, 'XTick', 1:9, 'XTickLabel', Labels);

print ('-dpng', 'accuracy-result.png');
