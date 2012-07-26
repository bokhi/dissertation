% Train both DML and ITML with pairs for Cross validation test on LFW
% dataset. (SIFT) (Restricted setting) 
%
% Peng Li 15-03-2011
tic


% Root directory of code and data
DirRoot = 'C:\Documents and Settings\enxpl\My Documents\work\data\other\2yiming\';


% Path to Yiming's code of DML-Eigen
DirCode = [DirRoot 'code\dml\']; 

addpath(DirCode)

% Data folder
DirData = [DirRoot 'data\']; 

% Model folder
DirModel = [DirRoot 'model\']; 

% Parameters to train ITML model
ITMLParam.max_iters = 5e5;
Gammas = 10.^[-6:1:-1];

% Parameters to train DML model
Beta = 0;
DMLTNOptions.display = 1;
DMLTNOptions.linesearch = 0;
Mus = 10.^[-6:1:-1];

nK = 3;                 % Number of NNS
nFold = 3;              % Fold of CV test for model selection
Dims = [35];             % PCA dimension to evaluate

IndexFold = 1 : 10;

for cDim = 1 : length(Dims)
    nDim = Dims(cDim);             % Dimenion of principle components
    fprintf('********Dim = %d, training DML...\n', nDim);
    
    % which fold to try (leave out for test)
    for cFold = IndexFold
        fprintf('Fold %d \n', cFold);
        
        % Get training data
        %   Data:   nSample x nFeature matrix   -   Training data
        %   SS:     nPair x 2 matrix            -   Similarity pairs
        %   DD:     nPair x 2 matrix            -   Dissimilarity pairs
        load([DirData 'SIFTPairF' num2str(cFold) '.mat'], ...
            'Data', 'SS', 'DD');
        
        Data = Data(:, 1:nDim);
                  
        % 1: Train DML
        
        % Parameters for model selection
        DMLTNOptions.maxiter = 1e3;
        DMLTNOptions.tol = 1e-4;
        
        % Model selection by cross validation for DML
        [OptimalParam, OptimalCR, CRCV] = cv_ms_dml_restrict(Data, SS, DD, ...
            nFold, Beta, DMLTNOptions, Mus);
        
        fprintf('The optimal parameter is %5.5f with verification rate of %1.3f.\n', ...
            OptimalParam, OptimalCR);
       
        fprintf('\n Training DML metric with 3 nearest neighbor\n');
                
        % Parameters for final training
        DMLTNOptions.maxiter = 2e3;
        DMLTNOptions.tol = 1e-6;

        timeStart = toc;
        
        % Train the DML model with optimal parameter
        DMLModel =  dml_yiming(Data, SS, DD, Beta, OptimalParam, DMLTNOptions);
        
        TimeDML = toc - timeStart;
        
        % Store the model
        save([DirModel 'V2R_SIFT_DML_' num2str(cFold) '_' num2str(nDim) ...
            '.mat'], 'DMLModel', 'OptimalParam', 'OptimalCR', 'CRCV', 'TimeDML');
        
        % 2: Train ITML
        
        % Model selection for ITML
        [OptimalParam, OptimalCR, CRCV] = cv_ms_itml_restrict(Data, SS, DD, ...
            nFold, Gammas);
        
        fprintf('The optimal parameter is %5.5f with verification rate of %1.3f.\n', ...
            OptimalParam, OptimalCR);
       
        fprintf('\n Training ITML metric with 3 nearest neighbor\n');

        ITMLParam.gamma = OptimalParam;
                 
        timeStart = toc;

        % Train the ITML model
        ITML_MT = ITML_Train(Data, SS, DD, eye(size(Data, 2)), ITMLParam);
        
        TimeITML = toc - timeStart;
        
        % save the trained ITML model
        save([DirModel 'V2R_SIFT_ITML_' num2str(cFold)...
            '_' num2str(nDim) '.mat'], 'ITML_MT', 'OptimalParam',...
            'OptimalCR', 'CRCV', 'TimeITML');
        
        fprintf('----This Dim takes %5.2f seconds\n', nDim, toc);
    end
end