function [] = plot_best_parameter (file, epsilon)

  load (file);

  n = 1;
  while (isempty(CRTT{n}))
    n = n + 1;
  end

  m = 1;
  for i = n:length(CRTT)
    m = max(m, length(CRTT{i}));
  end
  
  acc = zeros(n, m);
  
  for i = n:length(CRTT)
    acc(i, 1:length(CRTT{i})) = CRTT{i};
  end

  maximum = max(max(acc))

  [x, y] = find(double(acc>(maximum-epsilon)));
  plot(x, y, 'o');

  title(sprintf('accuracy greater than %f', maximum-epsilon));

  if (~isempty(strfind(file, 'k')))
    xlabel('k-neighbourhood parameter');
    ylabel([file(3:end) '-reduction dimensionality']);
  elseif (~isempty(strfind(file, 'pca')))
    xlabel('PCA-reduction dimensionality');
    ylabel([file(5:end) '-reduction dimensionality']);
  end

end    
    