#!/usr/bin/env perl
use strict;
my @file1 = glob("out/7250.split/00*.1.fa.??");
my @file2 = glob("out/7250.split/00*.2.fa.??");

my $i = 0;
for my $f(sort @file1)
{
	my $ff = "$1.$2.fa" if $f =~ m/.+\/(00.*?).fa.(\w\w)$/;
	open(IN, $f) or die;
	open(OUT, ">out/7251.smaller/$ff") or die;
	while(my $h = <IN>)
	{
		$i++;
		my $seq = <IN>;
		$h =~ s/>.+/>$i.1/;
		print OUT $h;
		print OUT $seq;
	}
}
my $i = 0;
for my $f(sort @file2)
{
	my $ff = "$1.$2.fa" if $f =~ m/.+\/(00.*?).fa.(\w\w)$/;
	open(IN, $f) or die;
	open(OUT, ">out/7251.smaller/$ff") or die;
	while(my $h = <IN>)
	{
		$i++;
		my $seq = <IN>;
		$h =~ s/>.+/>$i.2/;
		print OUT $h;
		print OUT $seq;
	}
}




