function [] = plot_dimension_experiment (file)

  method{1} = 'SIFT';
  method{2} = 'PCA';
  method{3} = 'LDA';
  method{4} = 'Isomap';
  method{5} = 'LLE';
  
  figure;
  hold all;

  dim = 3456;
  for i = 1:length(method)
    if (i == 1)
      load (['accuracy_' file]);
    else
      load (['accuracy_' method{i} '_' file]);
    end
    dim = min(dim, length(CRTT));
  end
  
  for i = 1:length (method)
    if (i == 1)
      load (['accuracy_' file]);
    else
      load (['accuracy_' method{i} '_' file]);
    end
    plot (1:dim, CRTT(1:dim));
  end
  
  xlabel ('reduction dimension');
  ylabel ('accuracy');
  legend (method, 'Location', 'SouthEast');
  
  print ('-dpng', ['dimension_result_' file '.png']);
end
