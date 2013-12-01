package Mojolicious::Plugin::PodTemplates;

use Mojo::Base 'Mojolicious::Plugin';

use Mojolicious::Plugin::PodTemplates::Renderer;

our $VERSION = '0.01';

sub register {
  my ($self, $app, $opts) = @_;

  $app->renderer( Mojolicious::Plugin::PodTemplates::Renderer->new( %{ $app->renderer } ) );
  push @{ $app->renderer->classes }, @{ $opts->{classes} } if $opts->{classes};
}

1;
__END__

=encoding utf8

=head1 NAME

Mojolicious::Plugin::PodTemplates - Mojolicious Plugin

=head1 SYNOPSIS

  # Mojolicious
  $self->plugin('PodTemplates');

  # Mojolicious::Lite
  plugin 'PodTemplates';

=head1 DESCRIPTION

L<Mojolicious::Plugin::PodTemplates> is a L<Mojolicious> plugin.

=head1 METHODS

L<Mojolicious::Plugin::PodTemplates> inherits all methods from
L<Mojolicious::Plugin> and implements the following new ones.

=head2 register

  $plugin->register(Mojolicious->new);

Register plugin in L<Mojolicious> application.

=head1 SEE ALSO

L<Mojolicious>, L<Mojolicious::Guides>, L<http://mojolicio.us>.

=cut
