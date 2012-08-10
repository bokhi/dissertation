function [] = dimension_reduction (file, technique, dimension)

  addpath ('drtoolbox');
  addpath ('drtoolbox/techniques/');

  load(file);

  fprintf ([technique '-' num2str(dimension) ' reduction\n']);

  tic

  if (strcmp (technique,'LDA'))
    m_lda (file, dimension);
  else
    [DataM, mapping] = compute_mapping (train_Data, technique, dimension);
    if (isfield(mapping, 'no_dims')) 
      no_dims = mapping.no_dims;
    else
      no_dims = dimension;
    end

    test_Data = out_of_sample (test_Data, mapping);

    time = toc

    n = size(train_Data, 1);

    if (isfield(mapping, 'conn_comp')) 
      filter = 1:n;
      filter(mapping.conn_comp) = 0;
      
      DataP = zeros(n, no_dims);
      
      DataP(mapping.conn_comp, :) = DataM;
      DataP(filter ~= 0, :) = out_of_sample (train_Data(filter ~= 0, :), mapping);

      conn_comp = mapping.conn_comp;
      
      train_Data = DataP;
      save([technique '-' num2str(dimension) '_' file], 'train_Data', 'test_Data', 'train_SS', 'train_DD', 'test_SS', 'test_DD', 'conn_comp', 'time');
    else
      train_Data = DataM;
      save([technique '-' num2str(dimension) '_' file], 'train_Data', 'test_Data', 'train_SS', 'train_DD', 'test_SS', 'test_DD', 'time');
    end
  end
end

