function [] = plot_pca_experiment (file)

  load (file);

  no_dims=1;
  while (isempty(CRTT{no_dims}))
    no_dims = no_dims+1;
  end

  for i = no_dims:length(CRTT)
    [maximum(i), max_ind(i)] = max (CRTT{i});
    minimum(i) = min(CRTT{i});
    average(i) = mean (CRTT{i});
  end

  hold all;
  
  plot (no_dims:length(CRTT), maximum(no_dims:length(CRTT)));
  plot (no_dims:length(CRTT), minimum(no_dims:length(CRTT)));
  plot (no_dims:length(CRTT), average(no_dims:length(CRTT)));

  xlabel ('no\_dims');
  ylabel ('accuracy');
  legend ('maximum', 'minimum', 'average');
  
  print ('-dpng', [file '_result.png']);
end
