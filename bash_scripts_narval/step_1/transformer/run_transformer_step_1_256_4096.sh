#!/bin/bash
#SBATCH --account=def-guanuofa
#SBATCH --gpus-per-node=a100:1
#SBATCH --mem=32G
#SBATCH --time=7-0
#SBATCH --job-name=transformer-step-1-256-4096
#SBATCH --output=output/transformer_step_1_256_4096_%j.out
#SBATCH --err=output/transformer_step_1_256_4096_%j.err


module load python/3.11
module load scipy-stack
module load gcc arrow/19.0.1


cd /home/schen123/projects/def-guanuofa/schen123/kinases/virtual_environments
source TEST/bin/activate


cd ../sbc806/RumHKNet/src/training/V3
cat transformer_step_1_256_4096.sh > /home/schen123/projects/def-guanuofa/schen123/kinases/sbc806/RumHKNet/bash_scripts_narval/step_1/transformer/output/transformer_step_1_256_4096_$SLURM_JOB_ID.txt
./transformer_step_1_256_4096.sh


deactivate
