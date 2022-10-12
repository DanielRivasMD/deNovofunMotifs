import pandas as pd
import math
def extend(arg1, arg2):
    df = pd.read_csv(arg1, header=None, sep='\t')
    
    for row in range(len(df)):
        x=df.iloc[row,2]
        y=df.iloc[row,1]
        i = 200-(x-y+1)
        df.iloc[row,2]=x+math.ceil(i/2)
        df.iloc[row,1]=y-int(i/2)
    df.to_csv(arg2, header=None,  index=False,  sep='\t')
    return 
import sys
if __name__=='__main__':
	arg1, arg2 = sys.argv[1], sys.argv[2]
	arg2=arg2.split('/')[-1]
	extend(arg1, arg2)
