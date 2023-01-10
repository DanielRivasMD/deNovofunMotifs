#!/bin/bash -l
#SBATCH -A snic2022-5-189
#SBATCH -p node
#SBATCH -n 1
#SBATCH -t 01:00:00
#SBATCH -J filter_lisa
#SBATCH -M snowy
#SBATCH --mail-type=ALL
#SBATCH --mail-user manel.mateos-i-font.9758@student.uu.se

module load python

echo "SLURM_JOBID="$SLURM_JOBID
echo "working directory = "$SLURM_SUBMIT_DIR

cd "/crex/proj/snic2020-16-187/nobackup/funMotifs_analysis/Siqi_files/results-ds-project-manel/score_results"

ls *15.txt | xargs -t -I % sh -c "python /domus/h1/mama9758/private/deNovofunMotifs/src/homer-test/filter_lisa.py %  %.filtered"

