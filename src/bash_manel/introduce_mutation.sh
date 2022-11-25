#!/bin/bash -l
#SBATCH -A snic2022-5-189
#SBATCH -p node
#SBATCH -n 1
#SBATCH -t 20:00:00
#SBATCH -J introduce_mutation
#SBATCH -M snowy
#SBATCH --mail-type=ALL
#SBATCH --mail-user manel.mateos-i-font.9758@student.uu.se

module load python

for i in /crex/proj/snic2020-16-187/nobackup/funMotifs_analysis/Siqi_files/results-ds-project-manel/extend_motifs/*.fa

do

cd $SNIC_TMP

f=${i##*/}

echo "processing $f"

split -l 9000  -d -a 3 $i $f.splited

ls *.splited* | xargs -i -P 8 bash -c "python /crex/proj/snic2020-16-187/nobackup/funMotifs_analysis/Siqi_files/result/introduce_mutation/mutate_motifs_single_process2.1_UPPMAX.py {} /crex/proj/snic2020-16-187/nobackup/funMotifs_analysis/Siqi_files/raw_data/observed_agreement_22May2017_hg38_sorted.bed9 {}.mutated"

cat *.mutated > /crex/proj/snic2020-16-187/nobackup/funMotifs_analysis/Siqi_files/results-ds-project-manel/introduce_mutation/$f.mutated

rm  ./*

done
