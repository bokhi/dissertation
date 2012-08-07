%% extract the training and testing SIFT datavectors from view1 while
%% preventing redundancy in the Data matrix

directory = '~/Exeter/dissertation/';
data = [directory 'database/sift/'];

FID = fopen ([directory 'database/lfw-info/pairsDevTrain.txt']);
line = fgets (FID);

dataThisLine = sscanf(line, '%d ');
nEach = dataThisLine(1); %%number of similarity pairs (same as dissimilarity)
nPair = 2 * nEach; 

nDim = 3456; %number of features to extract from the datavectors
uniqueData = zeros (nPair*2, nDim);
SS = zeros(nEach, 2);
DD = zeros(nEach, 2);

uniqueName = {}; %
index = 1; %


%% similarity pairs extraction
for i = 1:nEach
  Line = fgets(FID);
  IndexSpace = isspace(Line);
  [I1, J1] = find(IndexSpace == 1);
  IDName = Line(1 : J1(1) - 1);
  
  ImgNo = sscanf(Line(J1(1) + 1: J1(3) - 1), '%d\t%d');

  for j = 1:2  
    name = [IDName ImgNo(j)];
    ind = find (strcmp(name, uniqueName));	
			 
    if isempty (ind)
      ImgName = [data IDName sprintf('_%04.0f', ImgNo(j)) '.mat'];
      load(ImgName, 'Data');

      uniqueName{index} = name;
      uniqueData(index, :) = double(Data(1:nDim));
      SS(i, j) = index;				 
      index = index + 1;
    else
     SS(i, j) = ind;
    end
  end
end

%% dissimilarity pairs extraction
for i = 1:nEach
  IDName = [];				     
  Line = fgets(FID);
  IndexSpace = isspace(Line);
  [I1, J1] = find(IndexSpace == 1);
  IDName{1} = Line(1 : J1(1) - 1);
  IDName{2} = Line(J1(2) + 1 : J1(3) - 1);
  
  ImgNo(1) = sscanf(Line(J1(1) + 1: J1(2) - 1), '%d\t%d');
  ImgNo(2) = sscanf(Line(J1(3) + 1: J1(4) - 1), '%d\t%d');

  for j = 1:2  
    name = [IDName{j} ImgNo(j)];
    ind = find (strcmp(name, uniqueName));	
			 
    if isempty (ind)
      ImgName = [data IDName{j} sprintf('_%04.0f', ImgNo(j)) '.mat'];
      load(ImgName, 'Data');

      uniqueName{index} = name;
      uniqueData(index, :) = double(Data(1:nDim));
      DD(i, j) = index;				 
      index = index + 1;
    else
     DD(i, j) = ind;
    end
  end
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

Data = uniqueData(1:index-1, :);

save('unique_view1', 'Data', 'DataTT1', 'DataTT2', 'SS', 'DD');          

		      
		      