library("BiocManager")

BiocManager::install("TFBSTools", ask = FALSE)

library(TFBSTools)

BiocManager::install("monaLisa", ask = FALSE)

library("monaLisa")

#BiocManager::install("TFBSTools", ask = FALSE)

library("JASPAR2022")

library(Biostrings)

library(BiocParallel)


gen_mut<- readDNAStringSet('data/head.fa', format="fasta", nrec=-1L, skip=0L, seek.first.rec=FALSE, use.names=TRUE)


pfms <- getMatrixSet(JASPAR2022,
                     opts = list(matrixtype = "PFM",
                                 tax_group = "vertebrates"))


pwms <- toPWM(pfms)

res <- findMotifHits(query = pwms ,
                     subject = gen_mut,
                     min.score = 21,
                     method = "matchPWM",
                     BPPARAM = bpparam()
                     )

write.table( x = data.frame(res), file = "data/results.chrom21.txt", sep="\t", col.names=TRUE, row.names=FALSE, quote=FALSE )


