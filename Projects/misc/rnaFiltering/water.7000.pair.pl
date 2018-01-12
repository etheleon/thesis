#!/usr/bin/perl
use strict;
die "usage: $0 file1 file2 out1 out2\n" unless $#ARGV == 3;
my ($f1, $f2, $o1, $o2) = @ARGV;
open F1, $f1 or die;
open F2, $f2 or die;
die "output files already exist\n" if -f $o1 || -f $o2;
open O1, ">$o1" or die;
open O2, ">$o2" or die;

my %f1;
$/ = '>';
while(<F1>)
{
	s/>//;
	if(m/(\S+)\/1.*?\n(.+)/)
	{
		my $h = $1;
		my $seq = $2;
		$f1{$h} = $seq;
	}
}
while(<F2>)
{
	s/>//;
	if(m/(\S+)\/2.*?\n(.+)/)
	{
		my $h = $1;
		my $f1 = $f1{$h};
		if($f1)
		{
			print O1 ">$h/1\n$f1\n";
			print O2 ">$h/2\n$2\n";
		}
	}
}




