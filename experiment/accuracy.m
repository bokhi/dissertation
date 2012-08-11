function [CRTT] = accuracy (train_Data, test_Data, train_SS, train_DD, test_SS, test_DD, k)

  if nargin < 7
    k = 300;
  end

  addpath ('yiming');

  %%load (file);

  dim = size(train_Data, 2);

  k = min (dim, k);

  for i = 1:k
    tic;
    
    [CRTT(i), ROCTT{i}] = verification_ml_test (eye(i), ...
						train_Data(train_SS(:, 1),1:i), ...
						train_Data(train_SS(:, 2),1:i), ...
						train_Data(train_DD(:, 1),1:i), ...
						train_Data(train_DD(:, 2),1:i), ...
						test_Data(test_SS(:, 1),1:i), ...
						test_Data(test_SS(:, 2),1:i), ...
						test_Data(test_DD(:, 1),1:i), ...
						test_Data(test_DD(:, 2),1:i));

    time(i) = toc;
  end

  %%save(['accuracy_' file], 'CRTT', 'ROCTT', 'time');
end