#!/bin/bash
cd ~/dissertation/experiment

qsub -N pca_LDA -t $1-$2 matlab-run.sh "pca_experiment('LDA', $SGE_TASK_ID, []);quit"
qsub -N pca_Isomap -t $1-$2 matlab-run.sh "pca_experiment('Isomap', $SGE_TASK_ID, 23);quit"
qsub -N pca_LLE -t $1-$2 matlab-run.sh "pca_experiment('LLE', $SGE_TASK_ID, 23);quit"

qsub -N LDA_PLOT -hold_jid pca_LDA matlab-run.sh "plot_pca_experiment ('LDA');quit"
qsub -N Isomap_PLOT -hold_jid pca_Isomap matlab-run.sh "plot_pca_experiment ('Isomap');quit"
qsub -N LLE_PLOT -hold_jid pca_LLE matlab-run.sh "plot_pca_experiment ('LLE');quit"

