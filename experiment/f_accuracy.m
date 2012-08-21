function [] = f_accuracy (file, dim, nb_dim)
  %% compute the accuracy of a given dataset
  %% can be run concurrently to speed the computation

  load (file);

  [crtt] = accuracy (train_Data, test_Data, train_SS, train_DD, test_SS, test_DD, dim, nb_dim)

  %% prevent overwritting by another parallel instance using a lock
  while (exist (['accuracy_' file '.lock'], 'file'))
    pause (rand () * 10); 
  end
  
  fclose(fopen(['accuracy_' file '.lock'], 'w'));

  if (exist (['accuracy_' file], 'file'))
    load (['accuracy_' file]);
  end
  
  CRTT(dim:dim+nb_dim-1) = crtt(1:nb_dim);
  
  save (['accuracy_' file], 'CRTT');

  delete (['accuracy_' file '.lock']);
end