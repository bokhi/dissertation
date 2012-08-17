#!/bin/bash
cd ~/dissertation/experiment

qsub -N pca_LDA -t $1-$2 -v METHOD=LDA,K=[] pca_experiment.sh
qsub -N pca_Isomap -t $1-$2 -v METHOD=Isomap,K=22 pca_experiment.sh
qsub -N pca_LLE -t $1-$2 -v METHOD=LLE,K=17 pca_experiment.sh

qsub -N LDA_PLOT -hold_jid pca_LDA run-matlab.sh "plot_pca_experiment('LDA');quit"
qsub -N Isomap_PLOT -hold_jid pca_Isomap run-matlab.sh "plot_pca_experiment('Isomap');quit"
qsub -N LLE_PLOT -hold_jid pca_LLE run-matlab.sh "plot_pca_experiment('LLE');quit"

