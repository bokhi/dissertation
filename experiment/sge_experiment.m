function [] = sge_experiment (n)

  reduction{1} = 'PCA';
  reduction{2} = 'LLE';
  reduction{3} = 'Laplacian';
  reduction{4} = 'Isomap';

  file{1} = 'view1.bin';
  file{2} = 's_view1.bin';
  file{3} = 'PCA-300_view1.bin';

  dimension{1} = 3000;
  dimension{2} = 250;
  
  switch (n)
      %% file{1}
    case 1
      dimension_reduction (file{1}, reduction{1}, dimension{1});
      accuracy ([reduction{1} '-' dimension{1} '_' file{1}]);
    case 2
      dimension_reduction (file{1}, reduction{2}, dimension{1});
      accuracy ([reduction{2} '-' dimension{1} '_' file{1}]);
    case 3
      dimension_reduction (file{1}, reduction{3}, dimension{1});
      accuracy ([reduction{3} '-' dimension{1} '_' file{1}]);
    case 4
      dimension_reduction (file{1}, reduction{4}, dimension{1});
      accuracy ([reduction{4} '-' dimension{1} '_' file{1}]);

      %% file{2}
    case 5
      dimension_reduction (file{2}, reduction{1}, dimension{1});
      accuracy ([reduction{1} '-' dimension{1} '_' file{2}]);
    case 6
      dimension_reduction (file{2}, reduction{2}, dimension{1});
      accuracy ([reduction{2} '-' dimension{1} '_' file{2}]);
    case 7
      dimension_reduction (file{2}, reduction{3}, dimension{1});
      accuracy ([reduction{3} '-' dimension{1} '_' file{2}]);
    case 8
      dimension_reduction (file{2}, reduction{4}, dimension{1});
      accuracy ([reduction{4} '-' dimension{1} '_' file{2}]);

      %% file{3}
    case 9
      dimension_reduction (file{3}, reduction{1}, dimension{2});
      accuracy ([reduction{1} '-' dimension{2} '_' file{3}]);
    case 10
      dimension_reduction (file{3}, reduction{2}, dimension{2});
      accuracy ([reduction{2} '-' dimension{2} '_' file{3}]);
    case 11
      dimension_reduction (file{3}, reduction{3}, dimension{2});
      accuracy ([reduction{3} '-' dimension{2} '_' file{3}]);
    case 12
      dimension_reduction (file{3}, reduction{4}, dimension{2});
      accuracy ([reduction{4} '-' dimension{2} '_' file{3}]);

      %% M_LDA
    case 13
      m_lda (file{1});
      accuracy (['M_LDA_' file{1}]);
    case 14
      m_lda (file{2});
      accuracy (['M_LDA_' file{2}]);
    case 15
      m_lda (file{3});
      accuracy (['M_LDA_' file{3}]);

      %% extract views
    case 16
      extract_view1 ();
      standardise ('view1');
    case 17
      extract_view2 ();
  end
		