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

  <b>Hello, Mojo!</b>

=head2 Template with name - named.html.ep

  <b>Hi, Mojo!</b>

=head2 howdy.html.ep

  %layout 'layout';
  <b>Howdy, <%= $visitor %>!</b>

=head2 layouts/layout.html.ep

  <h2>From layout:</h2>
  <%= content %>

=cut
__DATA__
