#!/usr/bin/env perl

use Modern::Perl '2015';
use experimental 'signatures';

my %scg;
do{ chomp; $scg{$_}++ } while <DATA>;

say "#", scalar keys %scg;

my $file = "/export2/home/uesu/KEGG/KEGG_SEPT_2014/genes/ko/ko";

$/ = '///';


open (my $in, $file);
scanning($_) while <$in>;

#Extracts the KO which matches to the gene of interest; in this case the single copy genes
sub scanning ($line)
{
    if ($line =~ m/^NAME\s+(?<sym>.+)$/m)
    {
        my @syms = split ",", $+{sym};
        @syms = map {$_ =~ s/\s//g; $_} @syms;
        for my $sym (@syms)
        {
            if (exists $scg{$sym})
            {
                my ($ko) = $line =~/^ENTRY\s+(K\d{5})/sm;
                say join "\t", $ko, $sym;
            }
        }
    }
}

#Taken from this list
#This is not written by XieChao but by Wesley Goi.
#The list generated differs with the original by XC by 1 KO: rpoB K13798 (Archaea), presumably because it was archeal
#WG does not know why it was not included (it is found in the ko genes/ko/ko file taken from XIECHAO's folder)

# List of gene symbol names were taken from this paper
#Wu, M., & Eisen, J. A. (2008). A simple, fast, and accurate method of phylogenomic inference. Genome Biology, 9(10), R151. doi:10.1186/gb-2008-9-10-r151

__DATA__
dnaG
frr
infC
nusA
pgk
pyrG
rplA
rplB
rplC
rplD
rplE
rplF
rplK
rplL
rplM
rplN
rplP
rplS
rplT
rpmA
rpoB
rpsB
rpsC
rpsE
rpsI
rpsJ
rpsK
rpsM
rpsS
smpB
tsf
