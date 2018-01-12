ls out/new.0100.blast.rDNA.aa/ | perl -pe 's|.+|./script/water.0101.filter.rRNA.pl out/new.0103.filtered.bb/$& out/new.0104.blast.rDNA.cc/$& out/new.0110.mRNA/$&|'
