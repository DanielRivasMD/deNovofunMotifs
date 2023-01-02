#!/bin/bash -l
#SBATCH -A snic2022-5-189
#SBATCH -p node
#SBATCH -n 1
#SBATCH -t 20:00:00
#SBATCH -J filter_fimo
#SBATCH -M snowy
#SBATCH --mail-type=ALL
#SBATCH --mail-user manel.mateos-i-font.9758@student.uu.se

module load python

data_dir=/crex/proj/snic2020-16-187/nobackup/funMotifs_analysis/Siqi_files/results-ds-project-manel/lisa_results

for i in chr21 chr1

do

echo "processing $i"

cd $data_dir/$i

ls *.uniq | xargs -i -P 16 bash -c "python /home/mama9758/private/deNovofunMotifs/src/filtering_bed_result.py '{}' '{}.filtered'"

cat *.filtered > $data_dir/$i.filtered.bed

break

done
