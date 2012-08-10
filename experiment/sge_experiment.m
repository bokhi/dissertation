function [] = sge_experiment (n)

  reduction{1} = 'PCA';
  reduction{2} = 'LLE';
  reduction{3} = 'Laplacian';
  reduction{4} = 'Isomap';
  reduction{5} = 'LDA';

  file{1} = 'view1';
  file{3} = 'PCA-300_view1';

  dimension{1} = 3000;
  dimension{2} = 250;
  
  switch (n)
      %% compute dimension reduction
    case 1
      dimension_reduction (file{1}, reduction{1}, dimension{1});
      accuracy ([reduction{1} '-' num2str(dimension{1}) '_' file{1}]);
    case 2
      dimension_reduction (file{1}, reduction{2}, dimension{1});
      accuracy ([reduction{2} '-' num2str(dimension{1}) '_' file{1}]);
    case 3
      dimension_reduction (file{1}, reduction{3}, dimension{1});
      accuracy ([reduction{3} '-' num2str(dimension{1}) '_' file{1}]);
    case 4
      dimension_reduction (file{1}, reduction{4}, dimension{1});
      accuracy ([reduction{4} '-' num2str(dimension{1}) '_' file{1}]);
    case 5
      dimension_reduction (file{1}, reduction{5}, dimension{1});
      accuracy ([reduction{5} '-' num2str(dimension{1}) '_' file{1}]);
      %% estimate intrinsic dimensionality
    case 6
      estimate_dimension (file{1}, 1);
    case 7
      estimate_dimension (file{1}, 2);
    case 8
      estimate_dimension (file{1}, 3);
    case 9
      estimate_dimension (file{1}, 4);
    case 10
      estimate_dimension (file{1}, 5);
  end
end