import pandas as pd
def check(mutate, row):
    info=mutate.split("*")
    if len(info[len(info)-1].split(":"))==1:
        return True
    s = int(info[len(info)-1].split(":")[1].split("-")[0])
    startC=int(info[0])
    endC=int(info[1])
    if s+int(row[2])>=startC and s+int(row[1])<=endC:
        return True
    else:
        return False

def filtering(ori_bed, output):
    for i in range(0, ori_bed.shape[0]):
        seq_info=ori_bed.iloc[i, 0].split("|")
        for mutate in seq_info[1:]:
            if check(mutate, ori_bed.iloc[i,:]):
                row=[str(ele) for ele in ori_bed.iloc[i, :]]
                row='\t'.join(row)
                output.write('{}\n'.format(row))
                break
    return 

import sys
if __name__=="__main__":
    file1, file2= sys.argv[1], sys.argv[2]
    #file1 = 'data/results.chrom21(2).txt'
    #file2 = 'data/resultsf.chrom21(2).txt'
    ori_bed=pd.read_csv(file1, header=None, delimiter='\t')
    #file2 = file2.split('/')[-1]
    outf=open(file2, 'w')
    outf.close()
    outf=open(file2, 'a')
    filtering(ori_bed, outf)
    outf.close()

