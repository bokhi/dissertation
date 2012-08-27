#!/bin/bash
cd ~/dissertation/experiment

for i in {1..10}
do
    #qsub -N best_fold_$i -t 1-9 -v FILE=fold,FOLD=$i,METHOD=LDA,K=[] select_best_parameter.sh
    #qsub -N best_sqrt_fold_$i -t 1-9 -v FILE=sqrt_fold,FOLD=$i,METHOD=LDA,K=[] select_best_parameter.sh
    
    qsub -N best_fold_$i -t 1-9 -v FILE=fold,FOLD=$i,METHOD=PCA,K=[] select_best_parameter.sh
    qsub -N best_sqrt_fold_$i -t 1-9 -v FILE=sqrt_fold,FOLD=$i,METHOD=PCA,K=[] select_best_parameter.sh
done

