#!/bin/bash
#SBATCH --account=rrg-guanuofa
#SBATCH --gpus=h100:1
#SBATCH --mem=128G
#SBATCH --time=7-0
#SBATCH --job-name=esm-step-3-inverse-no-matrix-dirpath
#SBATCH --output=output/esm_step_3_inverse_no_matrix_dirpath_%j.out
#SBATCH --err=output/esm_step_3_inverse_no_matrix_dirpath_%j.err


module load python/3.11
module load scipy-stack
module load gcc arrow/21.0.0


cd /home/schen123/projects/rrg-guanuofa/kinases/virtual_environments
source TEST/bin/activate


cd ../sbc806/RumHKNet/src/training/V3
cat esm_step_3_inverse_no_matrix_dirpath.sh > /home/schen123/projects/rrg-guanuofa/schen123/kinases/sbc806/RumHKNet/bash_scripts_nibi/step_3/esm/output/esm_step_3_inverse_no_matrix_dirpath_$SLURM_JOB_ID.txt
./esm_step_3_inverse_no_matrix_dirpath.sh


deactivate
