#!/usr/bin/env perl
use IO::Compress::Gzip qw(gzip);

my $compress_cutoff = 101 * 0.45;
my $longrun_cutoff = 20;
my $N_cutoff = 10;

open(IN, "out/7257.top.non-rRNA.fa") or die;
open(OUT, ">out/7258.good.top.fa") or die;
while(my $header = <IN>)
{
	my $seq = <IN>;
	$seq =~ s/\s//g;
	my $header2 = <IN>;
	my $seq2 = <IN>;
	$seq2 =~ s/\s//g;

	if($seq =~ s/N/N/g >= $N_cutoff)
	{
		next;
	}
	if($seq2 =~ s/N/N/g >= $N_cutoff)
	{
		next;
	}

	my $max = -1;
	for my $n qw(A T G C)
	{
	    while($seq =~ m/($n+)/g)
	    {
	        my $len = length $1;
	        $max = $len if $len > $max;
	    }
	}
	if($max >= $longrun_cutoff)
	{
		next;
	}
	my $max = -1;
	for my $n qw(A T G C)
	{
	    while($seq2 =~ m/($n+)/g)
	    {
	        my $len = length $1;
	        $max = $len if $len > $max;
	    }
	}
	if($max >= $longrun_cutoff)
	{
		next;
	}

	my $out;
	gzip(\$seq, \$out);
	if(length($out) <= $compress_cutoff)
	{
		next;
	}
	my $out;
	gzip(\$seq2, \$out);
	if(length($out) <= $compress_cutoff)
	{
		next;
	}

	print OUT "$header$seq\n$header2$seq2\n";
}

