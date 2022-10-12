def combs(a): #function to make full combination of a list
    if len(a) == 0:
        return [[]]
    cs = []
    for c in combs(a[1:]):
        cs += [c, c+[a[0]]]
    return cs #the result will have a empty list [] as first element, need to be removed when used this function

from Bio.Seq import MutableSeq
from Bio.Seq import Seq
def single_mutate(seq_record, row, startC): #function to perform single point mutation, input: old sequence record, return new sequence record
    sequence = MutableSeq(seq_record.seq)
    coordinate=row[1]-startC
    if row[3]=="-":
        sequence.insert(coordinate, row[4])
    elif row[4]=="-":
        del sequence[coordinate]
    else:
        sequence[int(coordinate)]=row[4]
    seq_record.seq=Seq(sequence)
    #new_description=" ".join(row[1:])
    seq_record.description=" ".join([str(elem) for elem in row[1:]])
    return seq_record
   
from bed_reader import open_bed
def mutate(sRecord, bed):#mutate function should return a list of all possible mutated sequences
    '''
For each resord, get the coordinate information from decrisbtion, looking for mutation in this range from mutation data.
Extract mutation data from bedfile, make dictionary based on cancer type.
For each type, get mutation number
   '''
    #print(bed.head(10))
    info=sRecord.description.split(":")
    chrN=info[0]#get chromosome number
    coordinates=info[1]
    startC=int(coordinates.split("-")[0])+1#get start coordinate, and in fasta file generated by getfasta, the coordinate is 1 less than true coordiante, so startC+1 is true startC

    endC=int(coordinates.split("-")[1])#get end coordinate
    chrN_bed=bed.loc[(bed[0]==chrN)&(bed[1]>=startC)&(bed[2]<=endC)]#get a subset of data frame that have only mutations in this record
    cancer_series=chrN_bed[5].value_counts()#return a series of types of cancer in the subset
    new_seq_record_list=[]
    for cancer, mNum in cancer_series.items(): #loop through types of cancer and each mutation in certain type of cancer
        chrN_bed_cancer=chrN_bed.loc[chrN_bed[5]==cancer] #subset a specific type of cancer from chrN_bed
        comb_list=combs(range(0, mNum))[1:] #get list of all possible combination of row number
        for i in comb_list:
            for j in i:
                new_seq_record_list.append(single_mutate(sRecord, chrN_bed_cancer.iloc[j], startC))
    return new_seq_record_list


#main function, take sequence data as input 1, mutation data as input 2 and output name as input 3
import sys
from Bio import SeqIO
import pandas as pd
if __name__=="__main__":
    sFile, mFile, oFile = sys.argv[1], sys.argv[2], sys.argv[3] #sFile=sequence file, mFile=mutation file, oFile=output file
    oFile=oFile.split('/')[-1]
    #sFile="../raw-data/extended motifs sequences/chr10.extended_motifs.fa"
    #mFile="../raw-data/mutation data/mutation_chr10_testOnly.bed9"
    bed=pd.read_csv(mFile, header=None, delimiter='\t')#read bed file as data frame
    records = list(SeqIO.parse(sFile, "fasta")) #creat sequence record from fasta file
    new_records = []
    for seq_record in records:
        new_records=new_records+mutate(seq_record, bed)
    SeqIO.write(new_records, oFile, "fasta")
    #print(records[1000].seq[0:10])
    #print(bed.head())
    #print(records[-1])
    


