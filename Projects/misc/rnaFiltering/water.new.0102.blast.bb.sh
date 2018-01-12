ls data/new_run/fasta/ | perl -ne 'print "blastall -p blastn -d data/silva/blast/rDNA.bb -i out/new.0101.filtered.aa/$& -e 0.0001 -b 1 -a 2 -m 8 -o out/new.0102.blast.rDNA.bb/$&\n" if m|.+|'
