function [train_Data, test_Data, train_SS, train_DD, test_SS, test_DD] = M_lda(train_Data, test_Data, train_SS, train_DD, test_SS, test_DD, no_dims)
  %% Perform a modified version of the LDA algorithm where Sw is defined
  %% by the similarity pairs whereas Sb is based on dissimilarity pairs

  load(file);

  fprintf ('LDA reduction\n');
  tic
  %% Make sure data is zero mean
  mapping.mean = mean(train_Data, 1);
  Data = bsxfun(@minus, train_Data, mapping.mean);

  %% Intialize Sw
  fprintf ('Compute Sw\n');
  Sw = zeros (size(train_Data, 2), size(train_Data, 2));

  %% Sum over similarity pairs
  for i = 1:size(train_SS, 1)
    x_i = train_Data(train_SS(i, 1), :);
    x_j = train_Data(train_SS(i, 2), :);
    Sw = Sw + (x_i - x_j) * (x_i - x_j)';
  end

  %% Intialize Sb
  fprintf ('Compute Sb\n');
  Sb = zeros (size(train_Data, 2), size(train_Data, 2));

  %% Sum over dissimilarity pairs
  for i = 1:size(train_DD, 1)
    x_i = train_Data(train_DD(i, 1), :);
    x_j = train_Data(train_DD(i, 2), :);
    Sb = Sb + (x_i - x_j) * (x_i - x_j)';
  end

  %% Perform eigendecomposition of inv(Sw)*Sb
  fprintf ('perform eigendecomposition\n');
  [M, lambda] = eig(Sb, Sw);

  %% Sort eigenvalues and eigenvectors in descending order
  lambda(isnan(lambda)) = 0;
  [lambda, ind] = sort(diag(lambda), 'descend');
  M = M(:,ind(1:min([no_dims size(M, 2)])));    
  
  %% Compute mapped data
  fprintf ('compute mapped data\n');
  train_Data = train_Data * M;
    
  %% Store mapping for the out-of-sample extension
  mapping.M = M;
  mapping.val = lambda;

  %% Map the testing data 
  test_Data = bsxfun(@minus, test_Data, mapping.mean) * mapping.M;

  time = toc

  save(['LDA_' file], 'train_Data', 'test_Data', 'train_SS', 'train_DD', 'test_SS', 'test_DD', 'time');
end