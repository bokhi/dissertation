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

  tic

  no_dims = intrinsic_dim(train_Data, method{n})

  toc
end

      