import pandas as pd
def check(mutate, row):
    info=mutate.split("*")
    startC=int(info[0])
    endC=int(info[1])
    if row[2]>=startC and row[1]<=endC:
        return True
    else:
        return False

def filtering(ori_bed, output):
    for i in range(len(ori_bed)):
        seq_info=ori_bed.iloc[i, 0].split("|")
        for mutate in seq_info[1:]:
            if check(mutate, ori_bed.iloc[i,:]):
                row=[str(ele) for ele in ori_bed.iloc[i, :]]
                row='\t'.join(row)
                output.write(f'{row}\n')
                break
    return 

import sys
if __name__=="__main__":
    file1, file2= sys.argv[1], sys.argv[2]
    #file1="../result/Alx1_MA0854.1_highestranked10.bed.uniq"
    #file2="../result/Alx1_MA0854.1_highestranked10.bed.uniq.filtered"
    ori_bed=pd.read_csv(file1, header=None, delimiter='\t')
    #file2 = file2.split('/')[-1]
    output=open(file2, 'w')
    output.close()
    output=open(file2, 'a')
    filtering(ori_bed, output)
    output.close()

