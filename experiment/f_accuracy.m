function [] = f_accuracy (file, dim, nb_dim)

  pid = feature('getpid');

  load (file);

  [crtt, roctt] = accuracy (train_Data, test_Data, train_SS, train_DD, test_SS, test_DD, dim, nb_dim);

  pause (rand () * 10);
  if (exist (['accuracy_' file], 'file'))
    try 
      load (['accuracy_' file]);
    catch err
      pause (rand () * 10);
      load (['accuracy_' file], CRTT, ROCTT);
    end
  end
    
  CRTT(dim:dim+nb_dim-1) = crtt(1:nb_dim);
  for i = 1:nb_dim
    ROCTT{i+dim-1} = roctt{i};
  end
  
  save ([num2str(pid) '_accuracy_' file], 'CRTT', 'ROCTT');

  movefile([num2str(pid) '_accuracy_' file], ['accuracy_' file]);
end