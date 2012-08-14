#!/bin/bash
cd ~/dissertation/experiment

matlab -nodisplay -nodesktop -nosplash -nojvm -r "f_accuracy ('$FILE', $SGE_TASK_ID, $NB_DIM);quit"

