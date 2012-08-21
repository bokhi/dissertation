#!/bin/bash
cd ~/dissertation/experiment

matlab -nodisplay -nodesktop -nosplash -nojvm -r "k_experiment('$FILE','$METHOD',$DIM,$SGE_TASK_ID);quit"



