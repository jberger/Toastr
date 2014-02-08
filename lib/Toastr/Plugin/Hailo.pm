package Toastr::Plugin::Hailo;

use Mojo::Base 'Toastr::Plugin';

BEGIN { $ENV{ANY_MOOSE} = 'Moose' }
use Hailo;

has brain => 'toastr.db';
has hal => sub { Hailo->new( brain => shift->brain ) };

sub register {
  my $self = shift;

  $self->irc->on( toastr_direct_message => sub {
    my ($irc, $chan, $text, $msg) = @_;
    if ($text =~ /\?/) {
      my $reply = $irc->hailo->hal->reply($text);
      $irc->msg( $chan => $reply ) if $reply;
    } elsif ($text =~ s/^\+//) {
      $irc->hailo->hal->learn($text);
    }
  });
}

1;

