function [] = f_m_lda(file, no_dims)
  %% Perform a modified version of the LDA algorithm where Sw is defined
  %% by the similarity pairs whereas Sb is based on dissimilarity pairs

  load(file);

  [train_Data, test_Data] = m_lda(train_Data, test_Data, train_SS, train_DD, no_dims)

  save(['LDA_' file], 'train_Data', 'test_Data', 'train_SS', 'train_DD', 'test_SS', 'test_DD');
end