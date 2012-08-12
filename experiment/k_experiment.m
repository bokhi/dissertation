function [] = k_experiment (method, k)
  %% estimate the influence of the k-neighbourhood parameters on the
  %% performances of non-linear dimension reduction methods
  
  no_dims = 300;

  if (k == 0)
    [train_Data, test_Data, train_SS, train_DD, test_SS, test_DD] = dimension_reduction ('view1', method, no_dims, 'k');
  else
    [train_Data, test_Data, train_SS, train_DD, test_SS, test_DD] = dimension_reduction ('view1', method, no_dims, k);
  end
  CRTT = accuracy (train_Data, test_Data, train_SS, train_DD, test_SS, test_DD, no_dims);

  if (exist ([method '_k_result.mat'], 'file'))

  end

  acc{k+1} = CRTT;
  maximum(k+1) = max(CRTT);
  minimum(k+1) = min(CRTT);
  average(k+1) = mean(CRTT);

  save ([method '_k_result.mat'], 'acc', 'maximum', 'minimum', 'average');

  