use strict;
use warnings;

use ExtUtils::MakeMaker;

WriteMakefile(
  NAME         => 'Mojolicious::Plugin::PodTemplates',
  VERSION_FROM => 'lib/Mojolicious/Plugin/PodTemplates.pm',
  AUTHOR       => 'A Good Programmer <nospam@cpan.org>',
  PREREQ_PM    => {
      'Mojolicious' => '4.58',
      'Pod::Tree'   => '1.17',
  },
  test         => {TESTS => 't/*.t'}
);
