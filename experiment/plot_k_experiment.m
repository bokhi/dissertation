function [] = plot_k_experiment (method)

  load (['k_' method]);

  dim=1;
  while (isempty(CRTT{i}))
    dim = dim+1;
  end
  

  for i = dim:length(CRTT)
    [maximum(i), max_ind(i)] = max (CRTT{i});
    minimum(i) = min(CRTT{i});
    average = mean (CRTT{i});
  end
  
  figure;
  hold all;
  
  plot (dim:length(CRTT), maximum(dim:length(CRTT));
  plot (dim:length(CRTT), minimum(dim:length(CRTT));
  plot (dim:length(CRTT), average(dim:length(CRTT));

  xlabel ('no_dims');
  ylabel ('accuracy');
  legend ('maximum', 'minimum', 'average');

  print ('-dpng', ['k_' method '_result.png']);
end