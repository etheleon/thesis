#!/usr/bin/env perl
use strict;

my @d = glob("out/0050.fastqc/*_fastqc");

my $overview;
my $base_quality;
my $sequence_gc;

for my $d(@d)
{
	my $sample = $1 if $d =~ m|out/0050.fastqc/(.+?)(.fq)?_fastqc|;
	my $file = "$d/fastqc_data.txt";
	open(IN, $file) or die;
	$/ = '>>END_MODULE';

	# overview
	$_ = <IN>;
	my $total = $1 if m/Total Sequences\t(\d+)/;
	my $gc = $1 if m/\%GC\t(\d+)/;
	$overview .= "$sample\t$total\t$gc\n";

	# per base quality
	$_ = <IN>;
	my $bq = $1 if m/((^\d.+\n)+)/m;
	$bq =~ s/^/$sample\t/mg;
	$base_quality .= $bq; 

	# quality count
	$_ = <IN>;

	# per base content
	$_ = <IN>;

	# base GC
	$_ = <IN>;

	# per sequence GC
	$_ = <IN>;
	my $g = $1 if m/((^\d.+\n)+)/m;
	$g =~ s/^/$sample\t/mg;
	$sequence_gc .= $g; 
}

open(OUT, ">out/0060.fastqc.overview.txt") or die;
print OUT "sample\ttotal\tgc\n$overview";
close OUT;

open(OUT, ">out/0060.fastqc.perbase.quality.txt") or die;
print OUT "sample\tBase\tMean\tMedian\tLower.Quartile\tUpper.Quartile\tp10th\tp90th\n";
print OUT $base_quality;
close OUT;

open(OUT, ">out/0060.fastqc.gc.txt") or die;
print OUT "sample\tgc\tcount\n$sequence_gc";
close OUT;

