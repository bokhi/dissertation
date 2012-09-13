function [] = plot_best_parameter (file, epsilon)

  load (file);

  if (~isempty(strfind(file, 'parameter')))
    acc = ACC{1};
    for i = 2:length(ACC)
      acc = acc+ACC{i};
    end
    acc = acc / length(ACC);
  else

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
  end
  
  maximum = max(max(acc))
  [x, y] = find(acc == maximum)
  
  [x, y] = find(double(acc>(maximum-epsilon)));
  for i = 1:length (x)
    best(i) = acc(x(i), y(i));
  end
  scatter(x, y, 20, best, 's');
  axis([min(x)-1 max(x)+1 min(y)-1 max(y)+1]);
  colorbar;
  
  title(sprintf('accuracy greater than %f', maximum-epsilon));
		
  if (~isempty(strfind(file, 'k')))
    xlabel('k-neighbourhood parameter');
    ylabel('dimensionality reduction');
  else%%if (~isempty(strfind(file, 'pca')))
    xlabel('PCA-reduction dimensionality');
    ylabel('second dimensionality reduction');
  end

end    
    
