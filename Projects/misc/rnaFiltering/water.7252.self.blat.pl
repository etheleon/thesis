#!/usr/bin/env perl
use strict;
my @files = glob("out/7251.smaller/0057*");
my @morefiles = glob("out/7251.smaller/0058_s_1.*");
@files = (@files, @morefiles);
for my $q (@files)
{
	my $qq = $1 if $q =~ m/.+\/(.*?)$/;
	for my $t(@files)
	{
		my $tt = $1 if $t =~ m/.+\/(.*?)$/;
		my $out = "out/7252.self.blat/$qq-vs-$tt";
		next if -f "$out.hit.bz2";
		print "blat -fastMap -out=blast8 $t $q $out && cut -f 1 $out | uniq -c | bzip2 --best > $out.hit.bz2 && rm $out\n";
	}
}
