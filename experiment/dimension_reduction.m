function [] = dimension_reduction (file, technique, dimension)

  addpath ("drtoolbox");
  addpath ("drtoolbox/techniques/");

  load(file)

  printf ([technique "-" num2str(dimension) " reduction\n"]);

  tic
  [DataM, mapping] = compute_mapping (Data, technique, dimension);

  DataTT1 = out_of_sample (DataTT1, mapping);
  DataTT2 = out_of_sample (DataTT2, mapping);
  toc

  n = size(Data, 1);
  
  

  if (isfield(mapping, "conn_comp") && length(mapping.conn_comp) ~= n)
    filter = 1:n;
    filter(mapping.conn_comp) = 0
    
    DataP = zeros(n, dimension);
    
    DataP(mapping.conn_comp, :) = DataM
    DataP(filter ~= 0, :) = out_of_sample (Data(filter ~= 0, :), mapping);
    
    Data = DataP;
    save('-mat7-binary', [technique "-" num2str(dimension) "_" file], \
	 'Data', 'DataTT1', 'DataTT2', 'SS', 'DD', 'mapping.conn_comp');
  else
    Data = DataM;
    save('-mat7-binary', [technique "-" num2str(dimension) "_" file], \
	 'Data', 'DataTT1', 'DataTT2', 'SS', 'DD');
  end
  
  
endfunction
  
