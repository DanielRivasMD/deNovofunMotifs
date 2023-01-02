awk 'BEGIN {n_seq=0;} /^>/ {if(n_seq%50000==0){file=sprintf("myseq%d.fa",n_seq);} print >> file; n_seq++; next;} { print >> file; }' < chr1.extended_motifs.fa.mutated.uniq.clean
