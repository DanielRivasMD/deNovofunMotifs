#!/bin/bash -l
#SBATCH -A snic2022-5-189
#SBATCH -p node
#SBATCH -n 1
#SBATCH -t 60:00:00
#SBATCH -J lisa-list
#SBATCH -M snowy
#SBATCH --mail-type=ALL
#SBATCH --mail-user manel.mateos-i-font.9758@student.uu.se

export R_LIBS_USER=/proj/snic2022-5-189/R_packages
module load R/4.2.1

echo "SLURM_JOBID="$SLURM_JOBID
echo "working directory = "$SLURM_SUBMIT_DIR


cd "/crex/proj/snic2020-16-187/nobackup/funMotifs_analysis/Siqi_files/results-ds-project-manel/new_clean_chrs_left"

ls head.fa | xargs -t -I % sh -c "Rscript /domus/h1/mama9758/private/deNovofunMotifs/src/homer-test/lisa_l.R % /crex/proj/snic2020-16-187/nobackup/funMotifs_analysis/Siqi_files/results-ds-project-manel/lisa_results/%.txt"

