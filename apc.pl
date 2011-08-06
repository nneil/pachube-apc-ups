#!/usr/bin/perl

use strict;
use warnings;

# apikey and feedid go in two separate files. Just the data on a single line.

my $apikey=`cat apikey`;
my $feedid=`cat feedid`;

chomp $apikey;
chomp $feedid;

# LINEV LOADPCT BCHARGE TIMELEFT OUTPUTV ITEMP BATTV LINEFREQ

my $cmd=qq(curl -X PUT --data-binary "\@-" --silent --header "X-PachubeApiKey: $apikey" http://api.pachube.com/v2/feeds/$feedid.csv >/dev/null);
open(OUT,"|$cmd");
open(IN,"/sbin/apcaccess|");
while(<IN>){
    my($name,$value)=/^(LINEV|LOADPCT|BCHARGE|TIMELEFT|OUTPUTV|ITEMP|BATTV|LINEFREQ) .*?([0-9.]+)/;
    if(defined $name){
	print OUT "$name,$value\n";
    }
}
close IN;
close OUT;



