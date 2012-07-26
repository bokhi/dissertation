% Read the SIFT feature from 9 keypoints of 3 scales by Matthieu Guillaumin
% et. al. and store to standard matlab format
% Peng Li 11-01-2011
% Original LFWA image folder
DirRoot = 'D:\yiming\matlab-code\metric_learning\ml-asdp\LFW-code\';
DirOriginal = [DirRoot, '\data\lfw_funneled_sfd\lfw_funneled\'];
% Cropped 110 x 115 images for extracting LPB TPLBP and FPLBP features
DirTarget= [DirRoot,'\data\yiming-play-data\'];
F1 = dir([DirOriginal, '*.*']);
Data = zeros(128*27, 1);
Data0 = zeros(27, 128);     % The SIFT feature of 9 keypoints in 3 scales
Keypoints = zeros(27, 2);   % 9 key points on 3 scales
Scales = zeros(27, 3);       % same as above
t = 0; 
for i = 3 : size(F1, 1)     % Loop over each folder (identity)
    F2 = dir([DirOriginal, F1(i).name '\*.jeval']);
    for j = 1 : size(F2, 1)     % Loop over image of this identity
        % Open the original SIFT feature file for reading
        FileName =  [DirOriginal, F1(i).name '\' F2(j).name];
        HFile = fopen(FileName, 'r');
        
        NCol = fscanf(HFile, '%d\n', 1);    % Number of columns
        NRow = fscanf(HFile, '%d\n', 1);    % Number of rows
        
        if NCol ~= 128 && NRow ~= 27
            fprintf('Wrong number of features!!!\n');
        end
        for cRow = 1 : NRow
            Keypoints(cRow, 1:2) =  fscanf(HFile, '%f %f ', 2);
            Scales(cRow, 1:3) =  fscanf(HFile, '%f %f ', 3);
            for cCol = 1 : NCol
                Data0(cRow, cCol) = fscanf(HFile, '%f ', 1); 
                %fprintf('R(%d, %d) = %f\n', cRow, cCol, Data0(cRow, cCol));
            end
            fscanf(HFile, '\n', 1);
        end
        Data = Data0(:);
        fclose(HFile);
        
        % Store the feature
        FileName1 =  [DirTarget F2(j).name(1:end-21) '.mat'];
        save(FileName1, 'Data', 'Keypoints', 'Scales');
   
        t = t + 1;
        fprintf('Identity No. %d, Image No. %d, Total = %d\n', i, j, t);
        
    end
    
end




