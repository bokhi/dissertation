function [] = lda_experiment (no_dims)

  k = 10;

  pid = feature('getpid')

  load ('PCA_view1');

  for i = no_dims:no_dims+k-1
    
    train_Data = train_Data(:, 1:i);
    test_Data = test_Data(:, 1:i);
    
    [lda_train_Data, lda_test_Data] = M_lda(train_Data, test_Data, train_SS, train_DD, test_SS, test_DD, no_dims);
    
    CRTT{i} = accuracy (lda_train_Data, lda_test_Data, train_SS, train_DD, test_SS, test_DD, i);
    
  end 

  try 
    load ('lda_result.mat');
  catch err
    pause (rand () * 10);
    load ('lda_result.mat');
  end

  for i = no_dims:no_dims+k-1
    acc{i} = CRTT{i};
    maximum(i) = max(CRTT{i});
    minimum(i) = max(CRTT{i});
    average(i) = mean(CRTT{i});
  end
  
  save ([pid '_lda_result.mat'], 'acc', 'maximum', 'minimum', 'average');

  movefile([pid '_lda_result.mat'], 'lda_result.mat');
end