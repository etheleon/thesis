ls data/new_run/fasta/ | perl -ne 'print "blastall -p blastn -d data/silva/blast/rDNA.cc -i out/new.0103.filtered.bb/$& -e 0.0001 -b 1 -a 2 -m 8 -o out/new.0104.blast.rDNA.cc/$&\n" if m|.+|'
