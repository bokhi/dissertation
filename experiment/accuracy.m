function acc = accuracy (file)

  addpath ("yiming");

  load (file);

  dim = size(Data, 2);
  nEach = size(DataTT1, 1)/2;

  k = 300;

  for i = 1:k
    
    acc(i) = verification_ml_test (eye(i), Data(SS(:, 1), 1:i), \
				   Data(SS(:, 2), 1:i), Data(DD(:, 1), \
							   1:i), \
				   Data(DD(:, 2), 1:i), DataTT1(1:nEach, \
							      1:i), \
				   DataTT2(1:nEach, 1:i), \
				   DataTT1(nEach+1:end, 1:i), \
				   DataTT2(nEach+1:end, 1:i))
  end
  
  plot(1:k, acc)
  xlabel("dimension")
  ylabel("accuracy")
end