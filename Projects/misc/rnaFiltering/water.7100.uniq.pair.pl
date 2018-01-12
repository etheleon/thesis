#!/usr/bin/env perl
use strict;
die "usage: $0 in1.fa in2.fa out1.fa out2.fa dup.id\n" unless $#ARGV == 4;
my ($in1, $in2, $out1, $out2, $dup) = @ARGV;
open(IN1, $in1) or die;
open(IN2, $in2) or die;
open(OUT1, ">$out1") or die;
open(OUT2, ">$out2") or die;
open(DUP, ">$dup") or die;
my %all;
while(<IN1>)
{
	my $h1 = $_;
	my $seq1 = <IN1>;
	my $half1 = substr($seq1, 0, 60);
	my $h2 = <IN2>;
	my $seq2 = <IN2>;
	my $half2 = substr($seq2, 0, 60);
	my $sig = "$half1-$half2";

	if($all{$sig})
	{
		print DUP "$h1$h2";
#		print STDERR "$h$seq duplicated with \n$all{$half}\n\n";
	}else
	{
		print OUT1 "$h1$seq1";
		print OUT2 "$h2$seq2";
		$all{$sig} = 1;
#		$all{$half} = "$h$seq";
	}
}


