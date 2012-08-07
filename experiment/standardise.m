function [] = standardise (file)
  
  load (file)

  tic

  D = [Data; DataTT1; DataTT2];
  D = zscore (D);

  Data = D(1:size(Data, 1), :);
  DataTT1 = D(size(Data, 1)+1:size(Data, 1)+size(DataTT1, 1), :);
  DataTT2 = D(size(Data, 1)+size(DataTT1, 1):size(D, 1), :);

  time = time + toc;

  save(['s_' file], 'Data', 'DataTT1', 'DataTT2', 'SS', 'DD', 'time');  
end