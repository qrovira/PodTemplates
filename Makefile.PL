use strict;
use warnings;

use ExtUtils::MakeMaker;

WriteMakefile(
  NAME         => 'Mojolicious::Plugin::PodTemplates',
  VERSION_FROM => 'lib/Mojolicious/Plugin/PodTemplates.pm',
  AUTHOR       => 'Quim Rovira <met@cpan.org>',
  PREREQ_PM    => {
      'Mojolicious'   => '4.58',
      'Pod::Snippets' => '0.14',
  },
  test         => {TESTS => 't/*.t'},
  dist         => {
      COMPRESS   => 'gzip -9f',
      SUFFIX     => 'gz',
  },
);
