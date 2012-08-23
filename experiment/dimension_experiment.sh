#!/bin/bash
cd ~/dissertation/experiment

DIM=$1

qsub -N PCA -v FILE=view1,TECHNIQUE=PCA,DIMENSION=$DIM,PARAMETER=[] dimension_reduction.sh
qsub -N LDA -v FILE=view1,TECHNIQUE=LDA,DIMENSION=$DIM,PARAMETER=[] dimension_reduction.sh
qsub -N Isomap -v FILE=view1,TECHNIQUE=Isomap,DIMENSION=$DIM,PARAMETER=107 dimension_reduction.sh
qsub -N LLE -v FILE=view1,TECHNIQUE=LLE,DIMENSION=$DIM,PARAMETER=136 dimension_reduction.sh

qsub -N sqrt_PCA -v FILE=sqrt_view1,TECHNIQUE=PCA,DIMENSION=$DIM,PARAMETER=[] dimension_reduction.sh
qsub -N sqrt_LDA -v FILE=sqrt_view1,TECHNIQUE=LDA,DIMENSION=$DIM,PARAMETER=[] dimension_reduction.sh
qsub -N sqrt_Isomap -v FILE=sqrt_view1,TECHNIQUE=Isomap,DIMENSION=$DIM,PARAMETER=93 dimension_reduction.sh
qsub -N sqrt_LLE -v FILE=sqrt_view1,TECHNIQUE=LLE,DIMENSION=$DIM,PARAMETER=78 dimension_reduction.sh

qsub -N ACC_PCA -hold_jid PCA -t 1-$DIM:50 -v FILE=PCA_view1,NB_DIM=50 accuracy.sh
qsub -N ACC_LDA -hold_jid LDA -t 1-$DIM:50 -v FILE=LDA_view1,NB_DIM=50 accuracy.sh
qsub -N ACC_Isomap -hold_jid Isomap -t 1-$DIM:50 -v FILE=Isomap_view1,NB_DIM=50 accuracy.sh
qsub -N ACC_LLE -hold_jid LLE -t 1-$DIM:50 -v FILE=LLE_view1,NB_DIM=50 accuracy.sh
qsub -N ACC_SIFT -t 1:$DIM:50 -v FILE=view1,NB_DIM=50 accuracy.sh

qsub -N ACC_PCA -hold_jid sqrt_PCA -t 1-$DIM:50 -v FILE=PCA_sqrt_view1,NB_DIM=50 accuracy.sh
qsub -N ACC_LDA -hold_jid sqrt_LDA -t 1-$DIM:50 -v FILE=LDA_sqrt_view1,NB_DIM=50 accuracy.sh
qsub -N ACC_Isomap -hold_jid sqrt_Isomap -t 1-$DIM:50 -v FILE=Isomap_sqrt_view1,NB_DIM=50 accuracy.sh
qsub -N ACC_LLE -hold_jid sqrt_LLE -t 1-$DIM:50 -v FILE=LLE_sqrt_view1,NB_DIM=50 accuracy.sh
qsub -N ACC_SIFT -t 1-$DIM:50 -v FILE=sqrt_view1,NB_DIM=50 accuracy.sh




