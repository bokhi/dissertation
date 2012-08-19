function [] = select_best_parameter (fold, cross, method, k)
  %% select the best parameters for the fold by performing a fold-1
  %% cross-validation scheme

  pca_dims = [50 100]; %% PCA dimension to test
  method_dims = [1 50];

  load (['fold_' num2str(fold)], 'nFold');
  
  Cross = 1:nFold; %% indices of the folds being used to perform the cross-validation
  Cross(fold) = []; %% this one will be used for testing phase

  for i = 1:length(Cross)
    load (['fold_' num2str(Cross(i))]);
    train_Dataf{i} = data;
    train_SSf{i} = SS;
    train_DDf{i} = DD;
  end
  
  train_Data = zeros(2 * nPair * (nFold - 1), nDim);
  train_DD = zeros (nEach * (nFold - 2), 2);					  
  train_SS = zeros (nEach * (nFold - 2), 2);					  
  
  index = 1;
  ind = 1;		
  sum = 0;			  
  
  for i = 1:length(Cross)
    nb = size(train_Dataf{i}, 1);
    if (i == Cross(cross)) %% this fold is used as training set
      test_Data = train_Dataf{i};
      test_DD = train_DDf{i};
      test_SS = train_SSf{i};
    else 
      train_Data(index:index+nb-1, :) = train_Dataf{i};
      index = index+nb;
      train_DD (ind:ind+nEach-1, :) = train_DDf{i} + sum;
      train_SS (ind:ind+nEach-1, :) = train_SSf{i} + sum;
      ind = ind + nEach;
      sum = sum + nb;
    end
  end
  
  train_Data = train_Data(1:index-1, :);

  size(train_Data)
  size(test_Data)
  size(train_SS)
  size(train_DD)
  size(test_SS)
  size(test_DD)
  
  [pca_train_Data, pca_test_Data] = dimension_reduction (train_Data, test_Data, train_SS, train_DD, 'PCA', pca_dims(2), []);

  size(pca_train_Data)
  size(pca_test_Data)
  
  acc = zeros(pca_dims(2));
  
  for j = pca_dims(1):pca_dims(2)
    j
    [method_train_Data, method_test_Data] = dimension_reduction(pca_train_Data(:,1:j), pca_test_Data(:,1:j), train_SS, train_DD, method, j, k);
    acc(j, method_dims(1):min(j, method_dims(2))) = accuracy (method_train_Data, method_test_Data, train_SS, train_DD, test_SS, test_DD, method_dims(1), min(j,method_dims(2)));
  end

  while (exist(['parameter_' fold '_' method '.mat.lock'], 'file'))
    pause (rand () * 10);
  end
  
  fclose(fopen(['parameter_' fold '_' method '.mat.lock'], 'w'));

  if (exist (['parameter_' fold '_' method '_' file '.mat'], 'file'))
    load (['parameter_' fold '_' method '_' file '.mat']);
  end
  
  ACC{cross} = acc;

  save (['parameter_' fold '_' method '_' file '.mat'], 'ACC');
  
  delete (['parameter_' fold '_' method '.mat.lock']);
end
