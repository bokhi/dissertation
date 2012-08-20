function [] = estimate_dimension(file, n)

  addpath ('drtoolbox');
  addpath ('drtoolbox/techniques');

  load (file);

  method{1} = 'CorrDim';
  method{2} = 'NearNbDim';
  method{3} = 'PackingNumbers';
  method{4} = 'GMST';
  method{5} = 'EigValue';
  method{6} = 'MLE';

  data = [train_Data; test_Data];

  tic

  no_dims = intrinsic_dim(data, method{n})

  toc
end
