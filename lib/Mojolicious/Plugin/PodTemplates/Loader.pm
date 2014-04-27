package Mojolicious::Plugin::PodTemplates::Loader;

use Mojo::Base 'Mojo::Loader';

use Mojo::Util qw/ class_to_path /;
use Pod::Snippets;

my (%BIN, %CACHE);

sub pod { $_[1] ? $_[2] ? _all_pod($_[1])->{$_[2]} : _all_pod($_[1]) : undef }

sub _all_pod {
    my $class = shift;

    return $CACHE{$class} if $CACHE{$class};

    my $all = $CACHE{$class} = {};

    my $snips;

    # Check if the file has been opened due to __DATA__ first
    local $/="\n";
    my $handle = do { no strict 'refs'; \*{"${class}::DATA"} };
    if( fileno $handle ) {
        seek $handle, 0, 0;
        $snips = Pod::Snippets->load( $handle, -markup => "template" );
    }
    else {
        my $class_file = class_to_path $class;
        $class_file =~ s#::#/#g;
        if( exists $INC{$class_file} ) {
            $snips = Pod::Snippets->load( $INC{$class_file}, -markup => "template" );
        }
    }

    # Bad use of a Pod::Snippets internal.. it could make sense to
    # push a patch to list the names found.
    my %found = map { defined($_) ? %{ $_->{names} // {} } : () }
        @{ $snips->{unmerged_snippets} };

    foreach my $template ( keys %found ) {
        my $tname = $template;
        my $base64 = $template =~ s#\s*\(base64\)$##;

        $all->{$tname} = $base64 ?
            b64_decode( $snips->named($template)->as_data ) :
            $snips->named($template)->as_data;
    }

    return $all;
}

1;
