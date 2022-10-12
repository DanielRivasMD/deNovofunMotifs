#!/bin/bash
#SBATCH -A snic2021-5-152
#SBATCH -p node
#SBATCH -N 1
#SBATCH -J pancan
#SBATCH -t 4:00:00
#SBATCH -C mem256GB
##SBATCH -M snowy

date



echo "Processing Cohorts and Elements"

eval "$(conda shell.bash hook)"
conda activate funMotifs
module load bioinfo-tools
module load BEDTools
module load samtools
module load MEMEsuite
module load liftOver
module load python
module load python3
module load PostgreSQL
#module load R
module load R_packages




#python3.5 /proj/snic2020-16-50/nobackup/pancananalysis/pancancer_analysis_KS/pancancer_analysis/ProcessCohorts.py --cohort_names_input /proj/snic2020-16-50/nobackup/pancananalysis/pancan12Feb2020/cancer_datafiles/cohorts_to_run_definedPCAWG_Active --mutations_cohorts_outdir /proj/snic2020-16-187/nobackup/funMotifs_analysis/pancan_output_30May/  --observed_input_file /proj/snic2020-16-50/nobackup/pancananalysis/pancan12Feb2020/mutations_files/observed_annotated_agreement_22May2017.bed9 --simulated_input_dir /proj/snic2020-16-50/nobackup/pancananalysis/pancan12Feb2020/mutations_files/mutations_simulations_files_103sets_test --chr_lengths_file /proj/snic2020-16-50/nobackup/pancananalysis/pancan12Feb2020/cancer_datafiles/chr_lengths_hg19.txt --num_cores 1 --sig_category overallTFs  --background_window --background_window_size 50000 --filter_on_qval --sig_thresh 0.05 --sim_sig_thresh 1.0 --tmp_dir /proj/snic2020-16-187/nobackup/funMotifs_analysis/tmp_pybedtoos/

#python3 /proj/snic2020-16-187/nobackup/funMotifs_analysis/ProcessCohorts_14_04.py
#run Index DHS 
#Rscript /proj/snic2020-16-187/nobackup/funMotifs_analysis/local_src/Parse_IndexDHS_data.R /proj/snic2020-16-187/nobackup/funMotifs_analysis/funMotifs_conf/DHS_Index_and_Vocabulary_metadata_12_03_2021.tsv /proj/snic2020-16-187/nobackup/funMotifs_analysis/funMotifs_datafiles/CellInfo_26_03/ /proj/snic2020-16-187/nobackup/funMotifs_analysis/funMotifs_conf/DHS_index_Stamatoyan_Nature_2020.tsv /proj/snic2020-16-187/nobackup/funMotifs_analysis/funMotifs_datafiles/additional_files/dat_bin_FDR01_hg38.RDS
#awk -F"\t" '{if($31>0 || $39 >0 || $52>0 || $63>0 || $72>0 || $84>0 || $88>0 || $103>0 ||  $107>0 || $110>0 || $112>0 || $117>0 || $124>0) print $124}' /proj/snic2020-16-187/nobackup/funMotifs_analysis/funMotifs_colon/results/output_regulatorymotifs/overlapping_scored_motifs_onlynarrowpeaks/chr*_overlapping_tracks_scored.bed10 | wc -l> /proj/snic2020-16-187/nobackup/funMotifs_analysis/DHS_motifs

#download datafrom ENOCODE, ChromHMM
#python3 /proj/snic2020-16-187/nobackup/funMotifs_analysis/funMotifs/src_helpers/ParseCellInfo.py --cellinfodict_inputfile  /proj/snic2020-16-187/nobackup/funMotifs_analysis/funMotifs_conf/ParseCellInfo_params_test2.conf --assembly GRCh38 --target_cellinfo_dirs_path /proj/snic2020-16-187/nobackup/funMotifs_analysis/funMotifs_datafiles/CellInfo_6_04/

#download EpiMap data
#python3 /proj/snic2020-16-187/nobackup/funMotifs_analysis/local_src/ParseCellInfo_EpiMap.py --cellinfodict_inputfile  /proj/snic2020-16-187/nobackup/funMotifs_analysis/funMotifs_conf/ParseCellInfo_EpiMap_params_16_03_2021_test.conf --assembly GRCh38 --target_cellinfo_dirs_path /proj/snic2020-16-187/nobackup/funMotifs_analysis/funMotifs_datafiles/CellInfo/

