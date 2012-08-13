function [] = f_accuracy (file, dim, nb_dim)

  load (file);

  [crtt, roctt] = accuracy (train_Data, test_Data, train_SS, train_DD, test_SS, test_DD, dim, nb_dim)

  if (exist (['accuracy_' file], 'file'))
    try 
      load (['accuracy_' file]);
    catch err
      pause (rand () * 10);
      load (['accuracy_' file], CRTT, ROCTT);
    end
  end
    
  CRTT(dim:dim+nb_dim-1) = crtt;
  for i = dim:dim+nb_dim-1
    ROCTT{i} = roctt{i};
  end
  
  pid = feature('getpid')
  
  save ([pid '_accuracy_' file], 'CRTT', 'ROCTT');

  movefile([pid '_accuracy_' file], ['accuracy_' file]);
end