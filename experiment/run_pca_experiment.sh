#!/bin/bash
cd ~/dissertation/experiment

qsub -N pca_LDA -t $1-$2 -v FILE=$1,METHOD=LDA,K=[] pca_experiment.sh
qsub -N pca_Isomap -t $1-$2 -v FILE=$2,METHOD=Isomap,K=22 pca_experiment.sh
qsub -N pca_LLE -t $1-$2 -v FILE=$1,METHOD=LLE,K=17 pca_experiment.sh

qsub -N LDA_PLOT -hold_jid pca_LDA run-matlab.sh "plot_pca_experiment('pca_LDA_$1');quit"
qsub -N Isomap_PLOT -hold_jid pca_Isomap run-matlab.sh "plot_pca_experiment('pca_Isomap_$1');quit"
qsub -N LLE_PLOT -hold_jid pca_LLE run-matlab.sh "plot_pca_experiment('pca_LLE_$1');quit"

