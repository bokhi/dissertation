function [] = view2_performance (method)

  load (['view2_' method]);

  nb_fold = length(CRTT);

  roc = zeros (size(ROCTT{1}{:}(:,1)), 2);
  for i = 1:nb_fold
    roc = roc + ROCTT{i}{:};
  end

  roc = fliplr(roc)/nb_fold;

  dlmwrite([method '.txt'], roc, 'delimiter', ' ')

  mean_accuracy = sum(CRTT) / nb_fold;

  standard_deviation = sqrt (sum ((CRTT - mean_accuracy) .^ 2) / (nb_fold - 1));

  standard_error = standard_deviation / sqrt (nb_fold);

  save(['view2_' method], 'CRTT', 'ROCTT', 'roc', 'mean_accuracy', 'standard_error');
end