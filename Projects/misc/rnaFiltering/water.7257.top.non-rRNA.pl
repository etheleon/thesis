#!/usr/bin/env perl
use strict;

my @files = glob("out/7256.blastn.silva/piece*");
my %ribo;
for my $f(@files)
{
	open(IN, $f) or die;
	while(<IN>)
	{
		my @a = split(/\t/, $_);
		next unless $a[10] < 0.1;
		my $q = $a[0];
		$q =~ s|/\d$||;
		$ribo{$q} = 1;
	}
}
open(IN, "out/7255.top.reads.fa") or die;
open(OUT, ">out/7257.top.non-rRNA.fa") or die;
while(my $h = <IN>)
{
	my $seq = <IN>;
	if($h =~ m/>(\d+)\//)
	{
		next if $ribo{$1};
		print OUT "$h$seq";
	}
}
