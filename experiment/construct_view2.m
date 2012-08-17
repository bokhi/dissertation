function [train_Data, test_Data, train_SS, train_DD, test_SS, test_DD] = construct_view2 (fold)

  load (['fold_' num2str(fold)], 'nFold');

  for i = 1:nFold
    load (['fold_' num2str(fold)]);
    train_Dataf{i} = data;
    train_SSf{i} = SS;
    train_DDf{i} = DD;
  end

  train_Data = zeros(2 * nPair * (nFold - 1), nDim);
  train_DD = zeros (nEach * (nFold - 1), 2);					  
  train_SS = zeros (nEach * (nFold - 1), 2);					  
  
  index = 1;
  ind = 1;		
  sum = 0;			  
  
  for g = 1:nFold
    nb = size(train_Dataf{g}, 1);
    if (g == fold)
      test_Data = train_Dataf{g};
      test_DD = train_DDf{g};
      test_SS = train_SSf{g};
    else 
      train_Data(index:index+nb-1, :) = train_Dataf{g};
      index = index+nb;
      train_DD (ind:ind+nEach-1, :) = train_DDf{g} + sum;
      train_SS (ind:ind+nEach-1, :) = train_SSf{g} + sum;
      ind = ind + nEach;
      sum = sum + nb;
    end
  end
  
  train_Data = train_Data(1:index-1, :);
  
end



