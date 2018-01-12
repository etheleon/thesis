ls out/new.0100.blast.rDNA.aa/ | perl -pe 's|.+|./script/water.0101.filter.rRNA.pl data/new_run/fasta/$& out/new.0100.blast.rDNA.aa/$& out/new.0101.filtered.aa/$&|'
