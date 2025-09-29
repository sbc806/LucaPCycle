#!/bin/bash
#SBATCH --account=def-guanuofa
#SBATCH --gpus=nvidia_h100_80gb_hbm3_3g.40gb:1
#SBATCH --mem=128G
#SBATCH --time=7-0
#SBATCH --job-name=esm-step-3-1000-no-matrix-dirpath
#SBATCH --output=output/esm_step_3_1000_no_matrix_dirpath_%j.out
#SBATCH --err=output/esm_step_3_1000_no_matrix_dirpath_%j.err


module load python/3.11
module load scipy-stack
module load gcc arrow/19.0.1


cd /home/schen123/scratch/kinases/virtual_environments
source TEST/bin/activate


cd ../sbc806/RumHKNet/src/training/V3
cat esm_step_3_1000_no_matrix_dirpath.sh > /home/schen123/scratch/kinases/bash_scripts_fir/step_3/esm/output/esm_step_3_1000_no_matrix_dirpath_$SLURM_JOB_ID.txt
./esm_step_3_1000_no_matrix_dirpath.sh


deactivate
