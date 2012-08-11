function [] = k_experiment (k)

  [train_Data, test_Data, train_SS, train_DD, test_SS, test_DD] = dimension_reduction ('view1', 'Isomap', 300, k);
  CRTT = accuracy (train_Data, test_Data, train_SS, train_DD, test_SS, test_DD);

  if (exist ('k_result.mat', 'file'))
    load k_result;
  end
  acc{k} = CRTT;
  maximum(k) = max(CRTT);
  minimum(k) = min(CRTT);
  average(k) = mean(CRTT);
  save ('k_result', 'acc', 'maximum', 'minimum', 'average');

  