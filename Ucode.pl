#!/usr/bin/perl
my $USAGE = "Usage: $0 [--sfms lx,se,xv] [--help]";
# perl Ucode.pl --sfms lx,se,xv
# convert the text of venacular fields from Unicode Plane 1 text to U+XXXXX_ format
# The SFM fields to be converted are specified in a comma separated
# string by the --sfms option; the default is lx,se,xv
# 
# A scheme for Unicode plane 1 characters that cannot be imported by the FLEx SFM import.
#  I.e., convert the fields Unicode plane 1 characters to U+XXXXX_ format, import them into FLEx and use the perl code execution in FLEx to decode
# For Example:
# $echo '\lx hello👋' |./Ucode.pl
# \lx helloU+1F44B_
# see also Udecode.pl
use 5.016;
use strict;
use open qw(:std :utf8);
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
	   my $utxt = txt2u ($vernaculartxt);
	   $line = "\\" . $sfm . ' ' .$utxt . $eol;
	   }
   print $line;
	}

sub txt2u{
my ($txtstring) = @_;
$txtstring =~ s/([\x{10000}-\x{1FFFF}])/sprintf  "U+%04X_", ord($1)/ge;
return $txtstring;
}
