#!/bin/bash
cd ~/dissertation/experiment

matlab -nodisplay -nodesktop -nosplash -nojvm -r "k_experiment ('$METHOD', $DIM, $SGE_TASK_ID);quit"



