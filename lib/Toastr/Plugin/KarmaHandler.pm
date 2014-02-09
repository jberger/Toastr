package Toastr::Plugin::KarmaHandler;

use Mojo::Base 'Toastr::Plugin';

use DBM::Deep ();

has db => 'karma.db';
has karma => sub { DBM::Deep->new( shift->db ) };

sub leaderboard {
  my $self = shift;
  my $karma = $self->karma;
  my $leaders = join ', ', 
    map  { "$_->[0]: $_->[1]" }
    sort { $b->[1] <=> $a->[1] }
    map  { [ $_ => $karma->{$_} ] }
    keys %$karma;
  return $leaders;
}

sub register {
  my ($self, $irc) = @_;
  my $nick_ptn = $irc->nick_ptn;

  $irc->on( toastr_privmsg => sub {
    my ($irc, $msg) = @_;
    my $text = $msg->text;

    if ($text =~ /$nick_ptn\+\+/) {
      $irc->emit( karma_handler_up => $1, $msg );
    }

    if ($text =~ /$nick_ptn\-\-/) {
      $irc->emit( karma_handler_down => $1, $msg );
    }
  });

  $irc->on( toastr_direct_message => sub {
    my ($irc, $msg) = @_;
    if ($msg->text =~ /karma\s+$nick_ptn/) {
      $irc->emit( karma_handler_query => $1, $msg );
    }
  });

  $irc->on( karma_handler_up => sub {
    my ($irc, $user, $msg) = @_;
    $irc->karma_handler->karma->{$user}++;
  });

  $irc->on( karma_handler_down => sub {
    my ($irc, $user, $msg) = @_;
    $irc->karma_handler->karma->{$user}--;
  });

  $irc->on( karma_handler_query => sub {
    my ($irc, $user, $msg) = @_;
    my $chan = $msg->chan;
    my $handler = $irc->karma_handler;
    if ($user eq '__leaders__' && $chan !~ /^#/) { # no __leaders__ in channel
      my $leaders = $handler->leaderboard;
      $irc->msg( $chan, $leaders );
      return;
    }
    my $karma = $handler->karma->{$user} || 'no';
    $irc->msg( $chan, "$user has $karma karma" );
  });
}

1;