##download Gene expression data from ENCODE
#python3 /proj/snic2020-16-187/nobackup/funMotifs_analysis/funMotifs_EpiMap/funMotifs/src_helpers/GetDataSetsAPI.py --assembly GRCh38 --Genecode_genes_input_file /proj/snic2020-16-187/nobackup/funMotifs_analysis/funMotifs_datafiles/additional_files/gencode.v35.annotation.gff3 --CellInfoDict_input_file /proj/snic2020-16-187/nobackup/funMotifs_analysis/funMotifs_conf/ParseCellInfo_params_04_05_2021.conf --Output_dir /proj/snic2020-16-187/nobackup/funMotifs_analysis/funMotifs_datafiles/GeneExp2/ENCODEGeneExpr2/



#process FANTOM data
python3 /proj/snic2020-16-187/nobackup/funMotifs_analysis/funMotifs_EpiMap/funMotifs/src_helpers/ProcessCAGEExp.py /proj/snic2020-16-187/nobackup/funMotifs_analysis/funMotifs_datafiles/CAGE_data_2021_06/Human.sample_name2library_id_onlyCellLines_groupedLibrariesTheSameCellLines_2021_06.txt /proj/snic2020-16-187/nobackup/funMotifs_analysis/funMotifs_datafiles/CAGE_data_2021_06/human_permissive_enhancers_phase_1_and_2_expression_tpm_matrix.txt Id 1

python3 /proj/snic2020-16-187/nobackup/funMotifs_analysis/funMotifs_EpiMap/funMotifs/src_helpers/ProcessCAGEExp.py /proj/snic2020-16-187/nobackup/funMotifs_analysis/funMotifs_datafiles/CAGE_data_2021_06/Human.sample_name2library_id_onlyCellLines_groupedLibrariesTheSameCellLines_2021_06.txt /proj/snic2020-16-187/nobackup/funMotifs_analysis/funMotifs_datafiles/CAGE_data_2021_06/hg19.cage_peak_phase1and2combined_tpm_ann.osc.txt 00Annotation 7

cat /proj/snic2020-16-187/nobackup/funMotifs_analysis/funMotifs_datafiles/CAGE_data_2021_06/hg19.cage_peak_phase1and2combined_tpm_ann.osc.txt_avgExprValueperCell.bed4 /proj/snic2020-16-187/nobackup/funMotifs_analysis/funMotifs_datafiles/CAGE_data_2021_06/human_permissive_enhancers_phase_1_and_2_expression_tpm_matrix.txt_avgExprValueperCell.bed4 > /proj/snic2020-16-187/nobackup/funMotifs_analysis/funMotifs_datafiles/CAGE_data_2021_06/CAGE_expr_per_peak_all_cells_promoters_enhancers.bed4

Rscript local_src/LiftOver.R /proj/snic2020-16-187/nobackup/funMotifs_analysis/funMotifs_datafiles/CAGE_data_2021_06/CAGE_expr_per_peak_all_cells_promoters_enhancers.bed4 /proj/snic2020-16-187/nobackup/funMotifs_analysis/funMotifs_datafiles/additional_files/hg19ToHg38.over.chain

#liftOver /proj/snic2020-16-187/nobackup/funMotifs_analysis/funMotifs_datafiles/CAGE_data_2021_06/CAGE_expr_per_peak_all_cells_promoters_enhancers.bed4  /proj/snic2020-16-187/nobackup/funMotifs_analysis/funMotifs_datafiles/additional_files/hg19ToHg38.over.chain /proj/snic2020-16-187/nobackup/funMotifs_analysis/funMotifs_datafiles/CAGE_data_2021_06/CAGE_expr_per_peak_all_cells_promoters_enhancers_hg38.bed4 /proj/snic2020-16-187/nobackup/funMotifs_analysis/funMotifs_datafiles/CAGE_data_2021_06/CAGE_expr_per_peak_all_cells_promoters_enhancers_hg38_unMapped.bed4



#python3 /proj/snic2020-16-187/nobackup/funMotifs_analysis/funMotifs_test/funMotifs/src_helpers/GetDataSetsAPI.py --assembly GRCh38 --Genecode_genes_input_file /proj/snic2020-16-187/nobackup/funMotifs_analysis/funMotifs_datafiles/additional_files/gencode.v35.annotation.gff3_onlygenes.bed --CellInfoDict_input_file /proj/snic2020-16-187/nobackup/funMotifs_analysis/funMotifs_conf/ParseCellInfo_params_test.conf --Output_dir /proj/snic2020-16-187/nobackup/funMotifs_analysis/funMotifs_datafiles/GeneExp2/ENCODEGeneExpr2/
#/sw/apps/PostgreSQL/10.3/rackham/bin/pg_ctl -D /proj/snic2020-16-187/nobackup/pgsql/data -l /proj/snic2020-16-187/nobackup/pgsql/logfile  start
#python3 /proj/snic2020-16-187/nobackup/funMotifs_analysis/funMotifs/src/funMotifsMain.py --param_file /proj/snic2020-16-187/nobackup/funMotifs_analysis/funMotifs_conf/main_parameters_2020_12_03.conf
