#!/bin/bash
#SBATCH --account=def-guanuofa
#SBATCH --gpus=nvidia_h100_80gb_hbm3_3g.40gb:1
#SBATCH --mem=32G
#SBATCH --time=7-0
#SBATCH --job-name=transformer-step-3-50
#SBATCH --output=transformer_step_3_50_%j.out
#SBATCH --err=transformer_step_3_50_%j.err


module load python/3.11
module load scipy-stack
module load gcc arrow/19.0.1


cd /home/schen123/scratch/kinases/virtual_environments
source TEST/bin/activate


cd ../sbc806/RumHKNet/src/training/V3
cat transformer_step_3_50.sh > /home/schen123/scratch/kinases/bash_scripts/step_3/transformer/transformer_step_3_50_$SLURM_JOB_ID.txt
./transformer_step_3_50.sh


deactivate
