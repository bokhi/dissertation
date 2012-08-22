#!/bin/bash
cd ~/dissertation/experiment

qsub -N pca_LDA -t $1-$2 -v FILE=view1,METHOD=LDA,K=[] pca_experiment.sh
qsub -N pca_Isomap -t $1-$2 -v FILE=view1,METHOD=Isomap,K=107 pca_experiment.sh
qsub -N pca_LLE -t $1-$2 -v FILE=view1,METHOD=LLE,K=136 pca_experiment.sh

qsub -N sqrt_pca_LDA -t $1-$2 -v FILE=sqrt_view1,METHOD=LDA,K=[] pca_experiment.sh
qsub -N sqrt_pca_Isomap -t $1-$2 -v FILE=sqrt_view1,METHOD=Isomap,K=93 pca_experiment.sh
qsub -N sqrt_pca_LLE -t $1-$2 -v FILE=sqrt_view1,METHOD=LLE,K=78 pca_experiment.sh


