#!/usr/bin/env perl
use strict;

my %name;
open(IN, "out/72501.names") or die;
print 'open(IN, "out/72501.names") or die;', "\n";
#open(IN, "test.names") or die;
while(<IN>)
{
	$name{$2} = $1 if m/^(\S+)\t(\d+?)$/;
}

open(IN, "out/7254.hit.freq.txt") or die;
print '#open(IN, "out/7254.hit.freq.txt") or die;', "\n";
#open(IN, "test.hit") or die;
my %hit;
my %h1;
my %h2;
while(<IN>)
{
	if(m/^(\d+)\.([12])\t(\d+?)$/)
	{
		$hit{$1} += $3;
		if($2 == 1)
		{
			$h1{$1} = $3;
		}else
		{
			$h2{$1} = $3;
		}
	}
}

open(IN, "out/7259.top.non-rRNA.fa") or die;
print '#open(IN, "out/7259.top.non-rRNA.fa") or die;', "\n";
#open(IN, "test.good.fa") or die;
my %good;
while(<IN>)
{
	if(m/^>(\d+)\//)
	{
		$good{$1} = 1;
	}
}

my %ko;
my @files = glob("out/mRNA.0040.ko/b1-0*");
print '#my @files = glob("out/mRNA.0040.ko/b1-0*");', "\n";
#my @files = glob("test.ko");
for my $f(@files)
{
	open(IN, $f) or die;
	while(<IN>)
	{
		if(m/^(\S+)\t(K\d{5})$/)
		{
			$ko{$1} = $2;
		}
	}
}

open(OUT, ">out/9100.ko.read.freq.txt") or die;
#open(OUT, ">test.out.txt") or die;
for my $r(sort {$hit{$b} <=> $hit{$a}} keys %hit)
{
	my $hit = $hit{$r};
	my $read = $name{$r};
	my $good = 0 if $hit >= 1000;
	my $good = $good{$r} ? 1 : 0;
	$good = '' if $hit < 1000;
	my $ko = $ko{$read};
	print OUT "$r\t$read\t$hit\t$h1{$r}\t$h2{$r}\t$good\t$ko\n";
}

