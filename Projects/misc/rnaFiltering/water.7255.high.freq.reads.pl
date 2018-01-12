#!/usr/bin/env perl
use strict;

my $MIN_HITS = 1000;

open D, "out/7254.hit.freq.txt" or die;
open OUT, ">out/7255.top.reads.fa" or die;

my @in = glob("out/7251.smaller/*");
my %seq;
for my $in(@in)
{
	open IN, $in or die;
	while(my $h = <IN>)
	{
		chomp $h;
		$h =~ s/^>//;
		my $seq = <IN>;
		$seq{$h} = $seq;
	}
}

my %freq;
my %total;
while(<D>)
{
	if(m/^((\d+)\.[12])\t(\d+)/)
	{
		$freq{$1} = $3;
		$total{$2} += $3;
	}
}

for my $h(sort{$total{$b} <=> $total{$a}} keys %total)
{
	last if $total{$h} < $MIN_HITS;
	my $h1 = $h.'.1';
	my $h2 = $h.'.2';
	print OUT ">$h/1 $freq{$h1}\n$seq{$h1}";
	print OUT ">$h/2 $freq{$h2}\n$seq{$h2}";
}

