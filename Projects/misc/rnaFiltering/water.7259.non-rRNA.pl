#!/usr/bin/env perl
use strict;

my @in = glob("out/7258.reads/*");
open OUT, ">out/7259.top.non-rRNA.fa" or die;
for my $in(@in)
{
	print("$in\n");

	my $blast = $in;
	$blast =~ s|(.+).reads/|$1.blast/7258.blast.|;
	open(FA, $in) or die;
	open(BL, $blast) or die;

	my %ribo;
	my $temp = $/;
	$/ = "\nQuery= ";
	while(<BL>)
	{
		if(m/^(\d+)/)
		{
			my $query = $1;
			while(m/^>(.*?)Expect = (\S+?)$/msg)
			{
				next if $2 >= 1;
				my $label = $1;
				if($label =~ m/ribosom/i)
				{
					$ribo{$query} = 1;
					last;
				}
			}
		}
	}

	$/ = $temp;
	while(my $h1 = <FA>)
	{
		my $s1 = <FA>;
		my $h2 = <FA>;
		my $s2 = <FA>;
		next if $h1 =~ m/^>(\d+)/ && $ribo{$1};
		print OUT $h1;
		print OUT $s1;
		print OUT $h2;
		print OUT $s2;
	}
}
__END__

>gb|GU926121.1| Uncultured bacterium clone F5K2Q4C04IPQEV 23S ribosomal RNA gene, 
partial sequence
Length=534

 Score = 96.9 bits (106),  Expect = 2e-17
 Identities = 82/101 (81%), Gaps = 1/101 (1%)
 Strand=Plus/Plus

