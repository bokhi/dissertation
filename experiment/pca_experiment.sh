#!/bin/bash
cd ~/dissertation/experiment

qsub -N pca_LDA -t $1-$2 run-matlab.sh "pca_experiment('LDA', $SGE_TASK_ID, []);quit"
qsub -N pca_Isomap -t $1-$2 run-matlab.sh "pca_experiment('Isomap', $SGE_TASK_ID, 23);quit"
qsub -N pca_LLE -t $1-$2 run-matlab.sh "pca_experiment('LLE', $SGE_TASK_ID, 23);quit"

qsub -N LDA_PLOT -hold_jid pca_LDA run-matlab.sh "plot_pca_experiment ('LDA');quit"
qsub -N Isomap_PLOT -hold_jid pca_Isomap run-matlab.sh "plot_pca_experiment ('Isomap');quit"
qsub -N LLE_PLOT -hold_jid pca_LLE run-matlab.sh "plot_pca_experiment ('LLE');quit"

