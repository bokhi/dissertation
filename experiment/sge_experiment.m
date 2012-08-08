function [] = sge_experiment (n)

  reduction{1} = 'PCA';
  reduction{2} = 'LLE';
  reduction{3} = 'Laplacian';
  reduction{4} = 'Isomap';

  file{1} = 'view1.mat';
  file{2} = 's_view1.mat';
  file{3} = 'PCA-300_view1.mat';
  file{4} = 'unique_view1.mat';

  dimension{1} = 3000;
  dimension{2} = 250;
  
  switch (n)
      %% file{1}
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

      %% file{2}
    case 5
      dimension_reduction (file{2}, reduction{1}, dimension{1});
      accuracy ([reduction{1} '-' num2str(dimension{1}) '_' file{2}]);
    case 6
      dimension_reduction (file{2}, reduction{2}, dimension{1});
      accuracy ([reduction{2} '-' num2str(dimension{1}) '_' file{2}]);
    case 7
      dimension_reduction (file{2}, reduction{3}, dimension{1});
      accuracy ([reduction{3} '-' num2str(dimension{1}) '_' file{2}]);
    case 8
      dimension_reduction (file{2}, reduction{4}, dimension{1});
      accuracy ([reduction{4} '-' num2str(dimension{1}) '_' file{2}]);

      %% file{3}
    case 9
      dimension_reduction (file{3}, reduction{1}, dimension{2});
      accuracy ([reduction{1} '-' num2str(dimension{2}) '_' file{3}]);
    case 10
      dimension_reduction (file{3}, reduction{2}, dimension{2});
      accuracy ([reduction{2} '-' num2str(dimension{2}) '_' file{3}]);
    case 11
      dimension_reduction (file{3}, reduction{3}, dimension{2});
      accuracy ([reduction{3} '-' num2str(dimension{2}) '_' file{3}]);
    case 12
      dimension_reduction (file{3}, reduction{4}, dimension{2});
      accuracy ([reduction{4} '-' num2str(dimension{2}) '_' file{3}]);

      %% M_LDA
    case 13
      m_lda (file{1});
      accuracy (['LDA_' file{1}]);
    case 14
      m_lda (file{2});
      accuracy (['LDA_' file{2}]);
    case 15
      m_lda (file{3});
      accuracy (['LDA_' file{3}]);

      %% extract views
    case 16
      extract_view1 ();
      standardise ('view1');
    case 17
      extract_view2 ();
      standardise ('view1');
    case 18
      unique_extract_view1 ();
      standardise ('unique_view1.mat');
    case 19
      unique_extract_view2 ();
      standardise ('unique_view2.mat');
      
   %% file{4}
    case 20
      dimension_reduction (file{4}, reduction{1}, dimension{1});
      accuracy ([reduction{1} '-' num2str(dimension{1}) '_' file{4}]);
    case 21
      dimension_reduction (file{4}, reduction{2}, dimension{1});
      accuracy ([reduction{2} '-' num2str(dimension{1}) '_' file{4}]);
    case 22
      dimension_reduction (file{4}, reduction{3}, dimension{1});
      accuracy ([reduction{3} '-' num2str(dimension{1}) '_' file{4}]);
    case 23
      dimension_reduction (file{4}, reduction{4}, dimension{1});
      accuracy ([reduction{4} '-' num2str(dimension{1}) '_' file{4}]);

    case 24
      m_lda (file{4});
      accuracy (['LDA_' file{4}]);


  end
end