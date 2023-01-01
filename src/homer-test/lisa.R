library("BiocManager")

#BiocManager::install("monaLisa", ask=FALSE, lib="/proj/snic2022-5-189/R_packages") individually install other packages if needed

library(TFBSTools)

library("monaLisa")

library("JASPAR2022")

library(Biostrings)

library(BiocParallel)


gen_mut<- readDNAStringSet('data/chr21.fa.clean', format="fasta", nrec=-1L, skip=0L, seek.first.rec=FALSE, use.names=TRUE)


pfms <- getMatrixSet(JASPAR2022,
                     opts = list(matrixtype = "PFM",
                                 tax_group = "vertebrates"))


pwms <- toPWM(pfms)

res <- findMotifHits(query = pwms ,
                     subject = gen_mut,
                     min.score = 27,
                     method = "matchPWM",
                     BPPARAM = bpparam()
                     )

write.table( x = data.frame(res), file = "data/results.chrom21.txt", sep="\t", col.names=TRUE, row.names=FALSE, quote=FALSE )

