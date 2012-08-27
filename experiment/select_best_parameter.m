function [] = select_best_parameter (file, fold, cross, method, k)
  %% select the best parameters for the fold by performing a fold-1
  %% cross-validation scheme

  if (method == 'PCA')
    pca_dims = [150 150];
    method_dims = [51 100];
  else
    pca_dims = [50 100]; %% PCA dimension to test
    method_dims = [1 50];
  end


  load ([file num2str(fold)], 'nFold');
  
  Cross = 1:nFold; %% indices of the folds being used to perform the cross-validation
  Cross(fold) = []; %% this one will be used for testing phase

  for i = 1:length(Cross)
    load ([file num2str(Cross(i))]);
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
    if (i == cross) %% this fold is used as training set
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

  [pca_train_Data, pca_test_Data] = dimension_reduction (train_Data, test_Data, train_SS, train_DD, 'PCA', pca_dims(2), []);

  acc = zeros(pca_dims(2));
  
  for j = pca_dims(1):pca_dims(2)
    j
    if (method == 'PCA')
      method_train_Data = pca_train_Data(:,1:j);
      method_test_Data = pca_test_Data(:,1:j);
    else
      [method_train_Data, method_test_Data] = dimension_reduction(pca_train_Data(:,1:j), pca_test_Data(:,1:j), train_SS, train_DD, method, j, k);
    end
    acc(j, method_dims(1):method_dims(1)+min(j, method_dims(2))) = accuracy (method_train_Data, method_test_Data, train_SS, train_DD, test_SS, test_DD, method_dims(1), min(j,method_dims(2)));
  end

  while (exist(['parameter_' num2str(fold) '_' method '_' file '.lock'], 'file'))
    pause (rand () * 10);
  end
  
  fclose(fopen(['parameter_' num2str(fold) '_' method '_' file '.lock'], 'w'));

  if (exist (['parameter_' num2str(fold) '_' method '_' file '.mat'], 'file'))
    load (['parameter_' num2str(fold) '_' method '_' file]);
  end
  
  ACC{cross} = acc;

  save (['parameter_' num2str(fold) '_' method '_' file], 'ACC');
  
  delete (['parameter_' num2str(fold) '_' method '_' file '.lock']);
end
