function [] = plot_k_experiment (method)

  load ([method '_k_result']);

  figure;
  hold all;
  plot (1:length(acc)-1, maximum(2:end));
  plot (1:length(acc)-1, minimum(2:end));
  plot (1:length(acc)-1, average(2:end));
  plot ([1 length(acc)], [maximum(1) maximum(1)]);

  xlabel ('k');
  ylabel ('accuracy');
  legend ('maximum', 'minimum', 'average', 'adaptative');
  
  print ('-dpng', [method '_k_result.png']);
end