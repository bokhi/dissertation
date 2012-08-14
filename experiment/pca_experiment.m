function [] = pca_experiment (method, no_dims, k)
  %% perform PCA pre-reduction 
  
  load ('PCA_view1');

  pca_train_Data = train_Data(:, 1:no_dims);
  pca_test_Data = test_Data(:, 1:no_dims);
    
  [lda_train_Data, lda_test_Data] = dimension_reduction(pca_train_Data, pca_test_Data, train_SS, train_DD, method, no_dims, k);

  crtt = accuracy (lda_train_Data, lda_test_Data, train_SS, train_DD, test_SS, test_DD, no_dims);

  
  while (exist(['pca_' method '.mat.lock'], 'file'))
    pause (rand () * 10);
  end

  fclose(fopen(['pca_' method '.mat.lock'], 'w'));

  if (exist (['pca_' method '.mat'], 'file'))
    load (['pca_' method '.mat']);
  end
  
  CRTT{i} = crtt;

  save (['pca_' method '.mat'], 'CRTT');

  delete (['pca_' method '.mat.lock']);
end