#!/usr/bin/perl -w
use strict;
use warnings;
use diagnostics;
use sigtrap;
use IO::Socket; 
use v5.10;

our $dochannel = "#NES";

my $remote_host = 'irc.mibbit.net';
my $remote_port = '6667';

my $socket = IO::Socket::INET->new(
		PeerAddr => $remote_host,
                PeerPort => $remote_port,
                Proto    => "tcp",
                Type     => SOCK_STREAM
				)
or die "Couldn't connect to $remote_host $remote_port";

our @line;

sub upload {
    my ($text) = @_;
    say $socket $text;
    say "--> $text";
}

sub pm {
    my ($channel, $text) = @_;
    
    unless (defined $text) {
      $text = $channel;
	
        
    }
    





if ($line[2] eq "MadBot") {

my @touser = split(/:|!.+/, $line[0]);

 upload "PRIVMSG $touser[1] :\x02\x02$text";

} else {


my @AtText = split(/\n+\s/, $text);


foreach my $JustSay (@AtText) {

    upload "PRIVMSG $line[2] :\x02\x02$JustSay";

}

}

}

sub everyone {

    my ($channel, $text) = @_;
    
    unless (defined $text) {
      $text = $channel;
	
        
    }

upload "PRIVMSG $dochannel :\x02\x02$text";

}



$socket->autoflush(1);

upload 'USER blah blah blah MadBot';
upload 'NICK MadBot';

