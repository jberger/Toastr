package Toastr::Plugin;

use Mojo::Base -base;
use Scalar::Util;

has 'app';

sub new {
  my $class = shift;
  my $self  = $class->SUPER::new(@_);
  #Scalar::Util::weaken($self->{irc}) if exists $self->{irc};
  return $self;
}

sub register {
  my ($self, $irc) = @_;
}

1;

