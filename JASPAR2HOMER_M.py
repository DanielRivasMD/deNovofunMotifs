#!/usr/bin/env python
# coding: utf-8

# In[1]:


from pytfmpval import tfmp


# In[80]:


#convert lines to space seperated number values
def line2num(txt):
    l = txt.split()
    if len(txt[1])!='1':
        tl = l[1][1:]
        l = l[:1] + ["["] + l[2:]
        l.insert(2,tl)
    out_t = " ".join(l[2:len(l)-1])
    return(" " + out_t)

#convert lines to matrix for score calculation
def lines2mat(txt):
    
    m = (line2num(txt[0]) +
         line2num(txt[1]) +
         line2num(txt[2]) +
         line2num(txt[3]))
    mat = tfmp.read_matrix(m)
    return (mat)

        
    


# In[81]:


#import matrix data
with open('data/JASPAR2022_CORE_vertebrates_non-redundant_pfms_jaspar.txt', 'r') as infile:
    lines = [line for line in infile]
#open output file
out = open("data/Homer_JASPAR.txt","w")
for i in range(0,len(lines)):
    if i%5==0:
        #get family, motif, compute score
        matrix = lines2mat(lines[i+1:i+5])
        score = tfmp.pval2score(matrix, 0.0001)
        if score >=
        motif, fam = lines[i][1:].split()
        #correct order and format
        out.write(">" + fam + "\t" + motif + "\t" + str(score)+"\n")
    else:
        out.write(line2num(lines[i])+"\n")
out.close()
        

