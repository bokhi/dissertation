function [] = k_experiment (file, method, no_dims, k)
  %% estimate the influence of the k-neighbourhood parameters on the
  %% performances of non-linear dimension reduction methods

  load (file);
  
  [train_Data, test_Data] = dimension_reduction (train_Data, test_Data, train_SS, train_DD, method, no_dims, k);
  
  crtt = accuracy (train_Data, test_Data, train_SS, train_DD, test_SS, test_DD, 1, no_dims);

  while (exist(['k_' method '_' file '.mat.lock'], 'file'))
    pause (rand () * 10);
  end

  fclose(fopen(['k_' method '_' file '.mat.lock'], 'w'));

  if (exist (['k_' method '_' file '.mat'], 'file'))
    load (['k_' method '_' file '.mat']);
  end

  CRTT{k} = crtt;

  save (['k_' method '_' file '.mat'], 'CRTT');

  delete (['k_' method '_' file '.mat.lock']);
end
  