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

L<Mojolicious::Plugin::PodTemplates> is a L<Mojolicious> plugin which replaces
the current Renderer to allow loading templates from POD sections, in a similar
way it's done for the DATA sections.

While this is rather retarded, the idea of making them part of the documentation
can come handy, for example, if you provide default templates meant for overriding
on a plugin or base controller class.

=head1 POD HANDLING

=over

=item Template groups are identified by B<head1> sections mentioning the word
"template".

=item Templates are identified by B<head2> sections, and contain the template
path on the header (optionally after the "-" character)

=item Contents of the template are contained in B<verbatim> sections (e.g:
indented using 2 spaces)

=back

=head2 Example file

  =head1 Test templates
  
  =head2 hello.html.ep
  
    <b>Hello, Mojo!</b>
  
  =head2 howdy.html.ep
  
    %layout 'layout';
    <b>Howdy, <%= $visitor %>!</b>
  
  =head2 layouts/layout.html.ep
  
    <h2>From layout:</h2>
    <%= content %>
  
  =cut

=head2 (Bugs|Features) of using POD for templates

There's some things that come along with using PODs for embedding templates:

=over

=item For verbatim sections, you'll need to indent all template lines with 2 empty spaces

FWIW, this is even nice, I regularly use 2 space indention on html, and the verbatim indent
allows me to read the template files easily.
You can also use a vim modeline like "# vim: noai:ts=2:sw=2" for setting the defaults.

=item HTML in POD does not really render nicely on docs

This depends solely on what you're using to read your PODs. Mojoliciou's plugin that
supports rendering does highlight those properly. :)

=back

=head1 CAVEATS

=head2 Relying on DATA filehandle

Currently, the detection for a filehandle to read the module source is a very
clumsy copy of the original Mojolicious code for handling DATA sections. Because
of this reason, it relies on the module having a __DATA__ token so Perl will
provide the file handler automatically.

=head1 METHODS

L<Mojolicious::Plugin::PodTemplates> inherits all methods from
L<Mojolicious::Plugin> and implements the following new ones.

=head2 register

  $plugin->register(Mojolicious->new);

Register plugin in L<Mojolicious> application.

=head1 SEE ALSO

L<Mojolicious>, L<Mojolicious::Guides>, L<http://mojolicio.us>.

=cut
