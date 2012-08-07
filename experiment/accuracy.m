function [] = accuracy (file)

  addpath ('yiming');

  load (file);

  dim = size(Data, 2);
  nEach = size(DataTT1, 1)/2;

  k = dim;

  for i = 1:k
    tic;
    
    [CRTT(i), ROCTT{i}] = verification_ml_test (eye(i), Data(SS(:, 1),1:i), ...
																Data(SS(:, 2),1:i), ...
																Data(DD(:, 1),1:i), ...
																Data(DD(:, 2),1:i), ...
																DataTT1(1:nEach,1:i), ...
																DataTT2(1:nEach, 1:i), ...
																DataTT1(nEach+1:nEach*2, 1:i), ...
																DataTT2(nEach+1:nEach*2, 1:i));
    time(i) = toc;
  end

  save(['accuracy_' file], 'CRTT', 'ROCTT', 'time');
end