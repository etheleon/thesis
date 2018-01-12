#!/usr/bin/env perl
use strict;

my $fasta = shift;
my $blast = shift;
my $out = shift;

die "usage: $0 fasta.file blast.out filter.out\n" unless -f $fasta && -f $blast;

open BL, $blast or die;
open FA, $fasta or die;
open OUT, ">$out" or die;

my %rrna;
while(<BL>)
{
	$rrna{$1} = 1 if m/^(\S+?)\t/;
}

while(my $h = <FA>)
{
	my $s = <FA>;
	if($h =~ m/^>(\S+)/)
	{
		print OUT "$h$s" unless $rrna{$1};
	}
}
