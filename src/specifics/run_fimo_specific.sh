#!/bin/bash -l
#SBATCH -A snic2022-5-189
#SBATCH -p node
#SBATCH -n 1
#SBATCH -t 02:00:00
#SBATCH -J run_fimo_specific
#SBATCH -M snowy
#SBATCH --mail-type=ALL
#SBATCH --mail-user manel.mateos-i-font.9758@student.uu.se

module load python
module load bioinfo-tools
module load MEMEsuite

fasta_dir=/crex/proj/snic2020-16-187/nobackup/funMotifs_analysis/Siqi_files/results-ds-project-manel/specifics/introduce_mutation

res_dir=/crex/proj/snic2020-16-187/nobackup/funMotifs_analysis/Siqi_files/results-ds-project-manel/specifics/fimo

python "/crex/proj/snic2020-16-187/nobackup/funMotifs_analysis/Siqi_files/result/find_new_motifs/GenerateMotifsFIMO.py" --jaspar_meme_pwms_input_file "/crex/proj/snic2020-16-187/nobackup/funMotifs_analysis/Siqi_files/result/find_new_motifs/JASPAR2020_CORE_vertebrates_non-redundant_pfms_meme.txt" --genome_fasta_file $fasta_dir/chr21.extended_motifs.fa.mutated --output_dir $res_dir --pval_threshold 0.0001 --limit_to_check 1 --scores_sd_above_mean 1.0 --percentage_highest_scored_isntances 10 --number_processes_to_run 16

cd $res_dir

for j in ./*highestranked10.bed; do sort $j | uniq -u > $j.uniq; done

ls *.uniq | xargs -i -P 16 bash -c "python /domus/h1/mama9758/private/deNovofunMotifs/src/homer-test/filter_lisa.py '{}' '{}.filtered'"

#ls *.uniq | xargs -i -P 16 bash -c “python /crex/proj/snic2020-16-187/nobackup/funMotifs_analysis/Siqi_files/code/filtering_bed_result.py '{}' '{}.filtered'”

cat *.filtered > $res_dir/filtered_results/chr21.filtered.bed

