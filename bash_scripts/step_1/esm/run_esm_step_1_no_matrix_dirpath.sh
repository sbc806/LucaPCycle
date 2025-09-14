#!/bin/bash
#SBATCH --account=def-guanuofa
#SBATCH --gpus-per-node=h100:1
#SBATCH --mem=200G
#SBATCH --time=7-0
#SBATCH --job-name=esm-step-1-no-matrix-dirpath
#SBATCH --output=esm_step_1_no_matrix_dirpath_%j.out
#SBATCH --err=esm_step_1_no_matrix_dirpath_%j.err


module load python/3.11
module load scipy-stack
module load gcc arrow/19.0.1


cd /home/schen123/scratch/kinases/virtual_environments
source TEST/bin/activate


cd ../sbc806/RumHKNet/src/training/V3
cat esm_step_1_no_matrix_dirpath.sh > /home/schen123/scratch/kinases/bash_scripts/step_1/esm/esm_step_1_no_matrix_dirpath_$SLURM_JOB_ID.txt
./esm_step_1_no_matrix_dirpath.sh


deactivate
