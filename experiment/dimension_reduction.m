function [] = dimension_reduction (file, technique, dimension)

  directory = "~/Exeter/dissertation/";

  addpath ([directory "experiment/drtoolbox"]);
  addpath ([directory "experiment/drtoolbox/techniques/"]);

  load(file)

  printf ([technique "-" num2str(dimension) " reduction\n"]);

  tic
  [Data, mapping] = compute_mapping (Data, technique, dimension);

  DataTT1 = out_of_sample (DataTT1, mapping);
  DataTT2 = out_of_sample (DataTT2, mapping);
  toc

  save('-mat7-binary', [technique "-" num2str(dimension) "_" file], 'Data', 'DataTT1', 'DataTT2', 'SS', 'DD');  
endfunction
  
