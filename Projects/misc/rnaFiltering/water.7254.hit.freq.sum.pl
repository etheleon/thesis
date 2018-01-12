#!/usr/bin/env perl
use strict;
my @in = glob("out/7253.hit.freq/*");

open OUT, ">out/7254.hit.freq.txt" or die;

my %freq;
for my $in(@in)
{
	open IN, $in or die;
	while(<IN>)
	{
		$freq{$1} += $2 if m/^(\S+?)\t(\d+)$/;
	}
}

for my $h(sort {$freq{$b} <=> $freq{$a}} keys %freq)
{
	print OUT "$h\t$freq{$h}\n";
}
