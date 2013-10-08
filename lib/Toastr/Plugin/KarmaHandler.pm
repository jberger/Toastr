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

  $irc->on( toastr_karma_up => sub {
    my ($irc, $user, $chan, $msg) = @_;
    $irc->karma_handler->karma->{$user}++;
  });

  $irc->on( toastr_karma_down => sub {
    my ($irc, $user, $chan, $msg) = @_;
    $irc->karma_handler->karma->{$user}--;
  });

  $irc->on( toastr_karma_query => sub {
    my ($irc, $user, $chan, $msg) = @_;
    my $handler = $irc->karma_handler;
    if ($user eq '__leaders__' && $chan !~ /^#/) { # no __leaders__ in room
      my $leaders = $handler->leaderboard;
      $irc->msg( $chan, $leaders );
      return;
    }
    my $karma = $handler->karma->{$user} || 'no';
    $irc->msg( $chan, "$user has $karma karma" );
  });
}

1;

