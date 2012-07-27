#!/bin/bash
#$ -m be -M mrpb201@ex.ac.uk

reduction[1]='PCA'
reduction[2]='Isomap'
reduction[3]='LLE'
reduction[4]='Laplacian'

cd ~/dissertation/experiment

octave --silent --eval "dimension_reduction ('view1.bin', '${reduction[${SGE_TASK_ID}]}', 300"