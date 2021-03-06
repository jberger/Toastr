package Toastr;
use Mojo::Base 'Mojo::IRC';

our $VERSION = '0.01';
$VERSION = eval $VERSION;

use IRC::Utils ();
use Toastr::Message;

has channels => sub { [ '#toastr' ] };
has nick_ptn => sub { qr/\b([a-z_\-\[\]\\^{}|`]+)\b/i };
has plugins  => sub { {} };

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

sub load_plugin {
  my ($self, $name, $args) = @_;
  my $module = "Toastr::Plugin::$name";
  die $@ unless eval "require $module; 1";
  my $plugin = $module->new($args || {});
  $plugin->register($self);
  $self->plugins->{$name} = $plugin;
  return $plugin;
}

sub msg { shift->write( privmsg => shift, ":@_" ) }

sub plugin {
  my ($self, $name, $args) = @_;
  if (exists $self->plugins->{$name}) {
    return $self->plugins->{$name};
  }
  return $self->load_plugin($name, $args);
}

sub start {
  my ($irc) = @_;
  $irc->attach;
  $irc->ioloop->start;
}

sub _parse_user { IRC::Utils::parse_user($_[1]->{prefix}) }

sub _privmsg {
  my ($irc, $msg) = @_;
  my ($chan, $text) = @{ $msg->{params} };

  my $nick = $irc->nick;
  my $is_pm = 0;

  if ($chan eq $nick) {
    $chan = $irc->_parse_user($msg);
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

 #!/usr/bin/env perl

 use Mojo::Base -strict;
 use Toastr;

 my $toastr = Toastr->new(
   channels => ['#toastr'],
   nick     => 'toastr',
   user     => 'toastr bot',
   server   => 'irc.perl.org:6667', 
 );

 $toastr->plugin('KarmaHandler');
 $toastr->plugin('Toast');
 $toastr->plugin('Hailo');
 $toastr->start;

=head1 DESCRIPTION

L<Toastr> is a subclass of L<Mojo::IRC> implementing a simple pluggable IRC bot.
The base class attaches additional events which are emitted when the bot sees and/or receives a message.
The events receive an instance of L<Toastr::Message> containing lots of useful information about the message.
L<Toastr>'s built-in events are prefixed with C<toastr_> and L<Mojo::IRC>'s events are prefixed with C<irc_>.

Plugins are subclasses of L<Toastr::Plugin>.
A plugin will most likely subscribe to one or more event, then either take some action on that event, or even emit events of its own.
Plugins namespace must be of the form C<< Toastr::Plugin::<PluginName> >>.
When loaded, the plugin instance will be stored in a the C<plugins> attribute named, keyed on the plugin name.
The convenience method L</plugin> may be used to access the plugin and load it if necessary.

=head1 EVENTS

L<Toastr> inherits all of the events from L<Mojo::IRC> and emits the following new ones:

=head2 toastr_message

 $toastr->on( toastr_message => sub {
   my ($toastr, $message) = @_;
   ...
 });

Emitted for every message that the bot sees.

=head2 toastr_direct_message

 $toastr->on( toastr_direct_message => sub {
   my ($toastr, $message) = @_;
   ...
 });

Emitted for every private message (pm) or message prefixed with the bot's nick (the nick 
and an optional punctuation mark will be stripped from the message).

=head1 ATTRIBUTES

L<Toastr> inherits all of the attributes from L<Mojo::IRC> and implements the following new ones:

=head2 channels

An array reference of channels to connect to.

=head2 nick_ptn

A C<qr> regex which is used to extract valid nicks.
This probably does not need to be changed from its default.

=head2 plugins

Holds instances of loaded plugins, keyed by plugin name.
This attribute should not be changed manually, use the methods L</plugin> and C</load_plugin>.

=head1 METHODS

L<Toastr> inherits all of the methods from L<Mojo::IRC> and implements the following new ones.

=head2 attach

 $toastr->attach;

This method must be called to subscribe to the necessary events and connect to the server.
Note that the convenience method L</start> calls this method for you.

=head2 load_plugin

 $toastr->load_plugin('PluginName' => { attr => $val, attr => $val, ... });

Loads plugin C<PluginName> and creates an instance.
An optional hash reference is used to set attributes on the plugin.
The instance is stored in the C</plugins> hash.

Note that this may be used to replace the instance if desired.

=head2 msg

 $toastr->msg( $chan => $text, $text, ... );

Send a C<privmsg> to the server and channel C<$chan>.
The text of the message is all trailing arguments (joined by C<$">).

=head2 plugin

 $toastr->plugin('PluginName' => { attr => $val, attr => $val, ... });

Returns either the cached instance of the plugin or constructs one if necessary using L</load_plugin>.
If the plugin is already loaded, the constructor hash is ignored.

=head1 SEE ALSO

=over

=item L<Mojo::IRC>

=item L<Mojo::IOLoop>

=item L<Mojolicious>

=back

=head1 SOURCE REPOSITORY

L<http://github.com/jberger/Toastr> 

=head1 AUTHOR

Joel Berger, E<lt>joel.a.berger@gmail.comE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2014 by Joel Berger

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

