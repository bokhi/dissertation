function [] = plot_dim_experiment ()

  method{1} = 'PCA';
  method{2} = 'LDA';
  method{3} = 'Isomap';
  method{4} = 'LLE';
  method{5} = 'Laplacian';
  
  load ('dim_result');
  
  figure;
  hold all;
  for i = 1:length (acc)
    plot (1:length (acc{i}), acc{i});
  end
  
  xlabel ('no_dims');
  ylabel ('accuracy');
  legend (method);

  print ('-dpng', 'dim_result.png');
end
