package Mojolicious::Plugin::PodTemplates::Renderer;

use Mojo::Base 'Mojolicious::Renderer';

use Mojolicious::Plugin::PodTemplates::Loader;

has 'pods' => sub { };

sub get_data_template {
    my ($self, $options) = @_;
    my $template = $self->SUPER::get_data_template($options);
    return $template if $template;
 
    # Index POD templates
    my $loader = Mojolicious::Plugin::PodTemplates::Loader->new;
    unless ($self->{pod_index}) {
        my $index = $self->{pod_index} = {};
        for my $class (reverse @{$self->classes}) {
            $index->{$_} = $class for keys %{$loader->pod($class)};
        }
    }
 
    # Find template
    $template = $self->template_name($options);
    return $loader->pod($self->{pod_index}{$template}, $template);
}
 
sub _detect_handler {
    my ($self, $options) = @_;

    # Default behaviour
    my $detected = $self->SUPER::_detect_handler($options);
    return $detected if $detected;

    return undef unless my $file = $self->template_name($options);

    unless ($self->{pods}) {
        my $loader = Mojolicious::Plugin::PodTemplates::Loader->new;
        my @templates = map { sort keys %{$loader->pod($_)} } @{$self->classes};
        s/\.(\w+)$// and $self->{pods}{$_} ||= $1 for @templates;
    }

    return $self->{pods}{$file} if exists $self->{pods}{$file};

    # Nothing
    return undef;
}



1;
