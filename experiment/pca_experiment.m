function [] = pca_experiment (file, method, no_dims, k)
  %% perform a PCA pre-reduction before applying the given dimension reduction method
  %% computation can be distributed

  pca_dims = [50 100]; %% PCA dimension to test
  method_dims = [1 no_dims];

  if (k == 0)
    k = 'k';
  end

  
  load (file);

  pca_train_Data = train_Data(:, 1:no_dims);
  pca_test_Data = test_Data(:, 1:no_dims);
    
  [method_train_Data, method_test_Data] = dimension_reduction(pca_train_Data, pca_test_Data, train_SS, train_DD, method, method_dims(2), k);

  crtt = accuracy (method_train_Data, method_test_Data, train_SS, train_DD, test_SS, test_DD, method_dims(1), method_dims(2));

  
  while (exist(['pca_' method '_' file '.lock'], 'file'))
    pause (rand () * 10);
  end

  fclose(fopen(['pca_' method '_' file '.lock'], 'w'));

  if (exist (['pca_' method '_' file '.mat'], 'file'))
    load (['pca_' method '_' file]);
  end
  
  CRTT{no_dims} = crtt;

  save (['pca_' method '_' file], 'CRTT');

  delete (['pca_' method '_' file '.lock']);
end