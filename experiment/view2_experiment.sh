#!/bin/bash
cd ~/dissertation/experiment

matlab -nodisplay -nodesktop -nosplash -nojvm -r "view2_experiment('$FILE','$METHOD',$SGE_TASK_ID);quit"



