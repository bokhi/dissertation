#!/bin/bash
#$ -m be -M mrpb201@ex.ac.uk

reduction[1]='PCA'
reduction[2]='Isomap'
reduction[3]='LLE'
reduction[4]='Laplacian'
reduction[6]='Isomap'
reduction[7]='LLE'
reduction[8]='Laplacian'


cd ~/dissertation/experiment

if (( $SGE_TASK_ID < 5 )); then
    octave --eval "dimension_reduction ('view1.bin', '${reduction[${SGE_TASK_ID}]}', 300)" 
elif (( $SGE_TASK_ID == 5 )); then
    octave --eval "accuracy ('PCA-300_view1.bin')" 
elif ((  $SGE_TASK_ID < 9 )); then
    octave --eval "dimension_reduction ('PCA-300_view1.bin', '${reduction[${SGE_TASK_ID}]}', 200)" 
fi
    
    

#matlab -nodisplay -nodesktop -nosplash -nojvm -r "dimension_reduction ('view1.bin', '${reduction[${SGE_TASK_ID}]}', 300)" > ${reduction[${SGE_TASK_ID}]}.log

