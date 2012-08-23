#!/bin/bash
cd ~/dissertation/experiment

qsub -N PCA -v FILE=view1,TECHNIQUE=PCA,DIMENSION=3456,PARAMETER=[] dimension_reduction.sh
qsub -N sqrt_PCA -v FILE=sqrt_view1,TECHNIQUE=PCA,DIMENSION=3456,PARAMETER=[] dimension_reduction.sh

qsub -N pca_LDA -hold_jid PCA -t $1-$2 -v FILE=PCA_view1,METHOD=LDA,K=[] pca_experiment.sh
qsub -N pca_Isomap -hold_jid PCA -t $1-$2 -v FILE=PCA_view1,METHOD=Isomap,K=107 pca_experiment.sh
qsub -N pca_LLE -hold_jid PCA -t $1-$2 -v FILE=PCA_view1,METHOD=LLE,K=136 pca_experiment.sh

qsub -N sqrt_pca_LDA -hold_jid sqrt_PCA -t $1-$2 -v FILE=PCA_sqrt_view1,METHOD=LDA,K=[] pca_experiment.sh
qsub -N sqrt_pca_Isomap -hold_jid sqrt_PCA -t $1-$2 -v FILE=PCA_sqrt_view1,METHOD=Isomap,K=93 pca_experiment.sh
qsub -N sqrt_pca_LLE -hold_jid sqrt_PCA -t $1-$2 -v FILE=PCA_sqrt_view1,METHOD=LLE,K=78 pca_experiment.sh


