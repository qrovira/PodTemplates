use strict;
use warnings;

use ExtUtils::MakeMaker;

my $preop = 'perldoc -uT $(VERSION_FROM) | tee $(DISTVNAME)/README.pod > README.pod';

WriteMakefile(
  NAME         => 'Mojolicious::Plugin::PodTemplates',
  VERSION_FROM => 'lib/Mojolicious/Plugin/PodTemplates.pm',
  AUTHOR       => 'A Good Programmer <nospam@cpan.org>',
  PREREQ_PM    => {
      'Mojolicious'   => '4.58',
      'Pod::Snippets' => '0.14',
  },
  test         => {TESTS => 't/*.t'},
  dist         => {
      COMPRESS   => 'gzip -9f',
      SUFFIX     => 'gz',
      PREOP      => $preop,
  },
);
