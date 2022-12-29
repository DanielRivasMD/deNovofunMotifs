import sys

file = open('observed_agreement_22May2017_hg38_sorted.bed9', 'r')
lines = file.readlines()

to_check = sys.argv[1]
c = 0

with open('observed_agreement_22May2017_hg38_sorted.bed9', 'r') as in_, open("to_check.txt", "w") as out:
    for i,l in enumerate(in_):
        l_tmp = l.strip().split()
        if l_tmp[0] == to_check:
            out.write(l)
            c += 1

print(f'Done! To check -> {c}')
