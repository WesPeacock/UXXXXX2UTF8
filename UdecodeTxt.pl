#!/usr/bin/perl
my $USAGE = "Usage: $0 [--help]";
# perl UdecodeTxt.pl testUXXXXX.txt >test.txt
# convert the Unicode U+XXXXX to Unicode Plane 1 text
# inverse of UcodeTxt.pl
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
	$line = u2txt($line);
   print $line;
	}

sub u2txt{
my ($txtstring) = @_;
$txtstring =~ s/(U\+)(.+?)(_)/chr(hex($2))/ge;
return $txtstring;
}
