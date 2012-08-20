#!/bin/bash
cd ~/dissertation/experiment

qsub -N estimate_$1 run-matlab.sh "estimate_dimension('view1',$1)"
