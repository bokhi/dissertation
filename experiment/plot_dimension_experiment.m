function [] = plot_dimension_experiment ()

  method{1} = 'SIFT';
  method{2} = 'PCA';
  method{3} = 'LDA';
  method{4} = 'Isomap';
  method{5} = 'LLE';

  
  figure;
  hold all;
  
  for i = 1:length (method)
    if (i == 1)
      load ('accuracy_view1.mat');
    else
      load (['accuracy_' method{i} '_view1.mat']);
    end
    plot (1:length (CRTT), CRTT);
  end
  
  xlabel ('no_dims');
  ylabel ('accuracy');
  legend (method, 'Location', 'SouthEast');
  
  print ('-dpng', 'dimension_result.png');
end
