#!/usr/bin/perl

use strict;
use warnings;
use Bio::SeqIO;
use Bio::Seq;

if (@ARGV < 3)
{
	print "Usage:   dsk_2multifasta.pl kmer_input prefix fasta_output";
	exit;
}

my $infile = shift;
my $prefix = shift;
my $outfile = shift;

open my $in, '<', $infile or die "Could not open file: $!";

my $output = Bio::SeqIO->new('-format'=>'fasta', file=> ">$outfile");

my $index = 1;
while (my $line = <$in>)
{
	chomp $line;
	my ($seq, $num) = split / /, $line;

	my $seq_id = $prefix."_".$index;
	$index++;
	my $new_seq = Bio::Seq->new(-display_id=>$seq_id, -seq=> $seq);
	$output->write_seq($new_seq);

}

close $in;