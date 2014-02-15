#!/usr/bin/env perl

use strict;
use warnings;

use Module::Build;

my $build = Module::Build->new(
  module_name        => 'Toastr',
  dist_author        => 'Joel Berger <joel.a.berger@gmail.com>',
  license            => 'perl',
  configure_requires => { 'Module::Build' => 0.38 },
  requires => {
    'perl'         => '5.10.1',
    'Mojolicious'  => '4.0',
    'Mojo::IRC'    => 0,
    'IRC::Utils'   => 0,
  },
  meta_merge => {
    resources => {
      repository => 'https://github.com/jberger/Toastr',
      bugtracker => 'https://github.com/jberger/Toastr/issues',
    },
  },
);

$build->create_build_script;
