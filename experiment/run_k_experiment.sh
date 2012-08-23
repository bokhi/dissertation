#!/bin/bash 
cd ~/dissertation/experiment

qsub -N k_Isomap -t $1-$2 -v FILE=view1,METHOD=Isomap,DIM=150 k_experiment.sh 
qsub -N k_LLE -t $1-$2 -v FILE=view1,METHOD=LLE,DIM=150 k_experiment.sh 

qsub -N k_Isomap_sqrt -t $1-$2 -v FILE=sqrt_view1,METHOD=Isomap,DIM=150 k_experiment.sh 
qsub -N k_LLE_sqrt -t $1-$2 -v FILE=sqrt_view1,METHOD=LLE,DIM=150 k_experiment.sh 


