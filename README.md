# NAME

Mojolicious::Plugin::PodTemplates - Embed templates as POD sections

# SYNOPSIS

    # Mojolicious
    $self->plugin('PodTemplates');
    push @{ $self->renderer->classes }, "MyApp::Templates::SomeClass";

    # or also:
    $self->plugin( PodTemplates => "MyApp::Templates::SomeClass" );


    # Mojolicious::Lite
    plugin 'PodTemplates'; # see t/basic.t

# DESCRIPTION

[Mojolicious::Plugin::PodTemplates](https://metacpan.org/pod/Mojolicious::Plugin::PodTemplates) is a [Mojolicious](https://metacpan.org/pod/Mojolicious) plugin which extends
the current Renderer to allow loading templates from POD sections, in a similar
way it's done for the DATA sections.

While this is rather retarded, the idea of making them part of the documentation
can come handy, for example, if you provide default templates meant for overriding
on a plugin or base controller class.

# POD HANDLING

This plugin uses [Pod::Snippets](https://metacpan.org/pod/Pod::Snippets) to extract POD sections from the files, and
uses the markup keyword "template" for this purpose. This means that you need
to wrap all the template bits in **=for** commands, and enter the content of
the template on a **verbatim** section.

## Examples

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

## (Bugs|Features) of using POD for templates

There's some things that come along with using PODs for embedding templates:

- HTML in POD does not really render nicely on docs

    This depends solely on what you're using to read your PODs. By detecting the
    wrappers it should be fairly simple to **prettyprint** those. :)

# METHODS

[Mojolicious::Plugin::PodTemplates](https://metacpan.org/pod/Mojolicious::Plugin::PodTemplates) inherits all methods from
[Mojolicious::Plugin](https://metacpan.org/pod/Mojolicious::Plugin) and implements the following new ones.

## register

    $plugin->register(Mojolicious->new);

Register plugin in [Mojolicious](https://metacpan.org/pod/Mojolicious) application.

# SEE ALSO

[Mojolicious](https://metacpan.org/pod/Mojolicious), [Mojolicious::Guides](https://metacpan.org/pod/Mojolicious::Guides), [http://mojolicio.us](http://mojolicio.us).

# AUTHOR

Quim Rovira, `<quim at rovira.cat>`

# LICENSE AND COPYRIGHT

This program is free software; you can redistribute it and/or modify it
under the terms of either: the GNU General Public License as published
by the Free Software Foundation; or the Artistic License.

See http://dev.perl.org/licenses/ for more information.

# POD ERRORS

Hey! **The above document had some coding errors, which are explained below:**

- Around line 130:

    Unknown directive: =AUTHOR
