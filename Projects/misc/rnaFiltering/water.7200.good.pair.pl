#!/usr/bin/perl
use strict;
die "usage: $0 in1.fa in2.fa out1.fa out2.fa\n" unless $#ARGV == 3;
my ($in1, $in2, $out1, $out2) = @ARGV;

my $max_N = 15;

open(IN1, $in1) or die;
open(IN2, $in2) or die;
open(O1, ">$out1") or die;
open(O2, ">$out2") or die;

while(<IN1>)
{
	my $h1 = $_;
	my $s1 = <IN1>;
	my $h2 = <IN2>;
	my $s2 = <IN2>;
	my $n1 = $s1 =~ s/N/N/g;
	next if $n1 >= $max_N;
	my $n2 = $s2 =~ s/N/N/g;
	next if $n2 >= $max_N;
	print O1 "$h1$s1";
	print O2 "$h2$s2";
}
