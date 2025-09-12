#!/bin/bash
#SBATCH --account=def-guanuofa
#SBATCH --gpus-per-node=a100:1
#SBATCH --mem=128G
#SBATCH --time=7-0
#SBATCH --job-name=transformer-step-2
#SBATCH --output=transformer_step_2_%j.out
#SBATCH --err=transformer_step_2_%j.err


module load python/3.11
module load scipy-stack
module load gcc arrow/19.0.1


cd /home/schen123/projects/def-guanuofa/schen123/kinases/virtual_environments
source TEST/bin/activate


cd ../sbc806/LucaPCycle/src/training/V3
cat ./transformer_step_2.sh > /home/schen123/projects/def-guanuofa/schen123/kinases/bash_scripts/step_2/transformer/transformer_step_2_$SLURM_JOB_ID.txt
./transformer_step_2.sh


deactivate
