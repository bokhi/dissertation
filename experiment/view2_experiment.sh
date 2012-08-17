#!/bin/bash
cd ~/dissertation/experiment

matlab -nodisplay -nodesktop -nosplash -nojvm -r "view2_experiment('$METHOD',$SGE_TASK_ID);quit"



