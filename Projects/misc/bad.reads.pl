#!/usr/bin/env perl
use IO::Compress::Gzip qw(gzip);

my $compress_cutoff = 101 * 0.6;
my $score_cutoff = 30;
my $longrun_cutoff = 9;
my $N_cutoff = 10;

my %dup;
while(my $header = <>)
{
	my $seq = <>;
	my $temp = <>;
	my $score = <>;
	$seq =~ s/\s//g;

	chomp $score;
	my $sc = 0;
	map { $sc += ord($_)-33 } split('', $score);
	$sc /= length($score);
	if($sc <= $score_cutoff)
	{
		print $header;
#		print "score: $sc\n";
		next;
	}

	if($seq =~ s/N/N/g >= $N_cutoff)
	{
		print $header;
#		print "N: ", scalar($seq =~ s/N/N/g), "\n";
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
		print $header;
#		print "reeat: $max\n";
		next;
	}


	my $out;
	gzip(\$seq, \$out);
	if(length($out) <= $compress_cutoff)
	{
		print $header;
#		print "compress: ", length($out), "\n";
		next;
	}
}

