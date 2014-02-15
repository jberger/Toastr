package Toastr;
use Mojo::Base 'Mojo::IRC';

use IRC::Utils ();
use Mojo::Util 'decamelize';
use Toastr::Message;

has channels => sub { [ '#toastr' ] };
has nick_ptn => sub { qr/\b([a-z_\-\[\]\\^{}|`]+)\b/i };

sub attach {
  my ($irc) = @_;
  $irc->register_default_event_handlers;

  $irc->on( irc_privmsg => \&_privmsg );
  $irc->on( irc_error => sub { warn $_[1] });

  $irc->connect(sub{
    my ($irc, $err) = @_;
    return warn $err if $err;
    my $chans = $irc->channels;
    $irc->write( join => $_ ) for @$chans;
  });
}

sub msg { shift->write( privmsg => shift, ":@_" ) }

sub parse_user { IRC::Utils::parse_user($_[1]->{prefix}) }

sub plugin {
  my ($self, $name, $args) = @_;
  my $module = "Toastr::Plugin::$name";
  return unless eval "require $module; 1";
  my $plugin = $module->new($args || {});
  $plugin->register($self);
  $self->attr(decamelize($name) => sub { $plugin });
  return $plugin;
}

sub start {
  my ($irc) = @_;
  $irc->attach;
  $irc->ioloop->start;
}

sub _privmsg {
  my ($irc, $msg) = @_;
  my ($chan, $text) = @{ $msg->{params} };

  my $nick = $irc->nick;
  my $is_pm = 0;

  if ($chan eq $nick) {
    $chan = $irc->parse_user($msg);
    $is_pm = 1;
  }

  my $is_direct = 0;
  if ($text =~ s/^\Q$nick\E\S*\s*// or $is_pm) {
    $is_direct = 1;
  }

  my $message = Toastr::Message->new(
    chan      => $chan,
    text      => $text,
    is_pm     => $is_pm,
    is_direct => $is_direct,
    msg       => $msg,
  );

  $irc->emit( toastr_message => $message );

  $irc->emit( toastr_direct_message => $message ) if $is_direct;
}

1;

=head1 NAME

Toastr - The simple pluggable IRC bot

=head1 SYNOPSIS

 use Toastr;
 my $toastr = Toastr->new
