function [] = view2_performance (method)

  load (['view2_' method]);

  nb_fold = length(CRTT);

  mean_accuracy = sum(CRTT) / nb_fold;

  standard_deviation = sqrt (sum ((CRTT - mean_accuracy) .^ 2) / (nb_fold - 1));

  standard_error = standard_deviation / sqrt (nb_fold);

  save(['view2_' method], 'CRTT', 'ROCTT', 'mean_accuracy', 'standard_error');
end