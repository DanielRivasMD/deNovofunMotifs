import pandas as pd
import math
def extend(arg1, arg2):
    df = pd.read_table(arg1, header=None, sep='\t')
    df.iloc[:,[1,2]]=df.iloc[:,[1,2]].apply(extending, axis=1)
    df.to_csv(arg2, index=False,header=None,  sep='\t')
    return 

def extending(x):
    i=200-(x[2]-x[1]+1)
    x[1]=x[1]-int(i/2)
    x[2]=x[2]+math.ceil(i/2)
    if x[1]<0: x[1]=1
    return x

import sys
if __name__=="__main__":
    arg1, arg2 = sys.argv[1], sys.argv[2]
    arg2=arg2.split('/')[-1]
    extend(arg1, arg2)
