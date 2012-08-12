function [] = lda_experiment (no_dims)
  
  load ('PCA_view1');
  
  train_Data = train_Data(:, 1:no_dims);
  test_Data = test_Data(:, 1:no_dims);
  
  [train_Data, test_Data, train_SS, train_DD, test_SS, test_DD] = M_lda(train_Data, test_Data, train_SS, train_DD, test_SS, test_DD, no_dims);
  
  CRTT = accuracy (train_Data, test_Data, train_SS, train_DD, test_SS, test_DD, no_dims);
  
  if (exist ('lda_result.mat', 'file'))
    load ('lda_result.mat');
  end
  
  acc{no_dims} = CRTT;
  maximum(no_dims) = max(CRTT);
  minimum(no_dims) = min(CRTT);
  average(no_dims) = mean(CRTT);
  
  save ('lda_result.mat', 'acc', 'maximum', 'minimum', 'average');
end
  