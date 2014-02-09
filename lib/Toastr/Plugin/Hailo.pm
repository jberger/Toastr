package Toastr::Plugin::Hailo;

use Mojo::Base 'Toastr::Plugin';

BEGIN { $ENV{ANY_MOOSE} = 'Moose' }
use Hailo;

has brain => 'toastr.db';
has hal   => sub { Hailo->new( brain => shift->brain ) };
has reply => sub { sub { $_[2] } };
has learn => sub { sub { $_[2] } };

sub register {
  my ($self, $irc) = @_;

  $irc->on( toastr_privmsg => sub {
    my ($irc, $chan, $text, $msg) = @_;
    my $learn = $self->learn;
    my $l = $self->$learn($chan, $text, $msg);
    return unless defined $l;
    $self->hal->learn($l);
  });

  $irc->on( toastr_direct_message => sub {
    my ($irc, $chan, $text, $msg) = @_;
    my $reply = $self->reply;
    my $r = $self->$reply($chan, $text, $msg);
    return unless defined $r;
    my $response = $self->hal->reply($r);
    $irc->msg( $chan => $response ) if $response;
  });
}

1;

