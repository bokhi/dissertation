function [] = pca_experiment (file, method, no_dims, k)
  %% perform a PCA pre-reduction before applying the given dimension reduction method
  %% computation can be distributed
  
  load ('PCA_view1');
  load (file);

  pca_train_Data = train_Data(:, 1:no_dims);
  pca_test_Data = test_Data(:, 1:no_dims);
    
  [method_train_Data, method_test_Data] = dimension_reduction(pca_train_Data, pca_test_Data, train_SS, train_DD, method, no_dims, k);

  crtt = accuracy (method_train_Data, method_test_Data, train_SS, train_DD, test_SS, test_DD, 1, no_dims);

  
  while (exist(['pca_' method '.mat.lock'], 'file'))
    pause (rand () * 10);
  end

  fclose(fopen(['pca_' method '.mat.lock'], 'w'));

  if (exist (['pca_' method '_' file '.mat'], 'file'))
    load (['pca_' method '_' file '.mat']);
  end
  
  CRTT{no_dims} = crtt;

  save (['pca_' method '_' file '.mat'], 'CRTT');

  delete (['pca_' method '.mat.lock']);
end