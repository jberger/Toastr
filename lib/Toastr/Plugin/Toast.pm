package Toastr::Plugin::Toast;

use Mojo::Base 'Toastr::Plugin';

use Mojo::Collection 'c';
use Mojo::UserAgent;

has toast_images => sub { c() };
has toast_messages => sub { c(
    'mmmmmm toast.',
    'A toast!',
    'Somebody wants toast?',
    'Toast here!',
    q[What's all this about toast?],
)};
has toast_sites => sub {[
  'http://memebase.cheezburger.com/tag/toast/page/1',
  'http://memebase.cheezburger.com/tag/toast/page/2',
  'http://memebase.cheezburger.com/tag/toast/page/3',
]};
has ua => sub { Mojo::UserAgent->new };

sub get_toast_images {
  my ($self, $site) = @_;
  $site ||= shift @{ $self->toast_sites };
  unless ($site) {
    $self->toast_images( $self->toast_images->compact->uniq );
    return;
  }
  my $c = $self->toast_images;
  $self->ua->get( $site => sub {
    my ($ua, $tx) = @_;
    my $images = $tx->res->dom('.event-item-lol-image')->pluck(attr => 'src');
    push @$c, @$images;
    $self->get_toast_images;
  });
}

sub register {
  my ($self, $irc) = @_;
  $irc->on( toastr_toast => sub {
    my ($irc, $chan, $text, $msg) = @_;
    $irc->toast->send_toast($irc, $chan);
  });
  $self->get_toast_images; # populate (once the iolooop starts)
}

sub send_toast {
  my ($self, $irc, $chan) = @_;
  my $prefix = $self->toast_messages->shuffle->[0];
  my $image  = $self->toast_images->shuffle->[0];
  $irc->msg( $chan => "$prefix $image" );
}

1;

