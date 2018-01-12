#!/usr/bin/env perl
use strict;

my $q = shift;
$q = $1 if $q =~ m|out/7251.smaller/(.+)|;

my @files = glob("out/7251.smaller/0057*");
my @morefiles = glob("out/7251.smaller/0058_s_1.*");
my @all = (@files, @morefiles);

my %hit;
open OUT, ">out/7253.hit.freq/$q.txt" or die;
for my $t(@all)
{
	$t = $1 if $t =~ m|out/7251.smaller/(.+)|;
	my $data = `bzcat out/7252.self.blat/$q-vs-$t.hit.bz2`;
	while($data =~ m/(\d+) (\d+\.\d+)/g)
	{
		$hit{$2} += $1;
	}
}
for my $hit(sort {$hit{$b} <=> $hit{$a}} keys %hit)
{
	print OUT "$hit\t$hit{$hit}\n";
}
close OUT;
