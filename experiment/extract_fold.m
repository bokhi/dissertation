%% extract the training and testing SIFT datavectors from view2 while
%% preventing image redundancy in the train and test Data matrices


fprintf ('view2 data extraction\n');

directory = '~/dissertation/';
%%directory = '~/Exeter/dissertation/';
data = [directory 'database/sift/'];

FID = fopen ([directory 'database/lfw-info/pairs.txt']);
line = fgets (FID);

dataThisLine = sscanf(line, '%d %d ');
nFold = dataThisLine(1);
nEach = dataThisLine(2);
nPair = 2 * nEach;

nDim = 3456;

for f = 1:nFold

  train_Dataf{f} = zeros (nPair*2, nDim);
  train_SSf{f} = zeros(nEach, 2);
  train_DDf{f} = zeros(nEach, 2);

  uniqueName = {}; %
  index = 1; %

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
        train_Dataf{f}(index, :) = double(Data(1:nDim));
        train_SSf{f}(i, j) = index;				 
        index = index + 1;
      else
       train_SSf{f}(i, j) = ind;
      end
    end
  end
  
  %% Find the number of images for test - Not-Match
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
        train_Dataf{f}(index, :) = double(Data(1:nDim));
        train_DDf{f}(i, j) = index;				 
        index = index + 1;
      else
       train_DDf{f}(i, j) = ind;
      end
    end
  end  

  train_Dataf{f} = train_Dataf{f}(1:index-1, :);  
end

for f = 1:nFold
  data = train_Dataf{f};
  SS = train_SSf{f};
  DD = train_DDf{f};					  
  save (['fold_' num2str(f)], 'data', 'SS', 'DD', 'nPair', 'nEach', 'nFold', 'nDim');
end
