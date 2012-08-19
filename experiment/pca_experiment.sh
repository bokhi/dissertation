#!/bin/bash
cd ~/dissertation/experiment

matlab -nodisplay -nodesktop -nosplash -nojvm -r "pca_experiment('$FILE','$METHOD',$SGE_TASK_ID,$K);quit"



