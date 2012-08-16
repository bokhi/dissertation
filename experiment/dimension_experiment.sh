#!/bin/bash
cd ~/dissertation/experiment

DIM=$1

qsub -N PCA -v FILE=view1.mat,TECHNIQUE=PCA,DIMENSION=$DIM,PARAMETER=[] dimension_reduction.sh
qsub -N LDA -v FILE=view1.mat,TECHNIQUE=LDA,DIMENSION=$DIM,PARAMETER=[] dimension_reduction.sh
qsub -N Isomap -v FILE=view1.mat,TECHNIQUE=Isomap,DIMENSION=$DIM,PARAMETER=22 dimension_reduction.sh
qsub -N LLE -v FILE=view1.mat,TECHNIQUE=LLE,DIMENSION=$DIM,PARAMETER=23 dimension_reduction.sh

qsub -N ACC_PCA -hold_jid PCA -t 1:$DIM:50 -v FILE='PCA_view1.mat',NB_DIM=50 accuracy.sh
qsub -N ACC_LDA -hold_jid LDA -t 1:$DIM:50 -v FILE='LDA_view1.mat',NB_DIM=50 accuracy.sh
qsub -N ACC_Isomap -hold_jid Isomap -t 1:$DIM:50 -v FILE='Isomap_view1.mat',NB_DIM=50 accuracy.sh
qsub -N ACC_LLE -hold_jid LLE -t 1:$DIM:50 -v FILE='LLE_view1.mat',NB_DIM=50 accuracy.sh
qsub -N ACC_SIFT -t 1:$DIM:50 -v FILE='view1.mat',NB_DIM=50 accuracy.sh

qsub -N PLOT -hold_jid ACC_PCA,ACC_LDA,ACC_Isomap,ACC_LLE,ACC_SIFT run-matlab.sh "plot_dimension_experiment();quit"



