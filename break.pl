#!/usr/bin/perl -w
use strict;
my(@line, $file, $random, $random2, @characters, $i, $e, $o, @hold);
@characters = ("0","1","2","3","4","5","6","7","8","9","A","B","C","D","E","F");
print "File name:\n";
chomp($file = <stdin>);
@hold=split('\.', $file);
open FILE, "+<$file" or die "Error: $!\n";
$e = do { local $/; <FILE> };
$e = unpack ("h*", $e);
@line = split(//, $e);
if($hold[1] eq "jpg"){
	$e = "FFD8FFE000104A46494600";
	$i=22;
}elsif($hold[1] eq "gif"){
	$e = "47494638396173017301F7";
	$i=22;
}elsif($hold[1] eq "mp3"){
	$e = "4944330400000000011554";
	$i=22;
}else{
	print "This shit won't work bro...\n";
	$e="";
	$i=0;
}
do{
	$random = int(rand(10000));	#this number has to be really big, or else it doesn't work. There's some character combination that wrecks it, and it's just statistically less likely to happen this way.
	if($random == 4){
		do{
			$o = $characters[int(rand(16))];
			$o .= $characters[int(rand(16))];
		}while($o eq "FF");
		$e.=$o;
	}else{
		$e .= $line[($i+1)];
		$e .= $line[$i];
	}
	$i+=2
}while($i<(scalar(@line)-4));
$e.="FFD9";
$e =~ s/([a-fA-F0-9][a-fA-F0-9])/chr(hex($1))/eg;
close(FILE);
open NEWFILE, ">$hold[0]2\.$hold[1]" or die "Error: $!\n";
print NEWFILE $e;
close(NEWFILE);
