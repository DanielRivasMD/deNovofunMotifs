#!/bin/bash -l
#SBATCH -A snic2022-5-189
#SBATCH -p node
#SBATCH -n 1
#SBATCH -t 10:00:00
#SBATCH -J merge
#SBATCH -C mem512GB
#SBATCH -M snowy
#SBATCH --mail-type=ALL
#SBATCH --mail-user manel.mateos-i-font.9758@student.uu.se

module load bioinfo-tools
module load BEDTools/2.29.2

cd "/crex/proj/snic2020-16-187/nobackup/funMotifs_analysis/Siqi_files/results-ds-project-manel/extend_motifs/"

ls ./*.extended.sorted | xargs -i -P 4 bash -c "bedtools merge -i {} > {}.merged"
