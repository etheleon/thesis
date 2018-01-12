#!/usr/bin/env perl
use strict;
my @file1 = glob("out/7200.good.pair/00*.1.fa");

my $i = 0;
for my $f(sort @file1)
{
	open(IN, $f) or die;
	while(my $h = <IN>)
	{
		$i++;
		my $seq = <IN>;
		chomp $h;
		my $name = $1 if $h =~ m/^>(\S+)\/1$/;
		print "$name\t$i\n";
	}
}
