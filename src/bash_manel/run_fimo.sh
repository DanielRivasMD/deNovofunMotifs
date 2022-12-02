#!/bin/bash -l
#SBATCH -A snic2022-5-189
#SBATCH -p node
#SBATCH -n 1
#SBATCH -t 60:00:00
#SBATCH -J run_fimo
#SBATCH -M snowy
#SBATCH --mail-type=ALL
#SBATCH --mail-user manel.mateos-i-font.9758@student.uu.se

module load python
module load bioinfo-tools
module load MEMEsuite

fasta_dir=/crex/proj/snic2020-16-187/nobackup/funMotifs_analysis/Siqi_files/results-ds-project-manel/introduce_mutation

res_dir=/crex/proj/snic2020-16-187/nobackup/funMotifs_analysis/Siqi_files/results-ds-project-manel/find_new_motifs

for i in chr10 chr1

do

echo "processing $i"

mkdir $res_dir/$i

out_dir=$res_dir/$i

python "/crex/proj/snic2020-16-187/nobackup/funMotifs_analysis/Siqi_files/result/find_new_motifs/GenerateMotifsFIMO.py" --jaspar_meme_pwms_input_file "/crex/proj/snic2020-16-187/nobackup/funMotifs_analysis/Siqi_files/result/find_new_motifs/JASPAR2020_CORE_vertebrates_non-redundant_pfms_meme.txt" --genome_fasta_file $fasta_dir/$i.bed.extended.sorted.merged.corrected.extended_motifs.fa.mutated --output_dir $out_dir --pval_threshold 0.0001 --limit_to_check 1 --scores_sd_above_mean 1.0 --percentage_highest_scored_isntances 10 --number_processes_to_run 16

break

done
