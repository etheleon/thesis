#!/usr/bin/env perl
use strict;

my @files = glob('data/rna-1/fasta/*.fa');
for my $f(@files)
{
	open(IN, $f) or die;
	$f =~ s|data/rna-1/fasta|out/0070.gc|;
	$f =~ s/.fa$/.gc/;
	open(OUT, ">$f") or die;
	print OUT "A\tT\tG\tC\n";
	$/ = '>';
	while(<IN>)
	{
		s/>//;
		if(m/^\S+.*?\n(\S+)/)
		{
			my $seq = $1;
			$seq = uc $seq;
			my $a = $seq=~s/A//g;
			my $t = $seq=~s/T//g;
			my $g = $seq=~s/G//g;
			my $c = $seq=~s/C//g;
			$a += 0;
			$t += 0;
			$g += 0;
			$c += 0;
			print OUT "$a\t$t\t$g\t$c\n";
		}
	}
}

