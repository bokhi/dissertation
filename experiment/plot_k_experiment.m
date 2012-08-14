function [] = plot_k_experiment (method)

  load (['k_' method]);

  for i = 1:length(CRTT)
    [maximum(i), max_ind(i)] = max (CRTT{i});
    minimum(i) = min(CRTT{i});
    average = mean (CRTT{i});
  end

  figure;
  hold all;
  
  plot (1:length(CRTT), maximum);
  plot (1:length(CRTT), minimum);
  plot (1:length(CRTT), average);

  xlabel ('no_dims');
  ylabel ('accuracy');
  legend ('maximum', 'minimum', 'average');

  print ('-dpng', ['k_' method '_result.png']);
end