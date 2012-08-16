function [] = f_dimension_reduction (file, technique, dimension, parameter)

  load (file);

  [train_Data, test_Data] = dimension_reduction (train_Data, test_Data, train_SS, train_DD, technique, dimension, parameter);

  save([technique '_' file], 'train_Data', 'test_Data', 'train_SS', 'train_DD', 'test_SS', 'test_DD');
end
