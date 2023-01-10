#!/bin/bash -l
#SBATCH -A snic2022-5-189
#SBATCH -p node
#SBATCH -n 1
#SBATCH -t 02:00:00
#SBATCH -J introduce_mutation_specific
#SBATCH -M snowy
#SBATCH --mail-type=ALL
#SBATCH --mail-user manel.mateos-i-font.9758@student.uu.se

module load python

cd $SNIC_TMP

i=/crex/proj/snic2020-16-187/nobackup/funMotifs_analysis/Siqi_files/results-ds-project-manel/specifics/chr21.extended_motifs.fa

f=chr21.extended_motifs.fa

split -l 9000  -d -a 3 $i $f.splited


ls *.splited* | xargs -i -P 8 bash -c "python /crex/proj/snic2020-16-187/nobackup/funMotifs_analysis/Siqi_files/result/introduce_mutation/mutate_motifs_single_process2.1_UPPMAX.py {} /crex/proj/snic2020-16-187/nobackup/funMotifs_analysis/Siqi_files/results-ds-project-manel/specifics/specific_mutations.bed9 {}.mutated"

cat *.mutated > /crex/proj/snic2020-16-187/nobackup/funMotifs_analysis/Siqi_files/results-ds-project-manel/specifics/introduce_mutation/$f.mutated

rm  ./*


