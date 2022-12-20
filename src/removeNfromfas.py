import sys
from Bio import SeqIO
for record in SeqIO.parse(sys.argv[1], "fasta"):
    if record.seq.count('N') == 0 | record.seq.count('n')==0 :
        print(record.format("fasta"))