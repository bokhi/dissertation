#!/bin/bash

cd ~/dissertation/experiment

#octave --eval "sge_experiment ($SGE_TASK_ID)"
matlab -nodisplay -nodesktop -nosplash -nojvm -r "sge_experiment ($SGE_TASK_ID)"

