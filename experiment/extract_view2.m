%% extract the view 2 datavectors

directory = '~/Exeter/dissertation/';
data = [directory 'database/sift/'];

addpath ([directory 'experiment/drtoolbox']);
addpath ([directory 'experiment/drtoolbox/techniques/']);
addpath ([directory 'experiment/liblinear-1.91/matlab/']);

FID = fopen ([directory 'database/lfw-info/pairs.txt']);
line = fgets (FID);

dataThisLine = sscanf(line, '%d %d ');
nFold = dataThisLine(1);
nEach = dataThisLine(2);
nPair = 2 * nEach;

nDim = 3456;

for f = 1:nFold

  Dataf1{f} = zeros (nEach, nDim);
  Dataf2{f} = zeros (nEach, nDim);


  for i = 1:nEach
    Line = fgets(FID);
    IndexSpace = isspace(Line);
    [I1, J1] = find(IndexSpace == 1);
    IDName = Line(1 : J1(1) - 1);
    
    ImgNo = sscanf(Line(J1(1) + 1: J1(3) - 1), '%d\t%d');
    
    
    ImgName = [data IDName sprintf('_%04.0f', ImgNo(1)) '.mat'];
    load(ImgName, 'Data');
    
    %% Collate the LPB feature
    Dataf1{f}(i, :) = double(Data(1:nDim));
    
    ImgName = [data IDName sprintf('_%04.0f', ImgNo(2)) '.mat'];
    load(ImgName, 'Data');

    %% Collate the LPB feature
    Dataf2{f}(i, :) = double(Data(1:nDim));
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
    Dataf1{f}(i, :) = double(Data(1:nDim));
    
    ImgName = [data IDName2 sprintf('_%04.0f', ImgNo(2)) '.mat'];
    load(ImgName, 'Data');

    %% Collate the LPB feature
    Dataf2{f}(i, :) = double(Data(1:nDim));
  end    
end

for f = 1:nFold

  Data1 = zeros(nPair * (nFold - 1), nDim);
  Data2 = zeros(nPair * (nFold - 1), nDim);
  DataTT1 = zeros(nPair, nDim);
  DataTT2 = zeros(nPair, nDim);
  Data = zeros(nPair * (nFold - 1) * 2, nDim);

  for g = 1:nFold
    if (g == f)
      DataTT1 = Dataf1{g};
      DataTT2 = Dataf2{g};
    else 
      Data((g-1)*nEach + 1:g*nEach, :) = Dataf1{g}(1:nEach, :);
      Data((g-1+nFold-1)*nEach + 1:(g+nFold-1)*nEach, :) = Dataf2{g}(1:nEach, :);
      Data((g-1+nFold*2-1)*nEach + 1:(g+nFold*2-1)*nEach, :) = Dataf1{g}(nEach+1:end, :);
      Data((g-1+nFold*3-1)*nEach + 1:(g+nFold*3-1)*nEach, :) = Dataf2{g}(nEach+1:end, :);

      SS = [[1:(nFold-1)*nPair]' [(nFold-1)*nPair + 1:((nFold-1)*2*nPair)]'];
      DD = [[1:(nFold-1)*3*nPair]' [(nFold-1)*nPair + 1:((nFold-1)*4*nPair)]'];
      
      %%Data1((g-1)*nPair + 1:g*nPair, :) = Dataf1{g};
      %%Data2((g-1)*nPair + 1:g*nPair, :) = Dataf2{g};
    end
  end
%%  save('-mat7-binary', ['view2_' num2str(f) '.mat'], 'Data1', 'Data2', 'DataTT1', 'DataTT2');  
  save('-mat7-binary', ['view2_' num2str(f) '.bin'], 'Data', 'DataTT1', 'DataTT2', 'SS', 'DD');  
  
end


