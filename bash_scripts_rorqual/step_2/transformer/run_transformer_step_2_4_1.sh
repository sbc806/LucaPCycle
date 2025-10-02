#!/bin/bash
#SBATCH --account=def-guanuofa
#SBATCH --gpus-per-node=h100_3g.40gb:1
#SBATCH --mem=32G
#SBATCH --time=4-0
#SBATCH --job-name=transformer-step-2-4-1
#SBATCH --output=output/transformer_step_2_4_1_%j.out
#SBATCH --err=output/transformer_step_2_4_1_%j.err


module load python/3.11
module load scipy-stack
module load gcc arrow/19.0.1


cd /home/schen123/links/projects/def-guanuofa/schen123/kinases/virtual_environments
source TEST/bin/activate


cd ../sbc806_1/RumHKNet/src/training/V3
cat ./transformer_step_2_4_1.sh > /home/schen123/links/projects/def-guanuofa/schen123/kinases/sbc806_1/RumHKNet/bash_scripts_narval/step_2/transformer/output/transformer_step_2_4_1_$SLURM_JOB_ID.txt
./transformer_step_2_4_1.sh


deactivate
