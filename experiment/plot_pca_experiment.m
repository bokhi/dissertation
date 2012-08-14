function [] = plot_pca_experiment (method)

  load (['pca_' method]);

  for i = 1:length(CRTT)
    [maximum(i), max_ind(i)] = max (CRTT{i});
    minimum(i) = min(CRTT{i});
    average = mean (CRTT{i});
  end