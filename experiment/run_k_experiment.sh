#!/bin/bash 
cd ~/dissertation/experiment

qsub -N k_Isomap -t $1-$2 -v METHOD=Isomap,DIM=150 k_experiment.sh 
qsub -N k_LLE -t $1-$2 -v METHOD=LLE,DIM=150 k_experiment.sh 

qsub -N Isomap_PLOT -hold_jid k_Isomap run-matlab.sh "plot_k_experiment('Isomap');quit"
qsub -N LLE_PLOT -hold_jid k_LLE run-matlab.sh "plot_k_experiment('LLE');quit"

