#!/bin/bash -l
#SBATCH -A snic2022-5-189
#SBATCH -p node
#SBATCH -n 1
#SBATCH -t 60:00:00
#SBATCH -J homer-test
#SBATCH -M snowy
#SBATCH --mail-type=ALL
#SBATCH --mail-user manel.mateos-i-font.9758@student.uu.se

module load python
module load bioinfo-tools
module load HOMER

#homer2 denovo -i chr10_mutated.fa -b JASPAR2022_CORE_non-redundant_pfms_meme.txt > out.txt
findMotifs.pl data/chr10_mutated_siqi.fa human data/analysis_output/ -fasta data/JASPAR2022_CORE_non-redundant_pfms_meme.txt

