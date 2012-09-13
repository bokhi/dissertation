#!/bin/bash
cd ~/dissertation/experiment

qsub -N extract_fold run-matlab.sh "extract_fold();quit"

#qsub -N view2_SIFT -hold_jid extract_fold -t 1-10 -v FILE=fold,METHOD=SIFT view2_experiment.sh
qsub -N view2_PCA -hold_jid extract_fold -t 1-10 -v FILE=fold,METHOD=PCA view2_experiment.sh
qsub -N view2_LDA -hold_jid extract_fold -t 1-10 -v FILE=fold,METHOD=LDA view2_experiment.sh
#qsub -N view2_Isomap -hold_jid extract_fold -t 1-10 -v FILE=fold,METHOD=Isomap view2_experiment.sh
#qsub -N view2_LLE -hold_jid extract_fold -t 1-10 -v FILE=fold,METHOD=LLE view2_experiment.sh

# qsub -N sqrt_view2_SIFT -hold_jid extract_fold -t 1-10 -v FILE=sqrt_fold,METHOD=SIFT view2_experiment.sh
qsub -N sqrt_view2_PCA -hold_jid extract_fold -t 1-10 -v FILE=sqrt_fold,METHOD=PCA view2_experiment.sh
qsub -N sqrt_view2_LDA -hold_jid extract_fold -t 1-10 -v FILE=sqrt_fold,METHOD=LDA view2_experiment.sh
# qsub -N sqrt_view2_Isomap -hold_jid extract_fold -t 1-10 -v FILE=sqrt_fold,METHOD=Isomap view2_experiment.sh
# qsub -N sqrt_view2_LLE -hold_jid extract_fold -t 1-10 -v FILE=sqrt_fold,METHOD=LLE view2_experiment.sh

#qsub -N performance_SIFT -hold_jid view2_SIFT run-matlab.sh "view2_performance('fold','SIFT');quit"
qsub -N performance_PCA -hold_jid view2_PCA run-matlab.sh "view2_performance('fold','PCA');quit"
qsub -N performance_LDA -hold_jid view2_LDA run-matlab.sh "view2_performance('fold','LDA');quit"
# qsub -N performance_Isomap -hold_jid view2_Isomap run-matlab.sh "view2_performance('fold','Isomap');quit"
# qsub -N performance_LLE -hold_jid view2_LLE run-matlab.sh "view2_performance('fold','LLE');quit"

# qsub -N sqrt_performance_SIFT -hold_jid sqrt_view2_SIFT run-matlab.sh "view2_performance('sqrt_fold','SIFT');quit"
qsub -N sqrt_performance_PCA -hold_jid sqrt_view2_PCA run-matlab.sh "view2_performance('sqrt_fold','PCA');quit"
qsub -N sqrt_performance_LDA -hold_jid sqrt_view2_LDA run-matlab.sh "view2_performance('sqrt_fold','LDA');quit"
# qsub -N sqrt_performance_Isomap -hold_jid sqrt_view2_Isomap run-matlab.sh "view2_performance('sqrt_fold','Isomap');quit"
# qsub -N sqrt_performance_LLE -hold_jid sqrt_view2_LLE run-matlab.sh "view2_performance('sqrt_fold','LLE');quit"
