ls out/new.0100.blast.rDNA.aa/ | perl -pe 's|.+|./script/water.0101.filter.rRNA.pl out/new.0101.filtered.aa/$& out/new.0102.blast.rDNA.bb/$& out/new.0103.filtered.bb/$&|'
