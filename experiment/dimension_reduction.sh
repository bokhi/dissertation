#!/bin/bash
cd ~/dissertation/experiment

matlab -nodisplay -nodesktop -nosplash -nojvm -r "f_dimension_reduction ('$FILE','$TECHNIQUE',$DIMENSION,$PARAMETER);quit"



