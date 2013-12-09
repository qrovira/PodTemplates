package Mojolicious::Plugin::PodTemplates::Loader;

use Mojo::Base 'Mojo::Loader';
use Pod::Tree;

my (%BIN, %CACHE);

sub pod { $_[1] ? $_[2] ? _all_pod($_[1])->{$_[2]} : _all_pod($_[1]) : undef }

sub _all_pod {
    my $class = shift;

    my $handle = do { no strict 'refs'; \*{"${class}::DATA"} };
    return $CACHE{$class} || {} if $CACHE{$class} || !fileno $handle;;
    seek $handle, 0, 0;

    my $all = $CACHE{$class} = {};
    my $in_template_section=0;
    my $name;
    my $tree = Pod::Tree->new;
    $tree->load_fh($handle);

    foreach my $node ( @{ $tree->get_root->get_children } ) {
        if( $node->is_c_head1 ) {
            $in_template_section = $node->{text} =~ m#template#i;
            next;
        }
        if( $in_template_section && $node->is_c_head2 ) {
            my $text = $node->{text};
            $text =~ s#[\n\r]+$##;
            $name = $text =~ m/ - (.*)$/ ? $1 : $text;
            $BIN{$class}{$name} = $name =~ s/\s*\(\s*base64\s*\)$//;
            next;
        }

        if( defined($name) ) {
            if( $node->is_verbatim ) {
                my $data = $node->{text};
                $data =~ s#[\n\r]{1,2}$##;
                $data =~ s#^  ##mg;
                $all->{$name} = ($all->{$name} // ""). $data;
            } elsif( ! $node->is_ordinary ) {
                undef $name;
            }
        }
    }

    foreach( grep { $BIN{$class}{$_} } keys %{ $BIN{$class} } ) {
        eval { $all->{$_} = b64_decode($all->{$_}); };
    }

    return $all;
}

1;
