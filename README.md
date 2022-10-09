Raw data:

pan-cancer mutation data in hg38 version:
 "/crex/proj/snic2020-16-187/nobackup/funMotifs_analysis/Siqi_files/raw_data/observed_agreement_22May2017_hg38_sorted.bed9"

original motifs data:
"/crex/proj/snic2020-16-187/nobackup/funMotifs_analysis/Siqi_files/raw_data_link/motif_per_chain/"

reference genome in hg38 version:
"/crex/proj/snic2020-16-187/nobackup/funMotifs_analysis/Siqi_files/raw_data_link/hg38.fa"

Workflow (to simplify this document, I will use relative path under : "/crex/proj/snic2020-16-187/nobackup/funMotifs_analysis/Siqi_files" )

1, Extend the coordinate of original motifs
Use python script: "./code/extend_motifs_test_apply.py"
usage: python extend_motifs_test_apply.py input.bed output.bed
OR Use bash script: "./result/extend_motifs/extend_motifs.sh"

2, Sort and merge the extended motifs
Motifs need to be sorted before merge, use “sort” command:
ls ./*.extended | xargs -i -P 4 bash -c “sort -k 2n {} > {}.sorted”
Use “merge” from bedtools (https://bedtools.readthedocs.io/en/latest/content/tools/merge.html?highlight=merge)
OR use my results in “./result/extend_motifs/*.bed.extended.sorted.merged”

3, Retrieve the fasta sequence of extended motifs
When extending the motifs, the coordinate of last motifs may exceed the actual length of that chromosome, which needed to be corrected:
python ./code/correct_ending_coordinate2.0.py in.fa chromosome_length.fa out.fa
OR use the result under ./result/check_correct_extended_motifs_coordinates/
Use getfasta from bedtools (https://bedtools.readthedocs.io/en/latest/content/tools/getfasta.html?highlight=get%20fasta)
Example command to run getfasta:
for i in ./*corrected
do
filename=” ${i##*/}”
bedtools getfasta -fi "/crex/proj/snic2020-16-187/nobackup/funMotifs_analysis/funMotifs_datafiles/additional_files/hg38.fa" -bed $i -fo "${filename%%.*}.extended_motifs.fa"
done
My results are under "./result/get_extended_fasta/"

4, Mutate original motifs
This is the most complex part, I changed my code a lot so this part looks messy.
I recommend running ./result/introduce_mutation/introduce_mutation_3.1.sh, this script will automatically do everything for you. The results are saved under "./result/introduce_mutation/results4/"
The basic idea of this bash script is it will loop through every chromosomes, for each chromosomes it will split the motifs bed files into many small files, for each of these files it will call ./result/introduce_mutation/mutate_motifs_single_process2.1_UPPMAX.py to mutate them and then merge all split results into one complete file.
If you like, you can also write your own bash script to run ./result/introduce_mutation/mutate_motifs_single_process2.1_UPPMAX.py
Usage: python mutate_motifs_single_process2.1_UPPMAX.py input.fa mutation_data.bed9 output.fa

5, Run FIMO to detect TF motifs in mutated sequences
You can use "./result/find_new_motifs/run_fimo1.1.1.sh" to run FIMO, change the for-loop in the bash script to modify the chromosome number according to your need. The results are sorted under “./result/find_new_motifs/all_chr_result_raw_2”. For each of the chromosomes there will be a separate folder, containing output for each TFs, files end with “highestranked10.bed” are the results we need from FIMO.

6, Filter FIMO results
There might be some repeats in the original output of FIMO, for example, same motifs predicted multiple times in nearby region, which needs to be removed.
Use filter_fimo_result1.1.1.sh or filter_fimo_result1.1.2.sh under “./result/find_new_motifs” to do this job. The two scripts are basically the same, just different in the chromosomes they process.

7, Classify the filtered motifs
Use "./result/find_new_motifs/classify_new_motifs/classify_overlap_motifs1.2.py" to classify the filtered motifs.
Usage:
Python classify_overlap_motifs1.2.py filtered_motifs.bed original_motifs.bed output1 output2 output3

Output1(*.overlap): motifs that are same as in the original motifs
Output2(*.new): motifs that overlap with original motifs but bind to different TFs (different motifs)
Ouput3(*.com_new): motifs that don’t overlap with any original motifs (completely de novo, where no motifs are found in the original position but new motifs are created)
Due to the limitation of previous scripts, if one motif from the mutated sequence overlap with multiple motifs from the original file, it might be presented in both .overlap and .new. So an extra step is needed to remove this type of motifs to get true de novo motifs.
You can run “./result/find_new_motifs/filter_overlap_result1.0.sh” to call “./result/find_new_motifs/filtering_overlap_motifs1.0.py”, this python script scan through output of classify_overlap_motifs1.2.py, take chrN.filtered.bed.new and chrN.filtered.bed.overlap as input, remove motifs exist in .overlap from .new, output to chrN.filtered.bed.filter_new, the ouput file will only contains motifs that are de novo but have overlap motifs in wildtype.
All results of this step stored under “./result/find_new_motifs/all_chr_result_raw_2/filtered_result/”

8. Merge results
Run merge_uniq_motifs.py, this script will filter only the unique motifs in chrN.*.filter_new, only keep the information for mutated new motifs, and append it to chrN*.com_new, and sort the file based on startC.

Store all the merged unique results in ./result/analysis_motifs/analysis_result/

Command to run the script is listed below:

for i in $chr_list; do echo $i; done | xargs -i -P 16 bash -c "python ../code/merge_uniq_motifs.py ../motifs_data/{}.filtered.bed.com_new ../motifs_data/{}.filtered.bed.filter_new {}.all_unique_new_motifs.bed"
