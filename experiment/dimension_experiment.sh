#!/bin/bash
cd ~/dissertation/experiment



qsub -N PCA -v FILE=view1.mat,TECHNIQUE=PCA,DIMENSION=3456,PARAMETER=[] reduction.sh
qsub -N LDA -v FILE=view1.mat,TECHNIQUE=LDA,DIMENSION=3456,PARAMETER=[] reduction.sh
qsub -N Isomap -v FILE=view1.mat,TECHNIQUE=Isomap,DIMENSION=3456,PARAMETER=53 reduction.sh
qsub -N LLE -v FILE=view1.mat,TECHNIQUE=LLE,DIMENSION=3456,PARAMETER=137 reduction.sh

qsub -hold_jid PCA -t 1:1000:50 -v FILE='PCA_view1.mat',NB_DIM=50 acc.sh
qsub -hold_jid LDA -t 1:1000:50 -v FILE='LDA_view1.mat',NB_DIM=50 acc.sh
qsub -hold_jid Isomap -t 1:1000:50 -v FILE='Isomap_view1.mat',NB_DIM=50 acc.sh
qsub -hold_jid LLE -t 1:1000:50 -v FILE='LLE_view1.mat',NB_DIM=50 acc.sh

