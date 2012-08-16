function [train_Data, test_Data] = dimension_reduction (train_Data, test_Data, train_SS, train_DD, method, dimension, parameter)

  %% Perform the specified dimension reduction method on the training
  %% and testing data set the out-of-sample extension is used to compute
  %% the reduction of the testing set and training points non connected
  %% to the principal graph component for Isomap and LLE

  addpath ('drtoolbox');
  addpath ('drtoolbox/techniques/');

  fprintf ([method '-' num2str(dimension) ' reduction\n']);
  
  tic
  
  if (strcmp (method,'LDA'))
    [train_Data, test_Data] = m_lda(train_Data, test_Data, train_SS, train_DD, dimension);
  else
    [DataM, mapping] = compute_mapping (train_Data, method, dimension, parameter);
    test_Data = out_of_sample (test_Data, mapping);

    if (isfield(mapping, 'no_dims')) 
      no_dims = mapping.no_dims;    %% the final dimensionality differ from dimension
    else
      no_dims = dimension;
    end

    n = size(train_Data, 1);

    if (isfield(mapping, 'conn_comp')) %% training set was not completely reduced, map the rest using out-of-sample
      filter = 1:n;
      filter(mapping.conn_comp) = 0;
      
      DataP = zeros(n, no_dims);
      
      DataP(mapping.conn_comp, :) = DataM;
      DataP(filter ~= 0, :) = out_of_sample (train_Data(filter ~= 0, :), mapping); 

      train_Data = DataP;
    else
      train_Data = DataM;
    end
  end

  toc
end

