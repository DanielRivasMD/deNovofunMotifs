#!/bin/bash -l
#SBATCH -A snic2022-5-189
#SBATCH -p node
#SBATCH -n 1
#SBATCH -t 10:00:00
#SBATCH -J extend_motifs
#SBATCH -C mem512GB
#SBATCH -M snowy
#SBATCH --mail-type=ALL
#SBATCH --mail-user manel.mateos-i-font.9758@student.uu.se

module load python

cd "/crex/proj/snic2020-16-187/nobackup/funMotifs_analysis/Siqi_files/results-ds-project-manel/extend_motifs/"

ls ../../raw_data_link/motif_per_chain/* | xargs -i -P 16 bash -c "python /home/mama9758/private/deNovofunMotifs/src/extend_motifs_test_apply.py {} {}.extended"

