awk 'BEGIN {n_seq=0;} /^>/ {if(n_seq%30000==0){file=sprintf("chrXp%d.fa",n_seq);} print >> file; n_seq++; next;} { print >> file; }' < chrX.extended_motifs.fa.mutated.uniq.clean
