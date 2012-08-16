function [] = f_m_lda(file, no_dims)

  load(file);

  [train_Data, test_Data] = m_lda(train_Data, test_Data, train_SS, train_DD, no_dims)

  save(['LDA_' file], 'train_Data', 'test_Data', 'train_SS', 'train_DD', 'test_SS', 'test_DD');
end