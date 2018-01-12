ls out/new.0110.mRNA/*.1.fa | perl -pe 's|(.+/(b[12].*?)).1.fa|./script/water.7000.pair.pl $& $1.2.fa out/new.7000.mRNA/$2.1.fa out/new.7000.mRNA/$2.2.fa|'
