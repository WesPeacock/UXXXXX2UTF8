#!/usr/bin/perl
my $USAGE = "Usage: $0 [--sfms lx,se,xv] [--help]";
# perl Ucode.pl --sfms lx,se,xv
# convert the text of venacular fields to Unicode U+XXXXX format
# The SFM fields to be converted are specified in a comma separated
# string by the --sfms option; the default is lx,se,xv
# 
# Originally planned as a scheme for Unicode planes that cannot be imported by the FLEx SFM import.
#  I.e., convert the fields to U+XXXXX format, import them inot FLEx and use tthe perl code execution in FLEx to decode
# For Example:
# $echo '\lx hello' |./Ucode.pl
# \lx U+0068U+0065U+006CU+006CU+006F
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

my $ustring = "";
my @ch =  split (//, $txtstring);
for my $c (@ch) {
   $ustring = $ustring . sprintf  "U+%04X", ord($c);
   }
return $ustring;
}
