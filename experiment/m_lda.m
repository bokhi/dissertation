function [train_Data, test_Data] = m_lda(train_Data, test_Data, train_SS, train_DD,  no_dims)
  %% Perform a modified version of the LDA algorithm where Sw is defined
  %% by the similarity pairs whereas Sb is based on dissimilarity pairs

  fprintf ('LDA reduction\n');
  tic
  %% Make sure data is zero mean
  mapping.mean = mean(train_Data, 1);
  Data = bsxfun(@minus, train_Data, mapping.mean);

  %% Intialize Sw
  fprintf ('Compute Sw\n');
  Sw = zeros (size(train_Data, 2), size(train_Data, 2));

  %% Sum over similarity pairs
  x = train_Data(train_SS(:, 1), :) - train_Data(train_SS(:, 2), :);
  Sw = x' * x;

  %% Intialize Sb
  fprintf ('Compute Sb\n');
  Sb = zeros (size(train_Data, 2), size(train_Data, 2));

  %% Sum over dissimilarity pairs
  x = train_Data(train_DD(:, 1), :) - train_Data(train_DD(:, 2), :)
  Sb = x' * x;

  %% Perform eigendecomposition of inv(Sw)*Sb
  fprintf ('perform eigendecomposition\n');
  tol = 0;
  option.Disp = 0;
  options.isreal = 1;
  options.issym = 1;
  [M, lambda] = eigs(Sb, Sw, no_dims, 'lm', options);

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

  toc

end