function [] = f_dimension_reduction (file, technique, dimension, parameter)

  directory = '~/dissertation/';
  database = [directory 'database/'];

  load ([database file])

  [train_Data, test_Data, train_SS, train_DD, test_SS, test_DD] = dimension_reduction (train_Data, test_Data, train_SS, train_DD, test_SS, test_DD, technique, dimension, parameter);

  dimension = size(train_Data, 2);

  save([database technique '-' num2str(dimension) '_' file], 'train_Data', 'test_Data', 'train_SS', 'train_DD', 'test_SS', 'test_DD');
end
