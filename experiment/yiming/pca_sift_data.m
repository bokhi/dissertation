% Use PCA to reduce data dimension for ten folds of SIFT data on LFW
% database.
% (Restricted setting)
% Peng Li 14-03-2011
tic
nFold = 10;     % Number of folds for CV

DirRoot = 'D:\yiming\matlab-code\metric_learning\ml-asdp\LFW-code\';
DirData = [DirRoot 'data\yiming-data\lbp2-try\'];  % Training  data folder
DirModel = [DirRoot 'data\yiming-data\lbp2-try\lbp2-pca-try\'];      % To store the PCA model
DirTarget = [DirRoot  'data\yiming-data\lbp2-try\lbp2-pca300-try\'];
nDim = 300;
IndexFold = 1 : 10;

% which fold to try (leave out for test)
for cFold = IndexFold
    
    % Get PCA to reduce dimension
    load([DirModel 'PCA_LBP_Fold_' num2str(cFold)...
        '.mat'], 'meanVec', 'PCAcomp', 'M1', 'S1');
    
    PCAcomp = PCAcomp(:, 1 : nDim);
    M1 = M1(1 : nDim);
    S1 = S1(1 : nDim);
    
    Data10 = [];
    Data20 = [];
    Label = [];
    for i = 1 : 10
        % Get training pairs to learn a threshold
        load ([DirData 'LBPPairF' num2str(i) '.mat'], 'Data1', 'Data2');
        %Data1= sqrt(Data1); Data2 = sqrt(Data2); 
        % Use PCA to reduce dimension
        Data1 = PCAcomp' * (Data1 - repmat(meanVec, 1, size(Data1, 2)));
        Data2 = PCAcomp' * (Data2 - repmat(meanVec, 1, size(Data2, 2)));
        
        if i ~= cFold                        
            nSampEach = size(Data1, 2);  %  # of samples
            
            nPosEach = size(Data1, 2) / 2;  % # of positive samples
            
            % Collate this data and imageID
            Data10 = [Data10, Data1(:, 1:nSampEach)];
            Data20 = [Data20, Data2(:, 1:nSampEach)];           
            Label = [Label, [ones(1, nPosEach), zeros(1, nPosEach)]];
        else
            % Test data
            DataTT1 = Data1;
            DataTT2 = Data2;
        end
    end
    % Normalize to zero mean and unit standard deviation
    Data10 = (Data10 - repmat(M1, 1, size(Data10, 2))) ./ repmat(S1, 1, size(Data10, 2));
    Data20 = (Data20 - repmat(M1, 1, size(Data20, 2))) ./ repmat(S1, 1, size(Data20, 2));
    
    DataTT1 = (DataTT1 - repmat(M1, 1, size(DataTT1, 2))) ./ repmat(S1, 1, size(DataTT1, 2));
    DataTT2 = (DataTT2 - repmat(M1, 1, size(DataTT2, 2))) ./ repmat(S1, 1, size(DataTT2, 2));
    
    
    % New training data
    Data = [Data10(:, Label == 1),...
        Data10(:, Label ~= 1), ...
        Data20(:, Label == 1), ...
        Data20(:, Label ~= 1)]';
    
    
    nPos = size(Data, 1) / 4;  %of positive samples
    
    SS = [1 : nPos; 1 + 2 * nPos : 3 * nPos]';
    DD = [1 + nPos : 2 * nPos; 1 + 3 * nPos : 4 * nPos]';
    
    % save the data of this fold
    save([DirTarget 'LBPPairF' num2str(nDim) num2str(cFold) '.mat'], ...
        'Data', 'SS', 'DD', 'DataTT1', 'DataTT2');
    
    fprintf('Fold %d, Dim = %d, Time=%3.1f\n', ...
        cFold, nDim, toc)
end


