#!/bin/bash 
cd ~/dissertation/experiment

qsub -N k_Isomap -t $1-$2 matlab-run.sh "k_experiment('Isomap', 150, $SGE_TASK_ID);quit"
qsub -N k_LLE -t $1-$2 matlab-run.sh "k_experiment('LLE', 150, $SGE_TASK_ID);quit"

qsub -N Isomap_PLOT -hold_jid k_Isomap matlab-run.sh "plot_k_experiment ('Isomap');quit"
qsub -N LLE_PLOT -hold_jid k_LLE matlab-run.sh "plot_pcak_experiment ('LLE');quit"

