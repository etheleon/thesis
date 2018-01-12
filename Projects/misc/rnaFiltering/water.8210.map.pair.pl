#!/usr/bin/env perl
use strict;

my $minLen = 80;
my $minGap = 40;
my $maxGap = 300;

my @files = glob('out/8200.cdna.viral/*.1-*.txt');
for my $f(@files)
{
	my $f2 = $f;
	$f2 =~ s/\.1-/.2-/;
	my $out = $f;
	$out =~ s/8200.cdna.viral/8210.map.pair/;
	$out =~ s/\.1-.*//;
	open(P1, $f) or die;
	open(P2, $f2) or die;
	open(OUT, ">>$out") or die;
	my %map;
	print "processing $f\n";
	while(<P1>)
	{
		my @field = split(/\t/, $_);
		next if $field[3] < $minLen;
		$field[0] =~ s/\/\d$//;
		$map{$field[0]}->{$field[1]}->{int(($field[8] + $field[9])/2)} = $_;
	}
	print scalar %map;
	print "\n";
	print "processing $f2\n";
	while(<P2>)
	{
		my @field = split(/\t/, $_);
		next if $field[3] < $minLen;
		$field[0] =~ s/\/\d$//;
		my $q = $field[0];
		my $t = $field[1];
		my $p1 = $map{$q}->{$t};
		next unless $p1;
		my %p1 = %$p1;
		my $loc = int(($field[8] + $field[9])/2);
		for my $l(keys %p1)
		{
			my $dist = abs($l - $loc);
			if($dist >= $minGap && $dist <= $maxGap)
			{
				print OUT $p1{$l};
				print OUT $_;
				delete $map{$q}->{$t}->{$l};
				last;
			}
		}
	}
}


__END__
txt    0057_s_1.1-7.1.genomic.txt     0057_s_1.1-NZ23.genomic.txt    0057_s_1.1-XC5.ab.genomic.txt
0057_s_1.1-19.1.genomic.txt    0057_s_1.1-34.1.genomic.txt    0057_s_1.1-8.1.genomic.txt     0057_s_1.1-NZ24.genomic.txt    0057_s_1.1-XC5.ac.genomic.txt
0057_s_1.1-20.1.genomic.txt    0057_s_1.1-35.1.genomic.txt    0057_s_1.1-9.1.genomic.txt     0057_s_1.1-NZ25.genomic.txt    0057_s_1.1-XC5.ad.genomic.txt
0057_s_1.1-21.1.genomic.txt    0057_s_1.1-36.1.genomic.txt    0057_s_1.1-NZ10.genomic.txt    0057_s_1.1-NZ26.genomic.txt    0057_s_1.1-XC5.ae.genomic.txt
0057_s_1.1-2.1.genomic.txt     0057_s_1.1-37.1.genomic.txt    0057_s_1.1-NZ11.genomic.txt    0057_s_1.1-NZ27.genomic.txt    
0057_s_1.1-22.1.genomic.txt    0057_s_1.1-38.1.genomic.txt    0057_s_1.1-NZ12.genomic.txt    0057_s_1.1-NZ2.genomic.txt     
0057_s_1.1-23.1.genomic.txt    0057_s_1.1-39.1.genomic.txt    0057_s_1.1-NZ13.genomic.txt    0057_s_1.1-NZ3.genomic.txt     
0057_s_1.1-24.1.genomic.txt    0057_s_1.1-40.1.genomic.txt    0057_s_1.1-NZ14.genomic.txt    0057_s_1.1-NZ4.genomic.txt     
water 8000.blat.genome $ head 0057_s_1.1-10.1.genomic.txt 
HWI-ST884:57:1:1101:5087:6770#0/1       gi|145294025|ref|NC_009345.1|   100.00  96      0       0       6       101     7409    7504    4.8e-48 189.0
HWI-ST884:57:1:1101:5087:6770#0/1       gi|157149498|ref|NC_009789.1|   100.00  96      0       0       6       101     4258    4163    4.8e-48 189.0
HWI-ST884:57:1:1101:5087:6770#0/1       gi|78045556|ref|NC_007508.1|    100.00  96      0       0       6       101     2657467 2657372 4.8e-48 189.0
HWI-ST884:57:1:1101:16948:7730#0/1      gi|103485498|ref|NC_008048.1|   100.00  55      0       0       31      85      2410606 2410552 2.1e-24 110.0
HWI-ST884:57:1:1101:1271:12834#0/1      gi|54292964|ref|NC_006369.1|    100.00  50      0       0       6       55      2037844 2037893 4.2e-21 99.0
HWI-ST884:57:1:1101:4690:13346#0/1      gi|115345482|ref|NC_008385.1|   100.00  101     0       0       1       101     28167   28067   2.1e-51 200.0
HWI-ST884:57:1:1101:4815:18562#0/1      gi|114330036|ref|NC_008344.1|   100.00  54      0       0       11      64      1913465 1913412 5.1e-23 106.0
