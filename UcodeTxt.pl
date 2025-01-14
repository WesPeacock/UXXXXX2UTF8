#!/usr/bin/perl
my $USAGE = "Usage: $0 [--help]";
# perl UcodeTxt.pl test.txt >testUXXXXX.txt
# convert the Unicode Plane 1 text to Unicode U+XXXXX format
#
# Originally planned as a scheme for Unicode plane 1 characters that cannot be imported by the FLEx SFM import.
#  I.e., convert the data to U+XXXXX_ format, import them into FLEx and use the perl code execution in FLEx to decode
# For Example:
# $echo '\lx hello👋' |./UcodeTxt.pl
# \lx helloU+1F44B_
# see also UdecodeTxt.pl
use 5.016;
use strict;
use open qw(:std :utf8);
use Getopt::Long;
GetOptions (
	'help'    => \my $help,
	) or die $USAGE;

if ($help) {
	say STDERR $USAGE;
	exit;
	}

while (my $line = <>) {
	$line = txt2u($line);
   print $line;
	}

sub txt2u{
my ($txtstring) = @_;
$txtstring =~ s/([\x{10000}-\x{1FFFF}])/sprintf  "U+%04X_", ord($1)/ge;
return $txtstring;
}
