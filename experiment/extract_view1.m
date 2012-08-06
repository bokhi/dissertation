%% extract the training and testing SIFT datavectors from View 1

directory = '~/dissertation/';
data = [directory 'database/sift/'];

FID = fopen ([directory 'database/lfw-info/pairsDevTrain.txt']);
line = fgets (FID);

dataThisLine = sscanf(line, '%d ');
nEach = dataThisLine(1); 
nPair = 2 * nEach;

nDim = 3456; %number of features to extract from the datavectors


Data1 = zeros (nPair, nDim);
Data2 = zeros (nPair, nDim);

for i = 1:nEach
  Line = fgets(FID);
  IndexSpace = isspace(Line);
  [I1, J1] = find(IndexSpace == 1);
  IDName = Line(1 : J1(1) - 1);
  
  ImgNo = sscanf(Line(J1(1) + 1: J1(3) - 1), '%d\t%d');
  
  ImgName = [data IDName sprintf('_%04.0f', ImgNo(1)) '.mat'];
  load(ImgName, 'Data');
  
  %% Collate the LPB feature
  Data1(i, :) = double(Data(1:nDim));
  
  ImgName = [data IDName sprintf('_%04.0f', ImgNo(2)) '.mat'];
  load(ImgName, 'Data');

  %% Collate the LPB feature
  Data2(i, :) = double(Data(1:nDim));
end
    
%% Find the number of images for test - Not-Match
for i = nEach+1 : nPair
  Line = fgets(FID);
  IndexSpace = isspace(Line);
  [I1, J1] = find(IndexSpace == 1);
  IDName1 = Line(1 : J1(1) - 1);
  IDName2 = Line(J1(2) + 1 : J1(3) - 1);
  
  ImgNo(1) = sscanf(Line(J1(1) + 1: J1(2) - 1), '%d\t%d');
  ImgNo(2) = sscanf(Line(J1(3) + 1: J1(4) - 1), '%d\t%d');
        
  ImgName = [data IDName1 sprintf('_%04.0f', ImgNo(1)) '.mat'];
        
  load(ImgName, 'Data');
        
  %% Collate the LPB feature
  Data1(i, :) = double(Data(1:nDim));
                
  ImgName = [data IDName2 sprintf('_%04.0f', ImgNo(2)) '.mat'];
  load(ImgName, 'Data');

  %% Collate the LPB feature
  Data2(i, :) = double(Data(1:nDim));
end    




FID = fopen ([directory 'database/lfw-info/pairsDevTest.txt']);
line = fgets (FID);

dataThisLine = sscanf(line, '%d ');
nEach = dataThisLine(1);
nPair = 2 * nEach;

DataTT1 = zeros (nEach, nDim);
DataTT2 = zeros (nEach, nDim);

for i = 1:nEach
  Line = fgets(FID);
  IndexSpace = isspace(Line);
  [I1, J1] = find(IndexSpace == 1);
  IDName = Line(1 : J1(1) - 1);
  
  ImgNo = sscanf(Line(J1(1) + 1: J1(3) - 1), '%d\t%d');
  
		 
  ImgName = [data IDName sprintf('_%04.0f', ImgNo(1)) '.mat'];
  load(ImgName, 'Data');
  
  %% Collate the LPB feature
  DataTT1(i, :) = double(Data(1:nDim));
  
  ImgName = [data IDName sprintf('_%04.0f', ImgNo(2)) '.mat'];
  load(ImgName, 'Data');

  %% Collate the LPB feature
  DataTT2(i, :) = double(Data(1:nDim));
end
    
%% Find the number of images for test - Not-Match
for i = nEach+1 : nPair
  Line = fgets(FID);
  IndexSpace = isspace(Line);
  [I1, J1] = find(IndexSpace == 1);
  IDName1 = Line(1 : J1(1) - 1);
  IDName2 = Line(J1(2) + 1 : J1(3) - 1);
  
  ImgNo(1) = sscanf(Line(J1(1) + 1: J1(2) - 1), '%d\t%d');
  ImgNo(2) = sscanf(Line(J1(3) + 1: J1(4) - 1), '%d\t%d');
        
  ImgName = [data IDName1 sprintf('_%04.0f', ImgNo(1)) '.mat'];
        
  load(ImgName, 'Data');
        
  %% Collate the LPB feature
  DataTT1(i, :) = double(Data(1:nDim));
                
  ImgName = [data IDName2 sprintf('_%04.0f', ImgNo(2)) '.mat'];
  load(ImgName, 'Data');

  %% Collate the LPB feature
  DataTT2(i, :) = double(Data(1:nDim));
end    

nEach = size(Data1, 1)/2;
nPair = nEach * 2;

SS = [[1:nEach]' [nEach + 1:2*nEach]'];
DD = [[2*nEach+1:3*nEach]' [3*nEach+1:4*nEach]'];

Data = zeros(nPair*2, nDim);


Data(SS(:, 1), :) = Data1(1:nEach, :);
Data(SS(:, 2), :) = Data2(1:nEach, :);

Data(DD(:, 1), :) = Data1(nEach+1:2*nEach, :);
Data(DD(:, 2), :) = Data2(nEach+1:2*nEach, :);



save('view1', 'Data', 'DataTT1', 'DataTT2', 'SS', 'DD');  