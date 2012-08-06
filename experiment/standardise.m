function [] = standardise (file)
  
  load (file)

  D = [Data; DataTT1; DataTT2];
  D = zscore (D);

  Data = D(1:size(Data, 1), :);
  DataTT1 = D(size(Data, 1)+1:size(Data, 1)+size(DataTT1, 1), :);
  DataTT2 = D(size(Data, 1)+size(DataTT1, 1):end, :);

  save(['s_' file], 'Data', 'DataTT1', 'DataTT2', 'SS', 'DD');  
end