function [] = f_accuracy (file, dim, nb_dim)

  directory = '~/dissertation/';
  database = [directory 'database/'];
  result = [directory 'result/'];

  load ([database file]);

  [crtt, roctt] = accuracy (train_Data, test_Data, train_SS, train_DD, test_SS, test_DD, dim, nb_dim)

  if (exist ([result 'accuracy_' file], 'file'))
    try 
      load ([result 'accuracy_' file]);
    catch err
      pause (rand () * 10);
      load ([result 'accuracy_' file], CRTT, ROCTT);
    end
  end
    
  CRTT(dim:dim+nb_dim-1) = crtt;
  for i = dim:dim+nb_dim-1
    ROCTT{i} = roctt{i};
  end
  
  pid = feature('getpid')
  
  save ([result pid '_accuracy_' file], 'CRTT', 'ROCTT');

  movefile([result pid '_accuracy_' file], [result 'accuracy_' file]);
end