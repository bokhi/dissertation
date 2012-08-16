function [CRTT] = accuracy (train_Data, test_Data, train_SS, train_DD, test_SS, test_DD, dim, nb_dim)
  %% Compute the accuracy of the given dataset for dimension from dim to dim+nb_dim-1

  addpath ('yiming');

  fprintf ('Compute accuracy\n');

  for j = 1:nb_dim
    tic
    i = j+dim-1;
    
    [CRTT(j)] = verification_ml_test (eye(i), ...
						train_Data(train_SS(:, 1),1:i), ...
						train_Data(train_SS(:, 2),1:i), ...
						train_Data(train_DD(:, 1),1:i), ...
						train_Data(train_DD(:, 2),1:i), ...
						test_Data(test_SS(:, 1),1:i), ...
						test_Data(test_SS(:, 2),1:i), ...
						test_Data(test_DD(:, 1),1:i), ...
						test_Data(test_DD(:, 2),1:i));

    fprintf ('dimension %d/%d : %f\n', i, dim+nb_dim-1, toc);
  end
end