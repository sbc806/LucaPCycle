#!/bin/bash
#SBATCH --account=def-guanuofa
#SBATCH --gpus-per-node=a100:1
#SBATCH --mem=256G
#SBATCH --time=7-0
#SBATCH --job-name=esm-step-3
#SBATCH --output=esm_step_3_%j.out
#SBATCH --err=esm_step_3_%j.err


module load python/3.11
module load scipy-stack
module load gcc arrow/19.0.1


cd /home/schen123/projects/def-guanuofa/schen123/kinases/virtual_environments
source TEST/bin/activate


cd ../sbc806/LucaPCycle/src/training/V3
cat esm_step_3.sh > /home/schen123/projects/def-guanuofa/schen123/kinases/bash_scripts/step_3/esm/esm_step_3_$SLURM_JOB_ID.txt
./esm_step_3.sh


deactivate
