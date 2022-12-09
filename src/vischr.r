#install.packages("chromoMap")

library("chromoMap")

# chromosome files
chr_file = "chr_file.txt"

#Motif file
annot_m = "chr1.all_unique_new_motifs.bed.txt"

#Visualization of heatmap for motifs distribution
# Open image file
png("chr_hm.png", width = 350, height = "350")
# Create the plot
ChromoMap(chr_file,anno_m,
          data_based_color_map = T,
          data_type = "numeric")
# 3. Close the file
dev.off()

#Visualization of top family distributions for motifs distribution
# Open image file
png("chr_fam.png", width = 350, height = "350")
# Create the plot
chromoMap(chr_file,annot_m,
          data_based_color_map = T,
          data_type = "categorical",
          data_colors = list(c("orange","yellow","blue","red")))
dev.off()
