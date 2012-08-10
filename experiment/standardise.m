function [] = standardise (file)
  
  load (file)

  tic

  D = [train_Data; test_Data];
  D = zscore (D);

  train_Data = D(1:size(train_Data, 1), :);
  test_Data = D(size(train_Data, 1)+1:size(train_Data, 1)+size(test_Data, 1), :);

  time = time + toc;

  save(['s_' file], 'train_Data', 'test_Data', 'train_SS', 'train_DD', 'test_SS', 'test_DD', 'time');
end