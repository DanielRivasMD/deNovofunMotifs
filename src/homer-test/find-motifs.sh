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

echo "SLURM_JOBID="$SLURM_JOBID
echo "working directory = "$SLURM_SUBMIT_DIR

findMotifs.pl data/head.fa fasta data/result_dir_head/ -find data/JASPAR-v2.motif -p 6 > out.txt

