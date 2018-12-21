#!/usr/bin/perl -w
use strict;
use warnings;
use diagnostics;
use sigtrap;
use IO::Socket; 
use v5.10;
use Tie::File;

my $mynick = 'Chrus';
my $channel = '#NES';
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
    
    upload "PRIVMSG $line[2] :\x02\x02$text";


}


$socket->autoflush(1);

upload 'USER aw yeah aw yeah';
upload 'NICK PREACHER_ANDY';

while (defined (my $line = <$socket>)) {
    print "<-- $line";
    @line = split q{ }, $line;
    if (uc $line[0] eq 'PING') {
        upload "PONG $line[1]";


    }






    given ($line[1]) {


#;;;;;;;;;;;;;;;;;; Join ;;;;;;;;;;;;;;;;;#

        when ('001') {
            upload "JOIN $channel";

        }


        when('NICK') {
          if($line[0] =~ /$mynick/) {
            $mynick = $line[2];
            $mynick =~ s/^://;
          }
        }



#;;;;;;;;;;;;;;;;;; Command given? ;;;;;;;;;;;;;;;;;#

     my @WHAT = ('WHAT IS GOING DOWN?', 'YEAH WHAT?', 'INDEED!', 'HUH?');
     my @EXECL = ('RIGHT HERE, RIGHT NOW!', 'RIGHT THERE!', 'HERE IT IS!', 'SAY IT!', 'YEAH!', 'INDEED!', 'WHOOO', 'YOU KNOW IT!');
     my @DONT = ('DON\'T DO IT', 'NO SIREE! NOooOO HOW!', 'NOPE!', 'NO WAY!', 'NOOO HOOW!', 'NO WAY, NOOO HOOW!', 'DON\'T DO IT SISTER!');
     my @YEAH = ('I agree.', 'Oh, absolutely.', 'yeah YEAH!', 'Oh, I think so.', 'Yep.', 'For sure.', 'Yes.', 'Without a doubt.', 'Definitely.');
     my @HOW = ('Yes, how?', 'Indeed.', 'Tell me.', 'Let\'s find out.');
     my @HAHA = ('HAHAHAHA!', 'Yes! Very funny!', 'I am laughing!', 'I am amused as well.');
     
     when ('PRIVMSG') {

      if ($line[0] =~ /$mynick/) {
        
        if(int(rand(3)) == 1) {
          our $text = join q{ }, @line[3..$#line];
          $text =~ s/://g;
         
         
          if($text =~ /dont/i || $text =~ /don't/i || $text =~ /not\s/i || $text =~ /no\s/i) {
            pm $DONT[int(rand($#DONT-1))];
          } elsif($text =~ /lol/i && $text =~ /haha/i) {
            pm $HAHA[int(rand($#HAHA-1))];
          } elsif($text =~ /\?/) {
            pm $WHAT[int(rand($#WHAT-1))];
           } elsif($text =~ /how/i) {
            pm $HOW[int(rand($#HOW-1))];
           } elsif ($text =~ /!/) {
            pm $EXECL[int(rand($#EXECL-1))];
          } else {
            pm $YEAH[int(rand($#YEAH-1))];
          }
        }
      }

    }

	
  }
}

close($socket);