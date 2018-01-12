#!/usr/bin/env perl
use strict;

my @files = glob("data/refseq/genomic/*.fna");
open(OUT, '>out/8015.genome.info.txt') or die;
print OUT "id\tlen\ttype\tchrom\tinfo\n";

my $typere = qr/(complete genome|complete sequence|partial sequence|whole genome shotgun sequence)/i;
for my $f(@files)
{
	print "$f\n";
	open(IN, $f) or die;
	$/ = '>';
	while(<IN>)
	{
		s/>//;
		my $type = $1 if m/$typere/;
		s/$typere//;
		if(m/^(\S+)\s+(.*?)((genomic|plasmid|chromosome|Contig).*?)?[ ,]*\n(.+)/is)
		{
			my ($id, $info, $chrom, $seq) = ($1, $2, $3, $5);
			$seq =~ s/\s//g;
			my $len = length $seq;
			$chrom = 'chromosome' unless $chrom;
			print OUT "$id\t$len\t$type\t$chrom\t$info\n";
		}
	}
}
