use strict;
use warnings;
use diagnostics;
use sigtrap;
use IO::Socket;
use v5.10;
use Tie::File;

use WWW::Mechanize;

our $mech = WWW::Mechanize->new();

our @tosaydo;
our $lols;





$mech->get('http://www.jabberwacky.com/');
$mech->form_number(1);



our $channel = '#NES';


































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
	my ($text) = @_;
	
	unless (defined $text) {
		$text = $channel;
		
	}
	
	if ($text =~ /^ACTION/) {
		upload "PRIVMSG $channel :$text";
		} else {
		upload "PRIVMSG $channel :\x02\x02$text";
	}
	
	
	
	
	
	my $end = 0;
	foreach my $yellow (@tosaydo) {
		
		
		if ($yellow eq $text) {
			$end = 1;
			} elsif ($text =~ /^http/) {
			$end = 1;
		}
		
		
		
		
		last if $end == 1;
	}
	
	
	if ($end == 0) {
		push(@tosaydo, $text);
	}
	
}


$socket->autoflush(1);

upload 'USER lol blah blah YU';
upload 'NICK YU';

while (defined (my $line = <$socket>)) {
	print "<-- $line";
	@line = split q{ }, $line;
	if (uc $line[0] eq 'PING') {
		upload "PONG $line[1]";
		
		
		if (int(rand(3)) == 1) {
			
			my $many = @tosaydo;
			
			pm $tosaydo[int(rand($many))];
			
		}
		
	}
	
	
	
	
	
	
	given ($line[1]) {
		
		
		#;;;;;;;;;;;;;;;;;; Join ;;;;;;;;;;;;;;;;;#
		
		my @greetings = ('Greetings primitives!', 'Here I am!', 'YU is here!', 'Dora!', 'Um?', 'It\'s YU! Your best bud!', ' yoyoyyo', 'hi', 'hihi', 'plz say hi to me', 'make me feel welcome please :)', ':)');
		when ('001') {
			upload "JOIN $channel";
			if(int(rand(3)) == 1) {
				pm $greetings[int(rand($#greetings-1))];
			}
		}
		
		when('KICK') {
			upload "JOIN $channel";
			my $hiya = @tosaydo;
			pm $tosaydo[int(rand($hiya))];
		}
		
		when ('JOIN') {
			if ($line[0] =~ /^:YU/) {
				
				} else {
				
				my $hiya = @tosaydo;
				pm $tosaydo[int(rand($hiya))];
				
			}
			
		}
		
		my @nicks;
		
		when('NICK') {
			$lols = join q{ }, @line[2..$#line];
			
			$lols =~ s/^\://g;
			
			push(@nicks, $lols);
		}
		
		
		when ('474') {
			upload "JOIN $channel";
		}
		
		our $okok = 75;
		
		#;;;;;;;;;;;;;;;;;; Command given? ;;;;;;;;;;;;;;;;;#
		
		when ('PRIVMSG') {
			
			if (int(rand(50)) eq 1) {
				my $temp = $nicks[int(rand($#nicks-1))];
				if ($temp) {
					upload "NICK ".$temp;
				}
				} elsif (int(rand(100)) eq 1) {
				my $mymy = int(rand($#tosaydo-1));
				if($tosaydo[$mymy]) {
          upload "NICK ".$tosaydo[$mymy];
          push(@nicks, $tosaydo[$mymy]);
				}
			}
			
			if (int(rand(3)) eq 1 && $line[0] !~ /YU2/) {
				
				#$lols = join q{ }, @line[3..$#line];
				
				# NOTE TO ME THIS IS A TEST
				$lols = $line;
				$lols =~ s/.+?\s.+?://g;
				
				#$lols =~ s/^\://g;
				
				if($lols !~ /^!/ && $line[0] !~ /UnoBot/ && $line[0] !~ /YU2/) {
					
					foreach (@tosaydo) {
						my $end = 0;
						my $hiya = @tosaydo;
						
						my $watt = $tosaydo[int(rand($hiya))];
						
						
						my $bb = $lols;
						
						$bb =~ s/\*/\\*/g;
						$bb =~ s/\\/\\\\/g;
						$bb =~ s/\(/\\\(/g;
						$bb =~ s/\)/\\\)/g;
						$bb =~ s/\]/\\\]/g;
						$bb =~ s/\[/\\\[/g;
						$bb =~ s/\?/\\\?/g;
						$bb =~ s/\+/\\\+/g;
						$bb =~ s/\./\\\./g;
						
						if ($watt =~ /$bb/ig) {
							
							pm $watt;
							
							$end = 1;
						}
						
						last if $end == 1;
					}
					
					my $end = 0;
					foreach my $yellow (@tosaydo) {
						
						
						if ($yellow eq $lols) {
							$end = 1;
						}
						
						
						
						
						last if $end == 1;
					}
					
					
					if ($end == 0) {
						push(@tosaydo, $lols);
					}
					
					
				}
				
				if (int(rand(5)) == 1) {
					
					my $hello = join q{ }, @line[3..$#line];
					
					my $many = @tosaydo;
					
					if(int(rand(10)) > 3) {
						pm $tosaydo[int(rand($many))];
						} else {
						
						my $end = 0;
            my $eck = int(rand($#tosaydo-1));
            while($eck < $#tosaydo && $end == 0) {
              if($tosaydo[$eck] =~ /\Q$hello\E/) {
                $end = 1;
              }
              $eck++;
            }
						
						if($end == 0) {
						  pm $tosaydo[int(rand($#tosaydo-1))];
						} else {
              pm $tosaydo[$eck-1];
						}
					}
					
					
					} elsif(int(rand(5)) == 1) {
					
					my $hello = join q{ }, @line[3..$#line];
					
					if ($hello) {
						
						$mech->field("vText1", $hello);
						
						
						$mech->submit();
						
						my $title = $mech->title();
						
						if ($title && $title !~ /- An Artificial Intelligence chatbot, AI chatterbot or chatterbox, for online chatting, talk, chats, talking, think, thought, thoughts, converse,dialogue,dialog,conversation/) {
							our @response = split(/ - /, $title);
							
							pm $response[2];
							} else {
							
							my $many = @tosaydo;
							
							pm $tosaydo[int(rand($many))];
							
							
						}
						
						} else {
						
						my $many = @tosaydo;
						pm $tosaydo[int(rand($many))];
						
						
					}
				}
				
				
			}
			
		if (join q{ }, @line[3..$#line] =~ /[Oo][Pp][Rr][Aa][Hh]/) {
				
				pm 'http://t3.gstatic.com/images?q=tbn:ANd9GcTTx5wvnqvkgkLo7nx5txsHMbUG67FawNBFD6btFfYhTgPky_41Ww';
				
			}
			
			if ($line[3] =~ /^:[Vv][Rr][Oo]/) {
				
				my $holdyh = join ' ', @line[3..$#line];
				
				$holdyh =~ s/O/A/g;
				$holdyh =~ s/o/a/g;
				$holdyh =~ s/://g;
				
				pm $holdyh;
				
			}
			
			if (join ' ', @line[3..$#line] =~ /[Gg][Oo][Ll][Ll][Uu][Mm]/) {
				
				pm 'http://www.ageofthering.com/atthemovies/cast/gollum.jpg';
				
			}
			
			if (join ' ', @line[3..$#line] =~ /[Gg][Uu][Ss][Tt][Aa]/) {
				
				pm 'http://fuuka.warosu.org/data/cgl/img/0067/64/1365864073496.jpg';
				
			}
			
			if (join ' ', @line[3..$#line] =~ /[Rr][Aa][Nn][Dd][Oo]/) {
				
				tie our @lol, 'Tie::File', 'lol.txt' or die $!;
				my $random_number = int(rand($okok));
				
				pm $lol[$random_number];
				
				
			}
			
			if ($line[3] =~ /[Uu][Rr][Ff]/) {
				
				our $manymoretimes = 0;
				#our $testyu;
				my $sen;
				
				#if ($line[4] !~ /^[0-9]+$/) {
					
					#$manymoretimes = 1;
					#$sen = join ' ', @line[4..$#line];
					
			  #} else {
          $manymoretimes = int(rand($#line-4));
          if ($manymoretimes == 0) {
            $manymoretimes = 1;
          }
          $sen = join ' ', @line[4..$#line];
				#}
				
				
				
				
				our @rar = split(/\s+/, $sen);
				
				
				
				our $many = -1;
				
				foreach (@rar) {
					
					$many++;
				}
				
				while ($manymoretimes != 0) {
					my $randomnumber = int(rand($manymoretimes+$many));
					
					
					
					
					if ($rar[$randomnumber] =~ /^[A-Z]+$/) {
						
						my $s = "";
						
						if ($rar[$randomnumber] =~ /[Ss].*$/ && $rar[$randomnumber] !~ /[Tt]*[Hh][Ii][Ss]/ && $rar[$randomnumber] !~ /[Ii][Ss]/) {
							
							if ($rar[$randomnumber] !~ /\'[Ss].*$/) {
								$s = "S";
								} else {
								$s ="'S";
							}
						}
						
						$rar[$randomnumber] =~ s/^[A-Z]+([!?.,\\\'\/\)\(\}\{`"\;]*)$/SMURF$s$1/g;
						
						} else {
						
						my $s = "";
						
						if ($rar[$randomnumber] =~ /[Ss].*$/ && $rar[$randomnumber] !~ /[Tt]*[Hh][Ii][Ss]/ && $rar[$randomnumber] !~ /[Ii][Ss]/) {
							
							if ($rar[$randomnumber] !~ /\'[Ss].*$/) {
								$s = "s";
								} else {
								$s ="'s";
							}
						}
						
						$rar[$randomnumber] =~ s/^[^\!\?\.\,\\\/)\(\}\{\`\"\;]+([\!\?\.\,\\\/\)\(\}\{`"\;]*)$/smurf$s$1/g;
						
						
					}
					
					$manymoretimes--;
				}
				
				if ($sen eq "") {
					
					pm "smurf";
					} else {
					
					pm "@rar";
					
				}
			}
			
			if ($line[3] =~ /^:[Gg][Oo]/ && int(rand(100)) == 5) {
				pm "We'll put the shifters in reverse, go into hyperspace, and RIDE THE SHOCKWAVE OUTTA HERE!";
			}
			
			if ($line[3] =~ /^:[Vv][Rr][Aa]/) {
				
				my $holdyh = join ' ', @line[3..$#line];
				
				$holdyh =~ s/A/O/g;
				$holdyh =~ s/a/o/g;
				$holdyh =~ s/://g;
				
				pm $holdyh;
				
			}
			
			if ($line[3] =~ /^:![Rr][Aa][Ww]/) {
				our $words = join q{ }, @line[4..$#line];
				upload $words;
			}
			
			if ($line[3] =~ /^:![Cc][Hh][Oo][Oo][Ss][Ee]/) {
				
				our $words = join q{ }, @line[4..$#line];
				
				our @tochoose = split(/\sor\s|\sOR\s/, $words);
				
				our $b = 0;
				
				foreach (@tochoose) {
					
					$b++;
				}
				
				my $random = int(rand($b));
				
				pm $tochoose[$random];
				
			}
			
		if (join q { }, $line[3] =~ /[Rr][Ee][Gg]/) {
				
				pm 'http://cache.gawker.com/assets/images/9/2010/01/reggie_notmyproblem.jpg';
				
			}
			
			
			
		if (join q{ }, @line[3..$#line] =~ /[Dd][Aa][Dd]/) {
				pm 'http://stickerish.com/wp-content/uploads/2011/04/TrollDadBlackSS.png';
				
			}
			
		if (join q{ }, @line[3..$#line] =~ /[Bb][Ii][Ll][Ll]/) {
				pm 'http://enragedbaboon.net/wp-content/uploads/2010/10/4dce75c132082f3798fe7185371b671a.jpg';
				
			}
			
		if (join q{ }, @line[3..$#line] =~ /[Tt][Rr][Oo][Ll]/) {
				pm 'http://2.bp.blogspot.com/-DyM9pwDLrok/TmAl42dkP_I/AAAAAAAAAC0/6LKxe1E-CgU/s400/troll-dance.+.gif';
				
			}
			
			
		if (join q{ }, @line[3..$#line] =~ /[Ss][Pp][Aa][Mm]/) {
				
				pm 'http://www.spam.com/';
				
			}
			
			if ($line[3] =~ /^:[Aa][Cc][Ee]/) {
				
				pm 'http://www.ace-spades.com/play/';
				
			}
			
			if ($line[3] =~ /^:[oO][hH]/) {
				pm 'http://bin.smwcentral.net/u/9801/Oh-SoundBible.com-1138238845.wav';
			}
			
		if (join q{ }, @line[3..$#line] =~ /[lL][iI][Ss][Tt][Ee][Nn]/) {
				pm 'http://28.media.tumblr.com/tumblr_lv12hldozP1r5cjoso1_500.jpg';
			}
			
			if ($line[3] =~ /^:[Nn][Oo][Ss][Ee]/) {
				pm 'http://fc09.deviantart.net/fs16/f/2007/183/2/c/Oh_Nose_by_sackrilige.jpg';
			}
			
			
		if (join q{ }, @line[3..$#line] =~ /NES/) {
				pm 'SNES is best!';
			}
			
		if (join q{ }, @line[3..$#line] =~ /SNES/) {
				pm 'Yes to the SNES!!';
			}
			
		if (join q{ }, @line[3..$#line] =~ /[cC][Aa][Ii][Ll][Ll][Oo][Uu]/) {
				pm 'http://coloringpagesforkids.info/wp-content/uploads/2008/12/caillou-300x289.gif';
			}
			
		if (join q{ }, @line[3..$#line] =~ /[Dd][Oo][Rr][Aa]/) {
				pm 'http://3.bp.blogspot.com/-d_GF8pp0qU4/T3dF7YBsmYI/AAAAAAAADts/KCJCGYu2XSA/s1600/Dora-1.jpg';
			}
			
			if ($line[3] =~ /^:yu/) {pm 'http://memecrunch.com/image/4edbbd471861334a68000000.jpg';}
			
		if (join q{ }, @line[3..$#line] =~ /CRUSH/) {
				pm 'http://www.youtube.com/watch?v=gCKjctTWIsw';
				
			}
			
			#if ($line[3] =~ /[Aa][Dd][Dd]/) {
				
				#my $words = join q{ }, @line[4..$#line];
				
				
				
				
				
				
				#open (MYFILE, '>>lol.txt');
				#print MYFILE "$words\n";
				#close (MYFILE);
				
				#pm 'Added.';
				#$okok++;
				
				
				
				
			#}
			
		if (join q{ }, @line[3..$#line] =~ /[Ss][Cc][Aa][Rr][Yy]/) {
				
				pm 'http://t2.gstatic.com/images?q=tbn:ANd9GcSJY1xel5uzBuNoUtVyE5BI1y3IqKeX5hUx-Z96zVW2ShJJUpoYOg';
				
			}
			
		if (join q{ }, @line[3..$#line] =~ /[Ss][Qq][Uu][Ii][Dd]/) {
				
				pm 'https://encrypted-tbn0.google.com/images?q=tbn:ANd9GcQCliO3wRO9scFUCgs1CT3r9sBZB_sKek3p25UMZXFngReU8DC3Uw';
				
			}
			
		if (join q{ }, @line[3..$#line] =~ /EPIC/) {
				pm 'http://cache.ohinternet.com/images/6/61/Crush89.png';
				
			}
			
		if (join q{ }, @line[3..$#line] =~ /[Rr][Oo][Ll][Ff]/) {
				
				pm 'http://images.wikia.com/ed/images/7/77/Rolf.JPG';
				
			}
			
		if (join q{ }, @line[3..$#line] =~ /[Zz][Ee][Ll][Dd][Aa]/) {
				
			pm 'http://i2.ytimg.com/i/qU2__YKIQw5_CqHUPhN5Ew/1.jpg?v=4f8a7291'; }
			
		if (join q{ }, @line[3..$#line] =~ /[Bb][Ee][Aa][Nn]/) {
				pm 'https://encrypted-tbn0.google.com/images?q=tbn:ANd9GcQK6SXZCjTugQc4-PvVRYUGPwxTIbNhd1ozFtXeHSu1TL__ePMBKQ';
				
			}
			
		if (join q{ }, @line[3..$#line] =~ /[Dd][Ii][Ss][Tt][Rr][Aa][Cc][Tt][Ii][Nn][Gg]/) {
				
			pm 'http://bin.smwcentral.net/u/9801/yu.png'; }
			
			if ($line[3] =~ /^:YU_says:/) {
				
				my $hello = join q{ }, @line[3..$#line];
				
				pm $hello;
				
				
			}
			
			
			if ($line[3] =~ /![Tt][Aa][Ll][Kk]/) {
				
				
				my $hello = join q{ }, @line[4..$#line];
				
				
				
				$mech->field("vText1", $hello);
				
				
				$mech->submit();
				
				my $title = $mech->title();
				
				if ($title && $title !~ /- An Artificial Intelligence chatbot, AI chatterbot or chatterbox, for online chatting, talk, chats, talking, think, thought, thoughts, converse,dialogue,dialog,conversation/) {
					our @response = split(/ - /, $title);
					
					pm $response[2];
					} else {
					
					my $many = @tosaydo;
					
					pm $tosaydo[int(rand($many))];
					
					
				}
			}
			
			
			
			
		}
		
		
	}
	
	
	
}





close($socket);