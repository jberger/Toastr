package Toastr::Message;

use Mojo::Base -base;

has [qw/chan msg/];
has [qw/is_pm is_direct/] => 0;
has handled_by => sub { [] };
has text => '';

sub handled { 
  my $self = shift;
  my $h = $self->handled_by;
  return !! @$h unless @_;
  push @$h, shift;
}


1;

