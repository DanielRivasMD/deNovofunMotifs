# "Specifics" instructions

1. Use ut/filter.ipynb to filter down the mutations to be applied. 
  Modify lines 4,5,6 in cell 1:
    chr_ = ['chr21', 'chr1']
    pat = ['DO50848', 'DO1537']
    m_type = ['SNP', 'DNP']
  To meet your requirements.
  The output file "specific_mutations.bed9" will be stored under the same directory
 
 2. Use specifics/mutate_specific.sh to mutate the desired sequences.
  Define i and f to match your desired files
    i=/crex/proj/snic2020-16-187/nobackup/funMotifs_analysis/Siqi_files/results-ds-project-manel/specifics/chr21.extended_motifs.fa
    f=chr21.extended_motifs.fa
  Finally, modify where the output sequence will be stored, if needed.
    cat *.mutated > /crex/proj/snic2020-16-187/nobackup/funMotifs_analysis/Siqi_files/results-ds-project-manel/specifics/introduce_mutation/$f.mutated
 
 3. Use specifics/run_fimo_specific.sh to run FIMO on the desired directory
  Make sure:
    fasta_dir=/crex/proj/snic2020-16-187/nobackup/funMotifs_analysis/Siqi_files/results-ds-project-manel/specifics/introduce_mutation
    res_dir=/crex/proj/snic2020-16-187/nobackup/funMotifs_analysis/Siqi_files/results-ds-project-manel/specifics/fimo
  Are specified correctly, fasta_dir contains de mutated sequences (modify desired chr file to match your file), and res_dir will contain all results. Find the aggregated results under $res_dir/filtered_results/
  
