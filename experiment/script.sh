#!/bin/bash
#$ -m be -M mrpb201@ex.ac.uk

cd ~/dissertation/experiment

#octave --eval "sge_experiment ($SGE_TASK_ID)"
matlab -nodisplay -nodesktop -nosplash -nojvm -r "sge_experiment ($SGE_TASK_ID)"

