function [] = plot_pca_experiment (method)

  load (['pca_' method]);

  no_dims=1;
  while (isempty(CRTT{i}))
    no_dims = no_dims+1;
  end
  

  for i = no_dims:length(CRTT)
    [maximum(i), max_ind(i)] = max (CRTT{i});
    minimum(i) = min(CRTT{i});
    average = mean (CRTT{i});
  end
  
  figure;
  hold all;
  
  plot (no_dims:length(CRTT), maximum(no_dims:length(CRTT));
  plot (no_dims:length(CRTT), minimum(no_dims:length(CRTT));
  plot (no_dims:length(CRTT), average(no_dims:length(CRTT));

  xlabel ('no_dims');
  ylabel ('accuracy');
  legend ('maximum', 'minimum', 'average');
  
  print ('-dpng', ['pca_' method '_result.png']);
end
