function [] = dim_experiment (no_method)
  %% estimate the influence of the number of features on the
  %% performances of dimension reduction methods

  load ('view1');

  method{1} = 'PCA';
  method{2} = 'LDA';
  method{3} = 'Isomap';
  method{4} = 'LLE';
  method{5} = 'Laplacian';

  no_dims = 1000;

  method = method{no_method};

  switch (method)
    case 'PCA'
    case 'LDA'
      [train_Data, test_Data, train_SS, train_DD, test_SS, test_DD] = dimension_reduction ('view1', method, no_dims);
    case 'Isomap'
    case 'LLE'
    case 'Laplacian'
      [train_Data, test_Data, train_SS, train_DD, test_SS, test_DD] = dimension_reduction ('view1', method, no_dims, 'k');
  end
  
  CRTT = accuracy (train_Data, test_Data, train_SS, train_DD, test_SS, test_DD, no_dims);

  if (exist ('dim_result.mat', 'file'))
    load ('dim_result.mat');
  end

  acc{no_method} = CRTT;
  
  save ('dim_result.mat', 'acc');

  