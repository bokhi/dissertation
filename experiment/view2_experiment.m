function [] = view2_experiment (method, fold)

  [train_Data, test_Data, train_SS, train_DD, test_SS, test_DD] = construct_view2 (fold);

  switch (method)
    case 'LDA'
      pca_dim = [93,100,94,92,97,92,90,87,97,85];
      method_dim = [11,19,16,11,21,17,16,21,17,15];
      parameter = [];
    case 'Isomap'
      pca_dim = zeros(1,10)+73;
      method_dim = zeros(1,10)+56;
      parameter = 22;
    case 'LLE'
      pca_dim = zeros(1,10)+66;
      method_dim = zeros(1,10)+15;
      parameter = 17;
  end

  [pca_train_Data, pca_test_Data] = dimension_reduction(train_Data, test_Data, train_SS, train_DD, 'PCA', pca_dim(fold), []);
  [method_train_Data, method_test_Data] = dimension_reduction(pca_train_Data, pca_test_Data, train_SS, train_DD, method, method_dim(fold), parameter);
  [crtt, roctt] = accuracy (method_train_Data, method_test_Data, train_SS, train_DD, test_SS, test_DD, method_dim(fold), 1);
  
  while (exist(['view2_' method '.mat.lock'], 'file'))
    pause (rand () * 10);
  end

  fclose(fopen(['view2_' method '.mat.lock'], 'w'));

  if (exist (['view2_' method '.mat'], 'file'))
    load (['view2_' method '.mat']);
  end

  CRTT(fold) = crtt;
  ROCTT{fold} = roctt;

  save (['view2_' method '.mat'], 'CRTT', 'ROCTT');

  delete (['view2_' method '.mat.lock']);
end
  