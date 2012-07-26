% Test DML with pairs for Cross validation test on LFW dataset. (SIFT)
% (Restricted setting)
%
% Peng Li 15-03-2011
tic

nFold = 10;         % Number of folds for CV
IndexFold = 1 : 10;  % Index of fold to evaluate

TakeSquare = 0;

fprintf(' ------ SIFT feature 10 CV Test--------- \n');

% Root directory of code and data
DirRoot = 'C:\Documents and Settings\enxpl\My Documents\work\data\other\2yiming\';

% Data folder
DirData = [DirRoot 'data\'];

% Model folder
DirModel = [DirRoot 'model\'];

% Result folder
DirResult = [DirRoot 'result\'];

% PCA dimensions to evaluate
Dims = [33 35 55]

nK = 3;                 % Number of NNS

for cDim = 1 : length(Dims)
    nDim = Dims(cDim);             % Dimenion of principle components
    fprintf('\n\n********Dim = %d\n', nDim);
    
    
    CRTTS = zeros(length(IndexFold), 1);
    
    % which fold to try (leave out for test)
    for cFold = IndexFold
        % Get test data
        load ([DirData 'SIFTPairF' num2str(cFold) '.mat'], ...
            'Data', 'DataTT1', 'DataTT2');
        
        % Remove unused dimension
        Data = Data(:, 1:nDim);
        DataTT1 = DataTT1(1:nDim, :);
        DataTT2 = DataTT2(1:nDim, :);
        
        % Number of positive pairs (same)
        nPairP = size(Data, 1) / 4;
        
        % Get the trained DML model
        load([DirModel 'V2R_SIFT_DML_' num2str(cFold)...
            '_' num2str(nDim) '.mat'], 'DMLModel');
        
        nPosTT = size(DataTT1, 2) / 2;
        
        [CRTT ROCTT DistTTPOS DistTTNEG DistTNPOS DistTNNEG]...
            = verification_ml_test(...
            DMLModel.distM,...
            Data(1 : nPairP, :),...
            Data(1 + nPairP * 2 : nPairP * 3, :),...
            Data(1 + nPairP * 1 : nPairP * 2, :),...
            Data(1 + nPairP * 3 : nPairP * 4, :),...
            DataTT1(:, 1 : nPosTT)',...
            DataTT2(:, 1 : nPosTT)', ...
            DataTT1(:, 1 + nPosTT : end)',...
            DataTT2(:, 1 + nPosTT : end)');
        
        fprintf('Fold %d, Dim = %d,  DML-CR = %1.3f, Time=%3.1f\n', ...
            cFold, nDim, CRTT, toc)
        
        % Save the distance for ensemble learning
        save([DirResult 'V2R_DML_Dist_SIFT_' num2str(cFold) '_' ...
            num2str(nDim) '.mat'], ...
            'DistTNPOS', 'DistTNNEG', 'DistTTPOS', 'DistTTNEG');
        
        CRTTSDML(cFold) = CRTT;
        
        % For plot ROC of 10 fold CV
        ScorePerFoldDML{cFold} = -[DistTTPOS' DistTTNEG'];
        LabelTT{cFold} = [ones(nPosTT, 1), zeros(nPosTT, 1)];
        
        % save the result of this fold
        save([DirResult 'V2R_SIFT_DML_' num2str(cFold) '_' ...
            num2str(nDim) '.mat'], 'CRTT', 'ROCTT');
        
        
        % Get the trained ITML model
        load([DirModel 'V2R_SIFT_ITML_' num2str(cFold)...
            '_' num2str(nDim) '.mat'], 'ITML_MT');
        
        [CRTT ROCTT DistTTPOS DistTTNEG DistTNPOS DistTNNEG]...
            = verification_ml_test(...
            ITML_MT,...
            Data(1 : nPairP, :),...
            Data(1 + nPairP * 2 : nPairP * 3, :),...
            Data(1 + nPairP * 1 : nPairP * 2, :),...
            Data(1 + nPairP * 3 : nPairP * 4, :),...
            DataTT1(:, 1 : nPosTT)',...
            DataTT2(:, 1 : nPosTT)', ...
            DataTT1(:, 1 + nPosTT : end)',...
            DataTT2(:, 1 + nPosTT : end)');
        
        fprintf('Fold %d, Dim = %d, ITML-CR = %1.3f, Time=%3.1f\n', ...
            cFold, nDim, CRTT, toc)
        
        DistTN = [DistTNPOS', DistTNNEG']';
        DistTT = [DistTTPOS', DistTTNEG']';
        
        % Save the distance for ensemble learning
        save([DirResult 'V2R_ITML_Dist_SIFT_' num2str(cFold) '_' ...
            num2str(nDim) '.mat'], ...
            'DistTNPOS', 'DistTNNEG', 'DistTTPOS', 'DistTTNEG');
        
        CRTTSITML(cFold) = CRTT;
        
        % For plot ROC of 10 fold CV
        ScorePerFoldITML{cFold} = -[DistTTPOS' DistTTNEG'];
        
        % save the trained ITML model
        save([DirResult 'V2R_SIFT_ITML_' num2str(cFold) '_' ...
            num2str(nDim) '.mat'], 'CRTT', 'ROCTT');
        
    end
    [FPR, TPR] = perfcurve(LabelTT, ScorePerFoldDML, '1', 'xvals', 'all');
    ROCTTS = [FPR, TPR];
    
    CRTTS = CRTTSDML;
    save([DirResult 'V2R_SIFT_DML_' num2str(nDim) '.mat'], 'CRTTS', 'ROCTTS');
    
    fprintf('CV Verification rate of  DML is %1.4f +- %1.4f\n', mean(CRTTSDML), std(CRTTSDML));
    
    [FPR, TPR] = perfcurve(LabelTT, ScorePerFoldITML, '1', 'xvals', 'all');
    ROCTTS = [FPR, TPR];
    
    CRTTS = CRTTSITML;
    save([DirResult 'V2R_SIFT_ITML_' num2str(nDim) '.mat'], 'CRTTS', 'ROCTTS');
    
    fprintf('CV Verification rate of ITML is %1.4f +- %1.4f\n', mean(CRTTSITML), std(CRTTSITML));
end

CRALL = zeros(length(Dims), 4);
for cDim = 1 : length(Dims)
    nDim = Dims(cDim);             % Dimenion of principle components
    load([DirResult 'V2R_SIFT_DML_' num2str(nDim) '.mat'], 'CRTTS', 'ROCTTS');
    CRALL(cDim, 1) = mean(CRTTS);
    CRALL(cDim, 2) = std(CRTTS) ./ sqrt(10);
    load([DirResult 'V2R_SIFT_ITML_' num2str(nDim) '.mat'], 'CRTTS', 'ROCTTS');
    CRALL(cDim, 3) = mean(CRTTS);
    CRALL(cDim, 4) = std(CRTTS) ./ sqrt(10);
end
figure
[Temp IndexBest] = max(mean(CRTTS, 1));
h2(1) = errorbar(Dims, CRALL(:, 1), CRALL(:, 2), 'r.-');
hold on
h2(2) = errorbar(Dims, CRALL(:, 3), CRALL(:, 4), 'kx-');
xlabel('Subspace dimensions');
ylabel('Verification rate');
legend(h2, 'DML-Eigen', 'ITML', 0);
[CROpt, IndOpt] = max(CRALL(:, 1));
fprintf('The optimal verification rate of  DML is %1.4f +- %1.4f with Dim = %d\n',...
    CROpt, CRALL(IndOpt, 2), Dims(IndOpt));
[CROpt, IndOpt] = max(CRALL(:, 3));
fprintf('The optimal verification rate of ITML is %1.4f +- %1.4f with Dim = %d\n',...
    CROpt, CRALL(IndOpt, 4), Dims(IndOpt));
