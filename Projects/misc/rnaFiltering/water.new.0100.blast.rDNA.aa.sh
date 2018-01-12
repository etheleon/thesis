ls data/new_run/b*/* | perl -ne 'print "blastall -p blastn -d data/silva/blast/rDNA.aa -i $& -e 0.0001 -b 1 -a 3 -m 8 -o out/new.0100.blast.rDNA.aa/$1\n" if m|data/new_run/b\d/(.+)|'