while (defined (my $line = <$socket>)) {
    print "<-- $line";
    @line = split q{ }, $line;
    if (uc $line[0] eq 'PING') {
        upload "PONG $line[1]";
    }



    given ($line[1]) {


#;;;;;;;;;;;;;;;;;; Join ;;;;;;;;;;;;;;;;;#

        when ('001') {
            upload "JOIN $dochannel";

        }

 



#;;;;;;;;;;;;;;;;;; Command given? ;;;;;;;;;;;;;;;;;#

my $null = $line[0];

$null =~ s/://g;
my @user = split(/\!.+/, $null);

our $luckyduck;

our $start;
our $sen;
our $where;
our @words;
our $ease;
our @multi; 


     when ('PRIVMSG') {

our $input4 = join q{ }, @line[4..$#line];



if ($line[3] =~ /^\:\![Ss][Tt][Aa][Rr][Tt]$/) {

my @usert = split(/\:.+\!/, $line[0]);

if ($usert[1] =~ /wiiq/) {


pm 'Someone query me a game mode.';
$start = "mode";
}

}

if ($line[3] =~ /^\:\![Ee][Nn][Dd]$/) {

my @usert = split(/\:.+\!/, $line[0]);

if ($usert[1] =~ /wiiq/) {


pm 'Ended.';
$start = "";
$sen = "";
$where = 0;
}

}




if ($line[3] =~ /^\:\![Mm][Oo][Dd][Ee]$/) {

if ($start eq "mode") {

if ($line[2] !~ /[Mm][Aa][Dd][Bb][Oo][Tt]/) {

pm 'No, query me the mode.';
} else {



if ($line[4] =~ /[Mm][Aa][Dd]/) {

$luckyduck = $user[0];

pm 'Madlib mode started. Give me a sentence.';
$start = "sen";
} elsif ($line[4] =~ /[Ss][Cc][Rr][Aa][Mm][Bb][Ll][Ee]/) {

$luckyduck = $user[0];

pm 'Scramble mode started. Give me a word or sentence.';
$start = "scam";

} else {

pm 'Valid modes: Mad, Scramble';
pm 'Mad - Madlib';
pm 'Scramble - Scrambles words and sentence';
}


}

} else {

pm "Sorry $luckyduck already has it.";
}

}


if ($start eq "scam") {

if ($line[3] =~ /^\:\![Ss][Ee][Nn]$/) {

if ($user[0] ne $luckyduck) {

pm "Sorry $luckyduck already has it.";
} else {

if ($line[2] !~ /[Mm][Aa][Dd][Bb][Oo][Tt]/) {

pm 'No, query me the sentence.';
} else {

my $pass = 0;
@words=split(/ /, $input4);

@multi = @words;

while ($pass == 0) {



my $aka = 0;
foreach my $kk (@words) {

$kk =~ s/(.)/$1 /g;

my @hold = split(/ /, $kk);





foreach my $aa (@hold) {

my $r = int(rand($#hold));

$aa =~ s/\./\\./g;
$aa =~ s/\(/\\(/g;
$aa =~ s/\//\\\//g;
$aa =~ s/\?/\\?/g;

$words[$aka] =~ s/($aa)/$hold[$r]/i;
$words[$aka] =~ s/($hold[$r])/$aa/i;

$words[$aka] =~ s/\s//g;	# join spaces
$words[$aka] =~ s/\\//g;

}

$aka++;

}

if (@words ~~ @multi) {

} else {

$start = "guessthescam";
everyone "Scramble mode started:";
everyone "@words";
$pass = 1;

}

}

}

}
}
}


if ($start eq "guessthescam")  {



if ($line[3] =~ /^\:\![Gg][Ii][Vv][Ee]$/) {


my $aa = 0;
my $pass = 0;


my @temp = split(/ /, $input4);
my $yth = @temp;

while ($pass == 0) {

my $kk = 0;

foreach (@multi) {




if ($multi[$kk] =~ /^[^0-9A-z]*($temp[$aa])[^0-9A-z]*$/i) {


$words[$kk] = $multi[$kk];

}


$kk++;

}

$aa++;

if ($aa > $yth) {

$pass = 1;
}



}

if (@multi ~~ @words) {

everyone 'Thats it. The sentence was:';
everyone "@multi";

$start = "mode";

everyone "Someone start another game.";
} else {

everyone "@words";
}


}

}




if ($start eq "sen") {

if ($line[3] =~ /^\:\![Ss][Ee][Nn]$/) {

if ($user[0] ne $luckyduck) {

pm "Sorry $luckyduck already has it.";
} else {

if ($line[2] !~ /[Mm][Aa][Dd][Bb][Oo][Tt]/) {

pm 'No, query me the sentence.';
} else {


$sen = join q{ }, @line[4..$#line];
my @touser = split(/:|!.+/, $line[0]);
if ($sen =~ /\<.+\>/) {

$sen =~ s/\s/\xC2\xA0/g;
$sen =~ s/>\xC2\xA0+</> </g;
$sen =~ s/>\xC2\xA0/> /g;
$sen =~ s/\xC2\xA0</ </g;

@words = split(/ /, $sen);

if ($sen eq "") {


upload "PRIVMSG $touser[1] Valid input: \"!sen [sentence]\"."

} else {

everyone "Madlib mode started.";
$start = "go";

}

} else {

upload "PRIVMSG $touser[1] Give me at least one blank. A valid blank would be: \"<something>\".";
}

}


}

}

}



if ($line[3] =~ /^\:\![Gg][Ii][Vv][Ee]$/) {

if ($start eq "standby") {

my $to = join q{ }, @line[4..$#line];

$to =~ s/</~~(~~/g;
$to =~ s/>/~~)~~/g;
$to =~ s/\//\//g;
$to =~ s/\-/\-/g;
$to =~ s/\+/\+/g;

$words[$where] =~ s/(.+)<.+>(.+)/$1$to$2/g;
$words[$where] =~ s/(.+)<.+>/$1$to/g;
$words[$where] =~ s/<.+>(.+)/$to$1/g;
$words[$where] =~ s/<.+>/$to/g;

$start = "go";
}

if ($start eq "satndbyt") {

my $to = join q{ }, @line[4..$#line];

$to =~ s/</~~(~~/g;
$to =~ s/>/~~)~~/g;

$ease =~ s/>/\\>/g;
$ease =~ s/</\\</g;
$ease =~ s/\?/\\?/g;

$words[$where-1] =~ s/$ease/$to/g;

my $a = 0;

my $toto = $words[$where-1];
$toto =~ s/^.+?</</g;
$toto =~ s/>.+?</></g;
$toto =~ s/>\S.+?$/>/g;

@multi = split(/ /, $toto);

foreach my $heh (@multi) {

if ($heh =~ /<.+?>/) {

$ease = $heh;

my @heh = split(/<|>/, $ease);

everyone "Give me $heh[1]:";
$a =1;
}

last if $a == 1;
}

if ($a == 0) {

$start = "go";
}


}



}


if ($start eq "go") {

$where = 0;



foreach (@words) {



if ($words[$where] =~ /<.+?>.+?</) {


my $toto = $words[$where];
$toto =~ s/^.+?</</g;
$toto =~ s/>.+?</></g;
$toto =~ s/>\S.+?$/>/g;

@multi = split(/ /, $toto);

my $a = 0;

foreach my $heh (@multi) {


if ($heh =~ /<.+?>/) {

$ease = $heh;

my @heh = split(/<|>/, $ease);

everyone "Give me $heh[1]:";
$a =1;
}

last if $a == 1;
}
$start = "satndbyt";

}

elsif ($words[$where] =~ /\<[^~]+\>/) {

my @whw = split(/\<|>/, $words[$where]);

everyone "Give me $whw[1]:";


#pm $words[$where];



$start = "standby";

} 

last if $start =~ /standby/;
$where++;
}






if ($start eq "go") {



everyone "Thats it, here is the sentence:";

my $two = 0;

foreach (@words) {

$words[$two] =~ s/~~\(~~/</g;
$words[$two] =~ s/~~\)~~/>/g;

$two++;

}

everyone "@words";

everyone "Someone start another game.";
$start = "mode";
$sen = "";
$where = 0;

}

}



if ($line[3] =~ /^\:\![Hh][Ee][Ll][Pp]$/) {

if ($start eq "mode") {

pm '!mode to give a game mode.';
} else {


pm '!give to guess a word, !sen to give it a sentence.';

}

}


}

				}


			}

    			

#}

	



close($socket);