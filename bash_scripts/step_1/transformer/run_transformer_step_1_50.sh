#!/bin/bash
#SBATCH --account=def-guanuofa
#SBATCH --gpus-per-node=a100:1
#SBATCH --mem=32G
#SBATCH --time=7-0
#SBATCH --job-name=transformer-step-1-50
#SBATCH --output=transformer_step_1_50_%j.out
#SBATCH --err=transformer_step_1_50_%j.err


module load python/3.11
module load scipy-stack
module load gcc arrow/19.0.1


cd /home/schen123/projects/def-guanuofa/schen123/kinases/virtual_environments
source TEST/bin/activate


cd ../sbc806/LucaPCycle/src/training/V3
cat transformer_step_1_50.sh > /home/schen123/projects/def-guanuofa/schen123/kinases/bash_scripts/step_1/transformer/transformer_step_1_50_$SLURM_JOB_ID.txt
./transformer_step_1_50.sh


deactivate
