function [] = k_experiment (k)

  [train_Data, test_Data, train_SS, train_DD, test_SS, test_DD] = dimension_reduction ('view1', 'LLE', 300, k);
  CRTT = accuracy (train_Data, test_Data, train_SS, train_DD, test_SS, test_DD, 300);

  if (exist ('lle_k_result.mat', 'file'))
    load k_result;
  end
  acc{k} = CRTT;
  maximum(k) = max(CRTT);
  minimum(k) = min(CRTT);
  average(k) = mean(CRTT);
  save ('lle_k_result', 'acc', 'maximum', 'minimum', 'average');

  