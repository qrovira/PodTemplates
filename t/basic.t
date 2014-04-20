use Mojo::Base -strict;

use Test::More;
use Mojolicious::Lite;
use Test::Mojo;

plugin 'PodTemplates';

get '/hello';
get '/named';
get '/howdy' => sub {
  my $self = shift;
  $self->render(template => 'howdy', visitor => 'Mojo');
};

my $t = Test::Mojo->new;

$t->get_ok('/hello')->status_is(200)->content_is("<b>Hello, Mojo!</b>\n");
$t->get_ok('/named')->status_is(200)->content_is("<b>Hi, Mojo!</b>\n");
$t->get_ok('/howdy')->status_is(200)->content_is("<h2>From layout:</h2>\n<b>Howdy, Mojo!</b>\n\n");

done_testing();

=head1 Test templates

=head2 hello.html.ep

=for template "hello.html.ep" begin

  <b>Hello, Mojo!</b>

=for template "hello.html.ep" end

=head2 Template with name - named.html.ep

=for template "named.html.ep" begin

  <b>Hi, Mojo!</b>

=for template "named.html.ep" end

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

__DATA__
