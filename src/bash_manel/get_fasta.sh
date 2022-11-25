#!/bin/bash -l
#SBATCH -A snic2022-5-189
#SBATCH -p node
#SBATCH -n 1
#SBATCH -t 10:00:00
#SBATCH -J get_fasta
#SBATCH -C mem512GB
#SBATCH -M snowy
#SBATCH --mail-type=ALL
#SBATCH --mail-user manel.mateos-i-font.9758@student.uu.se

module load bioinfo-tools
module load BEDTools/2.29.2

cd "/crex/proj/snic2020-16-187/nobackup/funMotifs_analysis/Siqi_files/results-ds-project-manel/extend_motifs/"

ls *corrected | xargs -i -P 16 bash -c "bedtools getfasta -fi /crex/proj/snic2020-16-187/nobackup/funMotifs_analysis/funMotifs_datafiles/additional_files/hg38.fa -bed {} -fo {}.extended_motifs.fa"
