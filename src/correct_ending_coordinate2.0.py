import pandas as pd
def rename(chrom):
    chrom = chrom[1:]
    return chrom

def check(file1, file2, file3):
    bedFile = pd.read_table(file1, header=None, sep='\t')
    chromLen = pd.read_table(file2, header=None)
    chromLen.iloc[:,0]=chromLen.iloc[:,0].map(rename) #remove the ">" in fasta chromsome name
    chromLen.set_index(chromLen.iloc[:,0], inplace=True)
    if bedFile.iloc[-1, 2] > chromLen.loc[bedFile.iloc[-1,0],1]:
        bedFile.iloc[-1, 2]=chromLen.loc[bedFile.iloc[-1,0],1]
    bedFile.iloc[:,1]=bedFile.iloc[:,1].apply(lambda x: x-1)#change the start coordinate of each row by x-1 (x in getfasta actually get x+1)
    bedFile.to_csv(file3, index=False, header=None, sep='\t')
    return 

import sys
if __name__=="__main__":
    file1, file2, file3 = sys.argv[1], sys.argv[2], sys.argv[3]
    #file1=(file1. split("/")[-1]).split(".")[0]
    #file1="../raw-data/chrM.bed.extend"
    #file2="../result/chrom_length.fa"
    file3 = file3.split('/')[-1]
    check(file1, file2, file3)

