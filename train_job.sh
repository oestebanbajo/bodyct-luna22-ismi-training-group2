#!/bin/bash
#SBATCH --partition=gpu
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=18
#SBATCH --gpus=1
#SBATCH --mem=64G
#SBATCH -t 1:00:00

module load 2021
module load SciPy-bundle/2021.05-foss-2021a
module load matplotlib/3.4.2-foss-2021a
module load TensorFlow/2.6.0-foss-2021a-CUDA-11.3.1
pip install --user SimpleITK

#Move the raw data to TMPDIR, save the preprocessed data in home, then copy the output from TMPDIR to home

#Move the raw training data to scratch
#mkdir "$TMPDIR"/input_obajo
#cp -r $HOME/bodyct-luna22-ismi-training-group2/LUNA22\ prequel "$TMPDIR"/input_obajo

#Create output directory on scratch
#mkdir "$TMPDIR"/output_obajo

#Execute program located in $HOME
python $HOME/bodyct-luna22-ismi-training-group2/train.py

#Copy output directory from scratch to home
#cp -r "$TMPDIR"/output_obajo $HOME/bodyct-luna22-ismi-training-group2/training_output
