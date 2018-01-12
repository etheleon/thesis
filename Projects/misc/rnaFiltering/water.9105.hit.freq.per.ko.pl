#!/usr/bin/env perl
use strict;

open(IN, "out/9100.ko.read.freq.txt") or die;
open(OUT, ">out/9105.ko.hit.freq.txt") or die;
my %ko;
my %hit;
while(<IN>)
{
	chomp;
	my ($rid, $id, $hit, $hit1, $hit2, $good, $ko) = split(/\t/, $_);
	next if $hit >= 1000 && $good eq '0';
	$ko = 'unclassified' unless $ko;
	$ko{$ko}++;
	$hit{$ko}->{$hit}++;
}

for my $ko(sort {$ko{$b} <=> $ko{$a}} keys %ko)
{
	next if $ko eq 'unclassified';
	my $kcount = $ko{$ko};
	my %h = %{$hit{$ko}};
	for my $h(sort {$b <=> $a} keys %h)
	{
		if($h > $kcount)
		{
			$hit{'unclassified'}->{$h} += $h{$h};
			next;
		}
		print OUT "$ko\t$h\t$h{$h}\n";
	}
}

my %unclass = %{$hit{'unclassified'}};
for my $h(sort {$b <=> $a} keys %unclass)
{
	print OUT "unclassified\t$h\t$unclass{$h}\n";
}
