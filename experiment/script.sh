#!/bin/bash
#$ -m be -M mrpb201@ex.ac.uk

octave --eval "script (${SGE_TASK})"

#matlab -nodisplay -nodesktop -nosplash -nojvm -r "dimension_reduction ('view1.bin', '${reduction[${SGE_TASK_ID}]}', 300)" > ${reduction[${SGE_TASK_ID}]}.log

