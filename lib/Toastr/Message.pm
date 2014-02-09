package Toastr::Message;

use Mojo::Base -base;

has [qw/chan msg/];
has text => '';
has is_pm => 0;
has handled_by => sub { [] };

sub handled { 
  my $self = shift;
  my $h = $self->handled_by;
  return !! @$h unless @_;
  push @$h, shift;
}


1;

