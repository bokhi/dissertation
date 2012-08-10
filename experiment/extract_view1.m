%% extract the training and testing SIFT datavectors from view1 while
%% preventing image redundancy in the train and test Data matrices

fprintf ('view1 data extraction\n');
tic

%%directory = '~/Exeter/dissertation/';
directory = '~/dissertation/';
data = [directory 'database/sift/'];

FID = fopen ([directory 'database/lfw-info/pairsDevTrain.txt']);
line = fgets (FID);

dataThisLine = sscanf(line, '%d ');
nEach = dataThisLine(1); %%number of similarity pairs (same as dissimilarity)
nPair = 2 * nEach; 

nDim = 3456; %number of features to extract from the datavectors
train_Data = zeros (nPair*2, nDim);
train_SS = zeros(nEach, 2);
train_DD = zeros(nEach, 2);

uniqueName = {}; %
index = 1; %


%% training similarity pairs extraction
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
      train_Data(index, :) = double(Data(1:nDim));
      train_SS(i, j) = index;				 
      index = index + 1;
    else
     train_SS(i, j) = ind;
    end
  end
end

%% training dissimilarity pairs extraction
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
      train_Data(index, :) = double(Data(1:nDim));
      train_DD(i, j) = index;				 
      index = index + 1;
    else
     train_DD(i, j) = ind;
    end
  end
end

train_Data = train_Data(1:index-1, :);

FID = fopen ([directory 'database/lfw-info/pairsDevTest.txt']);
line = fgets (FID);

dataThisLine = sscanf(line, '%d ');
nEach = dataThisLine(1);
nPair = 2 * nEach;

test_Data = zeros (nPair*2, nDim);
test_SS = zeros(nEach, 2);
test_DD = zeros(nEach, 2);

uniqueName = {}; %
index = 1; %

%% testing similarity pairs extraction
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
      test_Data(index, :) = double(Data(1:nDim));
      test_SS(i, j) = index;				 
      index = index + 1;
    else
     test_SS(i, j) = ind;
    end
  end

end
    
%% testing dissimilarity pairs extraction
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
      test_Data(index, :) = double(Data(1:nDim));
      test_DD(i, j) = index;				 
      index = index + 1;
    else
     test_DD(i, j) = ind;
    end
  end
end    

test_Data = test_Data(1:index-1, :);

time = toc

save('view1', 'train_Data', 'test_Data', 'train_SS', 'train_DD', 'test_SS', 'test_DD', 'time');          
