#!/usr/bin/perl
my $USAGE = "Usage: $0 [--sfms lx,se,xv] [--help]";
# perl Udecode.pl --sfms lx,se,xv
# convert SFM fields that contain a series of U+XXXXX sequences to Unicode text
# inverse of Ucode.pl
use 5.016;
use strict;
use open qw(:std :utf8);
binmode STDOUT, ':utf8';
use Getopt::Long;
GetOptions (
	'sfms:s'   => \(my $sfms = "lx,se,xv"), # Standard format fields to correct
	'help'    => \my $help,
	) or die $USAGE;

if ($help) {
	say STDERR $USAGE;
	exit;
	}

$sfms =~  s/,/\|/g;
my $vernacularSFMs = qr{$sfms};

while (my $line = <>) {
   if ($line =~ m/(\\($vernacularSFMs) )(.*?)(\R)/) {
	   my $sfm=$2;
	   my $vernaculartxt = $3;
	   my $eol = $4;
	   my $vtxt = u2txt($vernaculartxt);
	   $line =  "\\" . $sfm . ' ' .$vtxt . $eol;
	   }
   print $line;
} 

sub u2txt{
my ($txtstring) = @_;

return $txtstring if $txtstring !~ m/U\+/;
my $vstring = "";
my @num =  split (/U\+/, $txtstring);
for my $n (@num) {
   next if !$n; #skip first null
   $vstring = $vstring . chr(hex($n));
   }
return $vstring;
}