#!/bin/bash
#SBATCH --account=rrg-guanuofa
#SBATCH --gpus-per-node=h100:1
#SBATCH --mem=128G
#SBATCH --time=7-0
#SBATCH --job-name=esm-step-3
#SBATCH --output=output/esm_step_3_%j.out
#SBATCH --err=output/esm_step_3_%j.err


module load python/3.11
module load scipy-stack
module load gcc arrow/21.0.0


cd /home/schen123/projects/rrg-guanuofa/schen123/kinases/virtual_environments
source TEST/bin/activate


cd ../sbc806/RumHKNet/src/training/V3
cat esm_step_3.sh > /home/schen123/projects/rrg-guanuofa/schen123/kinases/sbc806/RumHKNet/bash_scripts_nibi/step_3/esm/output/esm_step_3_$SLURM_JOB_ID.txt
./esm_step_3.sh


deactivate
