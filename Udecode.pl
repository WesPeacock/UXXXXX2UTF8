#!/usr/bin/perl
# perl Udecode.pl
# convert SFM fields that contain a series of U+XXXXX sequences to Unicode text
# inverse of Ucode.pl
use 5.016;
use strict;
binmode STDOUT, ':utf8';
my $vernacularSFMs = qr{lx|xe|se};
while (<>) {
   if (m/(\\($vernacularSFMs) )(.*?)(\R)/) {
	   my $sfm=$2;
	   my $vernaculartxt = $3;
	   my $eol = $4;
	   my @num =  split (/U\+/, $vernaculartxt);
	   print '\\', $sfm, ' ' ;
	   for my $n (@num) {
		 # say STDERR $n;
		 next if !$n; #skip first null
		 print chr(hex($n));
		 }
	print $eol;
	   }
else {
	print $_;
	}

} 
