#!/bin/bash -l
#SBATCH -A snic2022-5-189
#SBATCH -p node
#SBATCH -n 1
#SBATCH -t 10:00:00
#SBATCH -J extend_motifs
#SBATCH -C mem512GB
#SBATCH -M snowy
#SBATCH --mail-type=ALL
#SBATCH --mail-user siqi.li.2084@student.uu.se

module load python

cd "/crex/proj/snic2020-16-187/nobackup/funMotifs_analysis/Siqi_files/result/introduce_mutation/"

ls ../get_extended_fasta/* | xargs -i -P 16 bash -c "python ../../code/mutate_motifs2.0.py {} ../../raw_data/observed_agreement_22May2017_hg38_sorted.bed9 ./{}.mutated"
