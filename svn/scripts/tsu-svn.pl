#!/usr/bin/perl

use strict;

my $PREPATH = "/mud/www/wizards/secure/svndiffs";

my $nRevision = 0;
my $bFoundHead = 0;

while(<STDIN>)
{
	if(!$nRevision && /^Subject: \[(\d+)/)
	{
		$nRevision = $1;
		open(OUT, ">$PREPATH/$nRevision.html") || die;
	}

	if(!$bFoundHead && /^<head/)
	{
		$bFoundHead = 1;
	}

	if($bFoundHead)
	{
		print OUT $_;
	}
}
close(OUT);
