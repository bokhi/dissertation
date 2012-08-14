function [] = plot_dimension_experiment ()

  method{1} = 'PCA';
  method{2} = 'LDA';
  method{3} = 'Isomap';
  method{4} = 'LLE';
  method{5} = 'SIFT';
  
  figure;
  hold all;
  
  for i = 1:length (method)
    if (i == 5)
      load ('accuracy_view1.mat');
    end
    load (['accuracy_' method{i} '_view1.mat']);
    plot (1:length (CRTT), CRTT);
  end
  
  xlabel ('no_dims');
  ylabel ('accuracy');
  legend (method, 'Location', 'SouthEast');
  
  print ('-dpng', 'dimension_result.png');
end
