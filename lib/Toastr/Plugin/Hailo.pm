package Toastr::Plugin::Hailo;

use Mojo::Base 'Toastr::Plugin';

BEGIN { $ENV{ANY_MOOSE} = 'Moose' }
use Hailo;

has brain => 'toastr.db';
has hal => sub {  Hailo->new( brain => shift->brain )};

sub register {
  my $self = shift;

  my $irc=shift;
  
  $irc->on(toastr_privmsg => sub{
    my ($irc, $where, $text, $is_msg) = @_;
      $irc->hailo->hal->learn($text); #learn also if not directly called
    });

  $irc->on( toastr_direct_message => sub {
    my ($irc, $where, $text, $is_msg) = @_;
    if ($text =~ /\?/) {
      my $reply = $irc->hailo->hal->learn_reply($text); #learn and reply
      $irc->msg( $where => $reply ) if $reply;
    } else {
      $irc->hailo->hal->learn($text); #otherwise will learn
    }
  });
}

1;

