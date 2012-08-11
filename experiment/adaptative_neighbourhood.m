function [] = adaptative_neighbourhood (file)

load (file)

addpath ('drtoolbox');
addpath ('drtoolbox/techniques');

tic;
[D, max_k_val, no_dims] = find_nn_adaptive(train_Data);
time = toc

save (file, 'train_Data', 'test_Data', 'train_SS', 'train_DD', 'test_SS', 'test_DD', 'D', 'max_k_val', 'no_dims');          
