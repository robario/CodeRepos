#
# $Id$
#
package Catalyst::Controller::Delegate;
use strict;
use warnings;
use utf8;
use version; our $VERSION = qv('0.0.1');

use base qw(Catalyst::Controller);

use LWP::UserAgent;
use URI::Escape;

sub cascade : LocalRegexp('^-_-') {
    my ( $self, $c ) = @_;

    my $method = $c->req->method;

    my $uri = substr $c->req->uri,
      length $c->req->base . $c->namespace . '/-_-';
    if ( $uri =~ /%3A%2F%2F/msx ) {
        $uri = uri_unescape($uri);
    }

    my $headers = do {
        my $headers = $c->req->headers->clone;
        my ($host) = $uri =~ m{^[a-zA-Z]+://([^/]*)}msx;
        $headers->header( 'Host', $host );
        $headers;
    };

    my $body = do {
        my @body;
        foreach my $name ( keys %{ $c->req->body_params } ) {
            if ( ref $c->req->body_params->{$name} eq 'ARRAY' ) {
                foreach my $value ( @{ $c->req->body_params->{$name} } ) {
                    push @body, $name . q{=} . $value;
                }
            }
            else {
                push @body, $name . q{=} . $c->req->body_params->{$name};
            }
        }
        join q{&}, @body;
    };

    my $request  = HTTP::Request->new( $method, $uri, $headers, $body );
    my $ua       = LWP::UserAgent->new;
    my $response = $ua->simple_request($request);
    ### $response

    # TODO: $c->res->cookies;

    $c->res->status( $response->code );
    $response->headers->scan(
        sub {
            my ( $field, $value ) = @_;
            if ( $c->res->headers->header($field) ) {
                $c->res->headers->push_header( $field => $value );
            }
            else {
                $c->res->headers->header( $field, $value );
            }
        }
    );
    $c->res->body( $response->content );

    return 1;
}

1;

__END__

=head1 NAME

Catalyst::Controller::Delegate - It simulates the delegate.

=head1 VERSION

This document describes Catalyst::Controller::Delegate version 0.0.1

=head1 SYNOPSIS

    use Catalyst::Controller::Delegate;

=head1 DESCRIPTION

=head1 SUBROUTINES/METHODS

=head2 cascade

It simulates the delegate.

=head1 DIAGNOSTICS

=over

=back

=head1 CONFIGURATION AND ENVIRONMENT

Catalyst::Controller::Delegate requires no configuration files or environment variables.

=head1 DEPENDENCIES

None.

=head1 INCOMPATIBILITIES

None reported.

=head1 BUGS AND LIMITATIONS

No bugs have been reported.

Please report any bugs or feature requests to
C<bug-catalyst-controller-delegate@rt.cpan.org>, or through the web interface at
L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=Catalyst-Controller-Delegate>.
I will be notified, and then you'll automatically be notified of progress on
your bug as I make changes.

=head1 AUTHOR

Hironori Yoshida <yoshida@cpan.org>

=head1 LICENSE AND COPYRIGHT

This module is free software; you can redistribute it and/or
modify it under the same terms as Perl itself. See L<perlartistic>.

=cut
