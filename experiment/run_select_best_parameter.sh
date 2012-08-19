#!/bin/bash
cd ~/dissertation/experiment

qsub -N best_fold_$1 -t 1-9 -v FOLD=$1,METHOD=LDA,K=[] select_best_parameter.sh

