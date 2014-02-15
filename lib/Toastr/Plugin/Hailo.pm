package Toastr::Plugin::Hailo;

use Mojo::Base 'Toastr::Plugin';

BEGIN { $ENV{ANY_MOOSE} = 'Moose' }
use Hailo;

use constant NAME => 'Hailo';

has brain => 'toastr.db';
has hal   => sub { Hailo->new( brain => shift->brain ) };
has reply => sub { sub { $_[1] } };
has learn => sub { sub { $_[1] unless $_[1] =~ /\?/ } };

sub register {
  my ($self, $irc) = @_;

  $irc->on( toastr_message => sub {
    my ($irc, $msg) = @_;
    return if $msg->handled; # don't reply on a previously handled message

    my $self  = $irc->plugin(NAME);
    my $learn = $self->learn;
    my $l = $self->$learn($msg->text, $msg);
    return unless defined $l;
    $self->hal->learn($l);
  });

  $irc->on( toastr_direct_message => sub {
    my ($irc, $msg) = @_;
    return if $msg->handled; # don't reply on a previously handled message

    my $self  = $irc->plugin(NAME);
    my $reply = $self->reply;
    my $r = $self->$reply($msg->text, $msg);
    return unless defined $r;
    my $response = $self->hal->reply($r);
    $irc->msg( $msg->chan => $response ) if $response;
  });
}

1;

