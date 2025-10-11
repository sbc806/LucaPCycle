#!/bin/bash
#SBATCH --account=rrg-guanuofa
#SBATCH --gpus-per-node=h100:1
#SBATCH --mem=32G
#SBATCH --time=4-0
#SBATCH --job-name=transformer-step-2-4-1
#SBATCH --output=output/transformer_step_2_4_1_%j.out
#SBATCH --er=output/transformer_step_2_4_1_%j.err


module load python/3.11
module load scipy-stack
module load gcc arrow/21.0.0

cd /home/schen123/projects/rrg-guanuofa/schen123/kinases/virtual_environments
source TEST/bin/activate


cd ../sbc806/RumHKNet/src/training/V3
cat transformer_step_2_4_1.sh > /home/schen123/projects/rrg-guanuofa/schen123/kinases/sbc806/RumHKNet/bash_scripts_nibi/step_2/transformer/output/transformer_setp_2_4_1_$SLURM_JOB_ID.sh
./transformer_step_2_4_1.sh


deactivate
