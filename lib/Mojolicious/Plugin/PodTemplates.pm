package Mojolicious::Plugin::PodTemplates;

use Mojo::Base 'Mojolicious::Plugin';

use Mojolicious::Plugin::PodTemplates::Renderer;

our $VERSION = '0.01';

sub register {
  my ($self, $app, $opts) = @_;

  #jesus fucking christ..
  bless $app->renderer, "Mojolicious::Plugin::PodTemplates::Renderer";

  push @{ $app->renderer->classes }, @{ $opts->{classes} } if $opts->{classes};
}

1;
__END__

=encoding utf8

=head1 NAME

Mojolicious::Plugin::PodTemplates - Embed templates as POD sections

=head1 SYNOPSIS

  # Mojolicious
  $self->plugin('PodTemplates');
  push @{ $self->renderer->classes }, "MyApp::Templates::SomeClass";

  # or also:
  $self->plugin( PodTemplates => "MyApp::Templates::SomeClass" );


  # Mojolicious::Lite
  plugin 'PodTemplates'; # see t/basic.t

=head1 DESCRIPTION

L<Mojolicious::Plugin::PodTemplates> is a L<Mojolicious> plugin which extends
the current Renderer to allow loading templates from POD sections, in a similar
way it's done for the DATA sections.

While this is rather retarded, the idea of making them part of the documentation
can come handy, for example, if you provide default templates meant for overriding
on a plugin or base controller class.

=head1 POD HANDLING

This plugin uses L<Pod::Snippets> to extract POD sections from the files, and
uses the markup keyword "template" for this purpose. This means that you need
to wrap all the template bits in B<=for> commands, and enter the content of
the template on a B<verbatim> section.

=head2 Examples

  =head1 Test templates
  
  =head2 hello.html.ep

  =for template "hello.html.ep" begin
  
    <b>Hello, Mojo!</b>

  =for template "hello.html.ep" end
  
  =head2 howdy.html.ep
  
  =for template "howdy.html.ep" begin
  
    %layout 'layout';
    <b>Howdy, <%= $visitor %>!</b>
  
  =for template "howdy.html.ep" end
  
  =head2 layouts/layout.html.ep
  
  =for template "layouts/layout.html.ep" begin
  
    <h2>From layout:</h2>
    <%= content %>
  
  =for template "layouts/layout.html.ep" end
  
  =cut

=head2 (Bugs|Features) of using POD for templates

There's some things that come along with using PODs for embedding templates:

=over

=item HTML in POD does not really render nicely on docs

This depends solely on what you're using to read your PODs. By detecting the
wrappers it should be fairly simple to B<prettyprint> those. :)

=back

=head1 METHODS

L<Mojolicious::Plugin::PodTemplates> inherits all methods from
L<Mojolicious::Plugin> and implements the following new ones.

=head2 register

  $plugin->register(Mojolicious->new);

Register plugin in L<Mojolicious> application.

=head1 SEE ALSO

L<Mojolicious>, L<Mojolicious::Guides>, L<http://mojolicio.us>.

=head1 AUTHOR

Quim Rovira, C<< <quim at rovira.cat> >>

=head1 LICENSE AND COPYRIGHT

This program is free software; you can redistribute it and/or modify it
under the terms of either: the GNU General Public License as published
by the Free Software Foundation; or the Artistic License.

See http://dev.perl.org/licenses/ for more information.


=AUTHOR

=cut
