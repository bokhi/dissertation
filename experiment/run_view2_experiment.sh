#!/bin/bash
cd ~/dissertation/experiment

asub -N extract_fold run-matlab.sh "extract_fold();quit"

qsub -N view2_LDA -hold_jid extract_fold -t 1-10 -v METHOD=LDA view2_experiment.sh
qsub -N view2_Isomap -hold_jid extract_fold -t 1-10 -v METHOD=Isomap view2_experiment.sh
qsub -N view2_LLE -hold_jid extract_fold -t 1-10 -v METHOD=LLE view2_experiment.sh

qsub -N performance_LDA -hold_jid view2_LDA run-matlab.sh "view2_performance('LDA');quit"
qsub -N performance_Isomap -hold_jid view2_Isomap run-matlab.sh "view2_performance('Isomap');quit"
qsub -N performance_LLE -hold_jid view2_LDA run-matlab.sh "view2_performance('LLE');quit"