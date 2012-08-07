function [] = m_lda(file)
  %% Perform a modified version of the LDA algorithm where Sw is defined
  %% by the similarity pairs whereas Sb is based on dissimilarity pairs

  load(file);

  fprintf ('LDA reduction\n');
  tic
  %% Make sure data is zero mean
  mapping.mean = mean(Data, 1);
  Data = bsxfun(@minus, Data, mapping.mean);

  %% Intialize Sw
  fprintf ('Compute Sw\n');
  Sw = zeros (size(Data, 2), size(Data, 2));

  %% Sum over similarity pairs
  for i = 1:size(SS, 1)
    x_i = Data(SS(i, 1), :);
    x_j = Data(SS(i, 2), :);
    Sw = Sw + (x_i - x_j) * (x_i - x_j)';
  end

  %% Intialize Sb
  fprintf ('Compute Sb\n');
  Sb = zeros (size(Data, 2), size(Data, 2));

  %% Sum over dissimilarity pairs
  for i = 1:size(DD, 1)
    x_i = Data(DD(i, 1), :);
    x_j = Data(DD(i, 2), :);
    Sb = Sb + (x_i - x_j) * (x_i - x_j)';
  end

  %% Perform eigendecomposition of inv(Sw)*Sb
  fprintf ('perform eigendecomposition\n');
  [M, lambda] = eig(Sb, Sw);

  %% Sort eigenvalues and eigenvectors in descending order
  no_dims = 1;
  lambda(isnan(lambda)) = 0;
  [lambda, ind] = sort(diag(lambda), 'descend');
  M = M(:,ind(1:min([no_dims size(M, 2)])));    
  
  %% Compute mapped data
  fprintf ('compute mapped data\n');
  Data = Data * M;
    
  %% Store mapping for the out-of-sample extension
  mapping.M = M;
  mapping.val = lambda;

  %% Map the testing data 
  DataTT1 = bsxfun(@minus, DataTT1, mapping.mean) * mapping.M;
  DataTT2 = bsxfun(@minus, DataTT2, mapping.mean) * mapping.M;
  
  time = toc

  save(['LDA_' file], 'Data', 'DataTT1', 'DataTT2', 'SS', 'DD', time);
end