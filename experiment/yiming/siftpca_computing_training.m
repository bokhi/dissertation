% compute the pca projection matrix for sift feature
nFold = 10;
DirRoot = 'D:\yiming\matlab-code\metric_learning\ml-asdp\LFW-code\';
DirData = [DirRoot 'data\yiming-data\lbp2-try\'];  % Training  data folder
DirTarget = [DirRoot 'data\yiming-data\lbp2-try\lbp2-pca-try\'];      % To store the PCA model

IndexFold = 1 : 10;

for cFold = IndexFold
    
    tic;
    %loading the training data to compute the pca
    Data =[];
    for i = 1 : 10
        
        if i ~= cFold
            % Get training pairs
            load ([DirData 'LBPPairF' num2str(i) '.mat'], 'Data1', 'Data2');
            Data = [Data Data1 Data2];
        end
    end
    
    [PCAcomp, meanVec, eigenvalues,M1,S1] = trainPCA((Data));
    
    
    save([DirTarget 'PCA_LBP_Fold_' num2str(cFold) '.mat'], ...
        'Data', 'M1','S1','meanVec', 'PCAcomp');
    
    fprintf('Fold %d, Time=%3.1f\n', ...
        cFold, toc);    
end