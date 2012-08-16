function [train_Data, test_Data] = m_lda(train_Data, test_Data, train_SS, train_DD,  no_dims)
  %% Perform a modified version of the LDA algorithm where Sw is defined
  %% by the similarity pairs whereas Sb is based on dissimilarity pairs

  fprintf ('LDA reduction\n');
  tic
  
  %% Make sure data is zero mean
  mapping.mean = mean(train_Data, 1);
  Data = bsxfun(@minus, train_Data, mapping.mean);
  
  fprintf ('Compute Sw\n');
  SS = train_Data(train_SS(:, 1), :) - train_Data(train_SS(:, 2), :);
  Sw = SS' * SS;
  
  fprintf ('Compute Sb\n');
  DD = train_Data(train_DD(:, 1), :) - train_Data(train_DD(:, 2), :);
  Sb = DD' * DD;

  %% Perform eigendecomposition of inv(Sw)*Sb
  fprintf ('perform eigendecomposition\n');
  [mapping.M, lambda] = eig(Sb, Sw);

  %% Sort eigenvalues and eigenvectors in descending order
  lambda(isnan(lambda)) = 0;
  [mapping.lambda, ind] = sort(diag(lambda), 'descend');
  mapping.M = mapping.M(:,ind(1:min([no_dims size(mapping.M, 2)])));    
  
  %% Compute mapped data
  fprintf ('compute mapped data\n');
  train_Data = train_Data * mapping.M;
  test_Data = bsxfun(@minus, test_Data, mapping.mean) * mapping.M;
    
  toc
end