#!/bin/bash
cd ~/dissertation/experiment

matlab -nodisplay -nodesktop -nosplash -nojvm -r "k_experiment ('$METHOD', $SGE_TASK_ID, $K);quit"



