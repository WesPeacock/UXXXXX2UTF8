#!/usr/bin/perl
# perl Ucode.pl
# convert the text of venacular fields to Unicode U+XXXXX format
# The SFM fields to be converted are specified in $vernacularSFMs
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
my $vernacularSFMs = qr{lx|xe|se};
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
