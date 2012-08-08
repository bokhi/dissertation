function [] = dimension_reduction (file, technique, dimension)

  addpath ('drtoolbox');
  addpath ('drtoolbox/techniques/');

  load(file);

  fprintf ([technique '-' num2str(dimension) ' reduction\n']);

  tic
  [DataM, mapping] = compute_mapping (Data, technique, dimension);
  dimension = mapping.no_dims;

  DataTT1 = out_of_sample (DataTT1, mapping);
  DataTT2 = out_of_sample (DataTT2, mapping);
  time = toc

  n = size(Data, 1);

  if (isfield(mapping, 'conn_comp')) 
    filter = 1:n;
    filter(mapping.conn_comp) = 0;
    
    DataP = zeros(n, dimension);
    
    DataP(mapping.conn_comp, :) = DataM;
    DataP(filter ~= 0, :) = out_of_sample (Data(filter ~= 0, :), mapping);

    conn_comp = mapping.conn_comp;
    
    Data = DataP;
    save([technique '-' num2str(dimension) '_' file], 'Data', 'DataTT1', 'DataTT2', 'SS', 'DD', 'conn_comp', 'time');
  else
    Data = DataM;
    save([technique '-' num2str(dimension) '_' file], 'Data', 'DataTT1', 'DataTT2', 'SS', 'DD', 'time');
  end
end
  
