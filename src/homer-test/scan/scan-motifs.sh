#!/bin/bash -l
#SBATCH -A snic2022-5-189
#SBATCH -p node
#SBATCH -n 1
#SBATCH -t 60:00:00
#SBATCH -J scan-motifs
#SBATCH -M snowy
#SBATCH --mail-type=ALL
#SBATCH --mail-user manel.mateos-i-font.9758@student.uu.se

module load python
module load bioinfo-tools
module load HOMER

echo "SLURM_JOBID="$SLURM_JOBID
echo "working directory = "$SLURM_SUBMIT_DIR

scanMotifGenomeWide.pl ../data/JASPAR-v2.motif ../data/chr22.fa -bed -p 6 > out.bed

