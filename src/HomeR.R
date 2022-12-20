library("BiocManager")

library(TFBSTools)

library("monaLisa")

library("JASPAR2022")

library(Biostrings)

library(BiocParallel)

pfms <- getMatrixSet(JASPAR2022,
                     opts = list(matrixtype = "PFM",
                                 tax_group = "vertebrates"))


pwms <- toPWM(pfms)

res <- findMotifHits(query = pwms ,
                     subject = gen_mut,
                     min.score = 30,
                     method = "matchPWM",
                     BPPARAM = SerialParam()
                     )

write.table( x = data.frame(res), file = "data/results.chrom21.txt", sep="\t", col.names=TRUE, row.names=FALSE, quote=FALSE )
