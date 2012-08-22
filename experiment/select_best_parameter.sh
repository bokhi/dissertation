#!/bin/bash
cd ~/dissertation/experiment

matlab -nodisplay -nodesktop -nosplash -nojvm -r "select_best_parameter('$FILE',$FOLD,$SGE_TASK_ID,'$METHOD',$K);quit"



