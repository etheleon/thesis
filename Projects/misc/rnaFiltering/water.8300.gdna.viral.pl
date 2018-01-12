#!/usr/bin/env perl
use strict;

my @db = glob('data/refseq/viral/*.2bit');
my @query = glob('out/7700.454/*.fa');
foreach my $q(@query)
{
	my $qn = $1 if $q =~ m/.+\/(.+?).fa/;
	foreach my $d(@db)
	{
		print "blat -fastMap -out=blast8 $d $q out/8300.gdna.viral/$qn-viral.txt\n";
	}
}

