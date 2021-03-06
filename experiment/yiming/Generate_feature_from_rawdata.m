% Split the data pairs of LFW database for test (SIFT feature)
%
%   View 2:  - for cross-validation test.
%       - Determine the subspace dimension for PLDA
%   Use the images in pairs.txt for testing
% Peng Li 24-10-2011
% Working directory
 
DirRoot = 'D:\yiming\matlab-code\metric_learning\ml-asdp\LFW-code\';
DirFeature = [DirRoot 'data\yiming-data\lbp2-yiming-try\'];    % SIFT feature vectors
DirTarget = [DirRoot 'data\yiming-data\lbp2-try\'];    % Target data folder

% Header of the image pair name for training
FID = fopen([DirRoot 'info\pairs.txt'], 'rt');
Line = fgets(FID);
DataThisLine  = sscanf(Line, '%d\t%d\n');
nFold = DataThisLine(1);    % Number of fold for cross validation
nEach = DataThisLine(2);    % Number of pairs in each class
NPair = 2 * nEach;          % Number of all pairs
NDim = 7080;    % Number of dimension of feature vector

for f = 1 : nFold
    fprintf('Fold No. %d\n', f);
    % Store the image pair
    Data1 = zeros(NDim, nEach);    % Collect data for test (1st image)
    Data2 = zeros(NDim, nEach);    % Collect data for test (2st image)
    

    t = 0;
    % Find the number of images for test - Match
    for i = 1:nEach
        t = t + 1;
        Line = fgets(FID);
        IndexSpace = isspace(Line);
        [I1, J1] = find(IndexSpace == 1);
        IDName = Line(1 : J1(1) - 1);
        
        ImgNo = sscanf(Line(J1(1) + 1: J1(3) - 1), '%d\t%d');
       
        
        ImgName = [DirFeature IDName sprintf('_%04.0f', ImgNo(1)) '.mat'];
        load(ImgName, 'DataO');
        
        % Collate the LPB feature
        Data1(:, i) = double(DataO);
                
        ImgName = [DirFeature IDName sprintf('_%04.0f', ImgNo(2)) '.mat'];
        load(ImgName, 'DataO');

        % Collate the LPB feature
        Data2(:, i) = double(DataO);
    end
    
    % Find the number of images for test - Not-Match
    for i = nEach+1 : NPair
        Line = fgets(FID);
        IndexSpace = isspace(Line);
        [I1, J1] = find(IndexSpace == 1);
        IDName1 = Line(1 : J1(1) - 1);
        IDName2 = Line(J1(2) + 1 : J1(3) - 1);
        
        ImgNo(1) = sscanf(Line(J1(1) + 1: J1(2) - 1), '%d\t%d');
        ImgNo(2) = sscanf(Line(J1(3) + 1: J1(4) - 1), '%d\t%d');
        
        ImgName = [DirFeature IDName1 sprintf('_%04.0f', ImgNo(1)) '.mat'];
        
        load(ImgName, 'DataO');
        
        % Collate the LPB feature
        Data1(:, i) = double(DataO);
                
        ImgName = [DirFeature IDName2 sprintf('_%04.0f', ImgNo(2)) '.mat'];
        load(ImgName, 'DataO');

        % Collate the LPB feature
        Data2(:, i) = double(DataO);
    end    
    save([DirTarget 'LBPPairF' num2str(f) '.mat'], 'Data1', 'Data2');  
end




