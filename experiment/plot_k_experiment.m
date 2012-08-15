function [] = plot_k_experiment (method)

  load (['k_' method]);

  no_dims=1;
  while (isempty(CRTT{no_dims}))
    no_dims = no_dims+1;
  end
  

  for i = no_dims:length(CRTT)
    [maximum(i), max_ind(i)] = max (CRTT{i});
    minimum(i) = min(CRTT{i});
    average = mean (CRTT{i});
  end
  
  figure;
  hold all;
  
  plot (no_dims:length(CRTT), maximum(no_dims:length(CRTT)));
  plot (no_dims:length(CRTT), minimum(no_dims:length(CRTT)));
  plot (no_dims:length(CRTT), average(no_dims:length(CRTT)));

  xlabel ('k');
  ylabel ('accuracy');
  legend ('maximum', 'minimum', 'average');

  print ('-dpng', ['k_' method '_result.png']);
end