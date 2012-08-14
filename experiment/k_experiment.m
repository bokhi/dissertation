function [] = k_experiment (method, no_dims, k)
  %% estimate the influence of the k-neighbourhood parameters on the
  %% performances of non-linear dimension reduction methods

  load ('view1');
  
  [train_Data, test_Data, train_SS, train_DD, test_SS, test_DD] = dimension_reduction (train_Data, test_Data, train_SS, train_DD, test_SS, test_DD, method, no_dims, k);
  
  crtt = accuracy (train_Data, test_Data, train_SS, train_DD, test_SS, test_DD, no_dims);

  while (exist(['k_' method '.mat.lock'], 'file'))
    pause (rand () * 10);
  end

  fclose(fopen(['k_' method '.mat.lock'], 'w'));

  if (exist ('k_' method '.mat'], 'file'))
    load (['k_' method '.mat']);
  end

  CRTT{i} = crtt;

  save (['k_' method '.mat'], 'CRTT');
end
  