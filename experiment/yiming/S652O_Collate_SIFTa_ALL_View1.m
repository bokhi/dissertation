% Collate LBP feature of LFWA database for model selection (80x150 images)
%   using original images
%   1. Training data 
%       Use the images in peopleDevTrain.txt
%   2. Training pairs
%       Use the images in pairsDevTrain.txt 
%   3. Test data
%       Use the images in pairsDevTest.txt
%
% Peng Li 25-01-2011

tic
nDim = 3456;   % Dimension of feature vector
DirRoot = 'C:\Documents and Settings\enxpl\My Documents\work\data\other\lfw1\';
DirFeature = [DirRoot 'data\sift3\'];     % LBP feature vectors
DirTarget = [DirRoot 'data\view1a\'];    % Target data folder

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  1. Training data
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fprintf('Training data...\n');

% Header of the image names for training
FID = fopen([DirRoot '\data\info\peopleDevTrain.txt'], 'rt');   
Line = fgets(FID);     

nDim1  = sscanf(Line, '%d\n');
nIdentity = nDim1(1);

NImg = zeros(nIdentity, 1);
ImageNames = cell(nIdentity, 1);

% Find the number of images for training
for i = 1:nIdentity   
    Line = fgets(FID);     
    IndexSpace = isspace(Line);
    [I1, J1] = find(IndexSpace == 1);
    NImg(i) = sscanf(Line(J1(1) + 1: J1(2) - 1), '%d');
end
fclose(FID);

NTrain = sum(NImg);
Data = zeros(nDim, NTrain);      % Collect data for training
ImageID = single(zeros(NTrain, nIdentity)); % Identity matrix

% Header of the image names for training
FID = fopen([DirRoot '\data\info\peopleDevTrain.txt'], 'rt');   

Line = fgets(FID);     
% Collect data for training
t = 0;
for i = 1:nIdentity   
    Line = fgets(FID);     
    IndexSpace = isspace(Line);
    [I1, J1] = find(IndexSpace == 1);
    IDName = Line(1 : J1(1) - 1);
    ImageNames{i} = IDName;    
    for j = 1 : NImg(i)
        t = t + 1;
        % Get the feature
        ImgName = [DirFeature IDName sprintf('_%04.0f', j) '.mat'];
        load(ImgName, 'DataO');    
                       
        % Collate the LPB feature
        Data(:, t) = DataO;
        ImageID(t, i) = 1;
    end   
end
fclose(FID);
save([DirTarget 'OSIFTaDataTN.mat'], 'Data', 'ImageID');
clear Data ImageID

fprintf('It takes %3.1 seconds.\n', toc);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  2. Training pairs
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fprintf('Training pairs...\n');

% Header of the image pairs file for training
FID = fopen([DirRoot '\data\info\pairsDevTrain.txt'], 'rt');   
Line = fgets(FID);     

nEach  = sscanf(Line, '%d\n');
NPair = 2 * nEach;

% Store the image pair of four keypoints
Data1 = zeros(nDim, NPair);    % Collect data for test (1st image)
Data2 = zeros(nDim, NPair);    % Collect data for test (2st image)

ImageNames = cell(NPair, 2);

% Find the number of images for test - Match
t = 0;
for i = 1:nEach   
    t = t + 1;
    Line = fgets(FID);     
    IndexSpace = isspace(Line);
    [I1, J1] = find(IndexSpace == 1);
    IDName = Line(1 : J1(1) - 1);
    
    ImgNo = sscanf(Line(J1(1) + 1: J1(3) - 1), '%d\t%d');  
    
    ImageNames{i, 1} = [IDName sprintf('_%04.0f', ImgNo(1)) '.mat'];    
    ImageNames{i, 2} = [IDName sprintf('_%04.0f', ImgNo(2)) '.mat'];    
        
    % First image
    ImgName = [DirFeature IDName sprintf('_%04.0f', ImgNo(1)) '.mat'];
    load(ImgName, 'DataO');    
    
    % Collate the LPB feature
    Data1(:, t) = DataO; 

    % Second image
    ImgName = [DirFeature IDName sprintf('_%04.0f', ImgNo(2)) '.mat'];
    load(ImgName, 'DataO');             
    
    % Collate the LPB feature
    Data2(:, t) = DataO;  
end

% Find the number of images for test - Not-Match
for i = nEach+1 : NPair
    t = t + 1;
    Line = fgets(FID);     
    IndexSpace = isspace(Line);
    [I1, J1] = find(IndexSpace == 1);
    IDName1 = Line(1 : J1(1) - 1);
    IDName2 = Line(J1(2) + 1 : J1(3) - 1);
    
    ImgNo(1) = sscanf(Line(J1(1) + 1: J1(2) - 1), '%d\t%d');  
    ImgNo(2) = sscanf(Line(J1(3) + 1: J1(4) - 1), '%d\t%d');  
    
    ImageNames{i, 1} = [IDName1 sprintf('_%04.0f', ImgNo(1)) '.mat'];    
    ImageNames{i, 2} = [IDName2 sprintf('_%04.0f', ImgNo(2)) '.mat'];    
    
    % First image
    ImgName = [DirFeature IDName1 sprintf('_%04.0f', ImgNo(1)) '.mat'];
    load(ImgName, 'DataO');    
    
    % Collate the LPB feature
    Data1(:, t) = DataO; 
    
    % Second image
    ImgName = [DirFeature IDName2 sprintf('_%04.0f', ImgNo(2)) '.mat'];
    load(ImgName, 'DataO');              
    
    % Collate the LPB feature
    Data2(:, t) = DataO; 
end
save([DirTarget 'OSIFTaPairTN.mat'], 'Data1', 'Data2');

clear Data1 Data2

fprintf('Time eclapes %3.1 seconds\n', toc);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  3. Test data
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fprintf('Test data...\n');

% Header of the image pair name for test
FID = fopen([DirRoot '\data\info\pairsDevTest.txt'], 'rt');   
Line = fgets(FID);     

nEach  = sscanf(Line, '%d\n');
NPair = 2 * nEach;

% Store the image pair of four keypoints
Data1 = zeros(nDim, nEach);    % Collect data for test (1st image)
Data2 = zeros(nDim, nEach);    % Collect data for test (2st image)
Poses = zeros(2, nEach);      % Collect pose info

Label = [ones(1, nEach), zeros(1, nEach)]';  % Label of Match or Not-Match
ImageNames = cell(NPair, 2);

% Find the number of images for test - Match
t = 0;
for i = 1:nEach   
    t = t + 1;
    Line = fgets(FID);     
    IndexSpace = isspace(Line);
    [I1, J1] = find(IndexSpace == 1);
    IDName = Line(1 : J1(1) - 1);
    
    ImgNo = sscanf(Line(J1(1) + 1: J1(3) - 1), '%d\t%d');  
    
    ImageNames{i, 1} = [IDName sprintf('_%04.0f', ImgNo(1)) '.mat'];    
    ImageNames{i, 2} = [IDName sprintf('_%04.0f', ImgNo(2)) '.mat'];    
    
    % First image
    ImgName = [DirFeature IDName sprintf('_%04.0f', ImgNo(1)) '.mat'];
    load(ImgName, 'DataO');    
    
    % Collate the LPB feature
    Data1(:, t) = DataO; 

    % Second image
    ImgName = [DirFeature IDName sprintf('_%04.0f', ImgNo(2)) '.mat'];
    load(ImgName, 'DataO');             
    
    % Collate the LPB feature
    Data2(:, t) = DataO;  
end

% Find the number of images for test - Not-Match
for i = nEach+1 : NPair
    t = t + 1;
    Line = fgets(FID);     
    IndexSpace = isspace(Line);
    [I1, J1] = find(IndexSpace == 1);
    IDName1 = Line(1 : J1(1) - 1);
    IDName2 = Line(J1(2) + 1 : J1(3) - 1);
    
    ImgNo(1) = sscanf(Line(J1(1) + 1: J1(2) - 1), '%d\t%d');  
    ImgNo(2) = sscanf(Line(J1(3) + 1: J1(4) - 1), '%d\t%d');  
    
    ImageNames{i, 1} = [IDName1 sprintf('_%04.0f', ImgNo(1)) '.mat'];    
    ImageNames{i, 2} = [IDName2 sprintf('_%04.0f', ImgNo(2)) '.mat'];    
    
    % First image
    ImgName = [DirFeature IDName1 sprintf('_%04.0f', ImgNo(1)) '.mat'];
    load(ImgName, 'DataO');    
    
    % Collate the LPB feature
    Data1(:, t) = DataO; 
    
    % Second image
    ImgName = [DirFeature IDName2 sprintf('_%04.0f', ImgNo(2)) '.mat'];
    load(ImgName, 'DataO');              
    
    % Collate the LPB feature
    Data2(:, t) = DataO;    
end

save([DirTarget 'OSIFTaDataTT.mat'], 'Data1', 'Data2');
fprintf('Time eclapes %3.1 seconds\n. Successful!\n', toc);


