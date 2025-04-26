#!/bin/bash
#SBATCH --job-name=lbmExperiment
#SBATCH --partition=batch
#SBATCH --ntasks=8
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=8
#SBATCH --time=01:00:00
#SBATCH --output=lbm.out
#SBATCH --error=lbm.err
#SBATCH --export=ALL

cd $SLURM_SUBMIT_DIR

module load OpenMPI/5.0.3-GCC-13.3.0

rm -f lbmExperiment.txt lbm.err lbm.out

srun --mpi=pmix --nodes=8 --ntasks=8 ./lbmSimulation >> lbmExperiment.txt 2>&1