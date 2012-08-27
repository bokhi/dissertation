function [] = view2_experiment (file, method, fold)

  [train_Data, test_Data, train_SS, train_DD, test_SS, test_DD] = construct_view2 (file, fold);

  switch (method)
    case 'LDA'
      if (isempty(strfind(file, 'sqrt')))
	pca_dim = [93,100,94,92,97,92,90,87,97,85];
	method_dim = [11,19,16,11,21,17,16,21,17,15];
      else 
	pca_dim = [86,81,74,90,97,98,73,90,97,89];
	method_dim = [11,19,15,11,8,12,16,21,15,21];
      end
      parameter = [];      
    case 'Isomap'
      if (isempty(strfind(file, 'sqrt')))
	pca_dim = zeros(1,10)+50;
	method_dim = zeros(1,10)+42;
	parameter = 107;
      else
	pca_dim = zeros(1,10)+55;
	method_dim = zeros(1,10)+44;
	parameter = 93;
      end
    case 'LLE'
      if (isempty(strfind(file, 'sqrt')))
	pca_dim = zeros(1,10)+58;
	method_dim = zeros(1,10)+35;
	parameter = 136;
      else
	pca_dim = zeros(1,10)+51;
	method_dim = zeros(1,10)+29;
	parameter = 78;
      end
    case 'PCA'
      if (isempty(strfind(file, 'sqrt')))      
	pca_dim = [146, 135, 140, 145, 147, 134, 142, 133, 125, 148];
      else
	pca_dim = [100, 112, 130, 127, 96, 134, 148, 119, 114, 149];
      end
      method_dim = pca_dim;
      parameter = [];
    case 'SIFT'
      pca_dim = []
      method_dim = zeros(1,10)+3456;
      parameter = [];
  end

  if (method == 'SIFT')
    method_train_Data = train_Data;
    method_test_Data = test_Data;
  elseif (method == 'PCA')
    [method_train_Data, method_test_Data] = dimension_reduction(train_Data, test_Data, train_SS, train_DD, 'PCA', pca_dim(fold), []);
  else
    [pca_train_Data, pca_test_Data] = dimension_reduction(train_Data, test_Data, train_SS, train_DD, 'PCA', pca_dim(fold), []);
    [method_train_Data, method_test_Data] = dimension_reduction(pca_train_Data, pca_test_Data, train_SS, train_DD, method, method_dim(fold), parameter);
  end

  [crtt, roctt] = accuracy (method_train_Data, method_test_Data, train_SS, train_DD, test_SS, test_DD, method_dim(fold), 1);
  
  while (exist(['view2_' method '_' file '.lock'], 'file'))
    pause (rand () * 10);
  end

  fclose(fopen(['view2_' method '_' file '.lock'], 'w'));

  if (exist (['view2_' method '_' file '.mat'], 'file'))
    load (['view2_' method '_' file]);
  end

  CRTT(fold) = crtt;
  ROCTT{fold} = roctt;

  save (['view2_' method '_' file], 'CRTT', 'ROCTT');

  delete (['view2_' method '_' file '.lock']);
end
  