#!/usr/bin/env python
# coding: utf-8

# In[260]:


#This script does two things: 
#(1) creates a dataframe from BED results for visualization 
#(2) Adds features: family motif, signature mutation class

import Bio
import math
import pyranges as pr
from pyjaspar import jaspardb
import numpy as np


# In[7]:


import Bio
import math
import pyranges as pr
from pyjaspar import jaspardb
import pandas as pd


# In[ ]:


def bed2df(file):
    jdb_obj = jaspardb(release='JASPAR2022')

    jdb_obj = jaspardb(release='JASPAR2022')
    motifs=jdb_obj.fetch_motifs(
    collection = None,
    tax_group = 'vertebrates',
    )

    #Import BED
    path = "data/chr21.all_unique_new_motifs.bed"
    gr = pr.read_bed(path)
    df = gr.df

    #Create new feature for chromosome id
    df[['Chr', 'Info']] = df['Chromosome'].str.split('|', 1, expand=True)

    df1 = df['Info'].str.split('*', expand=True)
    #drop rows with more than 1 mutation for region
    df1 = df1[df1[7].isna()==True]
    #clean columns
    df1.drop(df1.columns[[*range(7,19)]], axis=1, inplace=True)
    df_a = df.loc[df1.index]
    #df_ = pd.merge(df, df1, on="key")
    df_= pd.merge(df_a, df1, right_index=True, left_index=True)

    #rename columns
    col_nms = ['Sta', 'End','Wld', 'Mut','Canc_T', 'Mut_T', 'Pat_ID']
    df_.columns = df_.columns[:9].tolist() + col_nms
    df_[['Name','M_ID']]= df_['Name'].str.split('_', expand=True)

    df_ = df_.reset_index()

    df_["Mut_Sig"]=''

    #C>A
    # evaluate the condition 
    condition = df_.eval("Wld=='C' and Mut=='A' or Wld=='G' and Mut=='T'")
    # assign values
    df_['Mut_Sig'] = np.where(condition, "C>A",df_.Mut_Sig)


    #C<G
    condition = df_.eval("Wld=='C' and Mut=='G' or Wld=='G' and Mut=='C'")
    # assign values
    df_['Mut_Sig'] = np.where(condition, "C>G",df_.Mut_Sig)

    #C<T
    condition = df_.eval("Wld=='C' and Mut=='T' or Wld=='G' and Mut=='A'")
    # assign values
    df_['Mut_Sig'] = np.where(condition, "C>T",df_.Mut_Sig)

    #T<A
    condition = df_.eval("Wld=='T' and Mut=='A' or Wld=='A' and Mut=='T'")
    # assign values
    df_['Mut_Sig'] = np.where(condition, "T>A",df_.Mut_Sig)

    #T<C
    condition = df_.eval("Wld=='T' and Mut=='C' or Wld=='A' and Mut=='G'")
    # assign values
    df_['Mut_Sig'] = np.where(condition, "T>C",df_.Mut_Sig)

    #C<T
    condition = df_.eval("Wld=='T' and Mut=='G' or Wld=='A' and Mut=='C'")
    # assign values
    df_['Mut_Sig'] = np.where(condition, "T>G",df_.Mut_Sig)

    #Get TF class category
    cl_l =[]
    m_id = df_['M_ID'].tolist() 
    for i in range(0,len(m_id)):
        try:
            cl_l.append(jdb_obj.fetch_motif_by_id(m_id[i]).tf_class[0])
        except:
            cl_l.append(None)

    df_['Class'] = pd.Series(cl_l)
    
    df.to_csv('bed2df.csv', sep ='\t', index=False)


# In[ ]:


if __name__=="__main__":
    inpf = sys.argv[1]
    #bed=pd.read_csv(inpf, header=None, delimiter='\t')
    gr = pr.read_bed(inpf)
    df = gr.df
    


# In[ ]:


inpf, outf= sys.argv[1], sys.argv[2]
output=open(outf, 'w')
output.close()
output=open(outf, 'a')
bed2df(file)
output.close()

