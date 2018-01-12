#!/usr/bin/env perl
use strict;

my @db = glob('data/refseq/genomic.2bit/*.2bit');
my @query = glob('out/7200.good.pair/*.fa');
foreach my $q(@query)
{
	my $qn = $1 if $q =~ m/.+\/(.+?).fa/;
	foreach my $d(@db)
	{
		my $dn = $1 if $d =~ m/.+\/microbial.(.+?).2bit/;
		print "blat -fastMap -out=blast8 $d $q out/8000.blat.genome/$qn-$dn.txt\n";
	}
}

