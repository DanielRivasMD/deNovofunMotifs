#!/bin/bash -l
#SBATCH -A snic2022-5-189
#SBATCH -p node
#SBATCH -n 1
#SBATCH -t 01:00:00
#SBATCH -J unique_list
#SBATCH -M snowy
#SBATCH --mail-type=ALL
#SBATCH --mail-user manel.mateos-i-font.9758@student.uu.se

module load bioinfo-tools
module load SeqKit

echo "SLURM_JOBID="$SLURM_JOBID
echo "working directory = "$SLURM_SUBMIT_DIR

cd "/crex/proj/snic2020-16-187/nobackup/funMotifs_analysis/Siqi_files/result/introduce_mutation/results4"

ls . | xargs -t -I % sh -c "seqkit rmdup -s < %  > /crex/proj/snic2020-16-187/nobackup/funMotifs_analysis/Siqi_files/results-ds-project-manel/new_clean_chrs/%.uniq"


