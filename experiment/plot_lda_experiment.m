function [] = plot_lda_experiment ()

  load ('lda_result');

  figure;
  hold all;
  
  plot (1:length(acc), maximum);
  plot (1:length(acc), minimum);
  plot (1:length(acc), average);

  xlabel ('PCA pre-reduction no_dims');
  ylabel ('accuracy');
  legend ('maximum', 'minimum', 'average');
  
  print ('-dpng', 'lda_result.png');
end
  