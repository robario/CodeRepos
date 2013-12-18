#
# $Id$
#
package Catalyst::Engine::FastCGI::Lighttpd;
use strict;
use warnings;
use utf8;
use version; our $VERSION = qv('0.0.1');

use parent qw(Catalyst::Engine::FastCGI);

sub prepare_path {
    my ( $self, $c, @arguments ) = @_;

    my $env_ref = $self->env || \%ENV;

    ( $env_ref->{PATH_INFO}, $env_ref->{QUERY_STRING} ) =
      ( split /\?/msx, $env_ref->{REQUEST_URI}, 2 );

    $env_ref->{HTTP_X_FORWARDED_HOST} ||= $env_ref->{HTTP_X_HOST};

    return $self->SUPER::prepare_path($c, @arguments);
}

1;

__END__

=head1 NAME

Catalyst::Engine::FastCGI::Lighttpd - FastCGI engine specializes in Lighttpd.

=head1 VERSION

This document describes Catalyst::Engine::FastCGI::Lighttpd version 0.0.1

=head1 SYNOPSIS

    # 1. in your script/myapp_fastcgi.pl or MyApp.pm
    BEGIN { $ENV{CATALYST_ENGINE} = 'FastCGI::Lighttpd' }
    
    #    when lighttpd is behind proxy
    __PACKAGE__->config( using_frontend_proxy => 1 );
    
    # 2. in your lighttpd.conf
    server.error-handler-404 = "DISPATCH_TO_CATALYST"
    fastcgi.server = ( "DISPATCH_TO_CATALYST" =>
                       (( "socket" => "/path/to/myapp.socket",
                          "bin-path" => "/usr/bin/perl /path/to/myapp_fastcgi.pl",
                          "check-local" => "disable" )))

=head1 DESCRIPTION

C::E::FastCGI could not treat with PATH_INFO and QUERY_STRING correctly.
This module enables it.

=head1 SUBROUTINES/METHODS

=head2 prepare_path( $self, $c, @arguments )

It rebuild PATH_INFO and QUERY_STRING from REQUEST_URI.
And set HTTP_X_FORWARDED_HOST if lighttpd behind proxy.

=head1 DIAGNOSTICS

None.

=head1 CONFIGURATION AND ENVIRONMENT

Catalyst::Engine::FastCGI::Lighttpd requires no configuration files or environment variables.

=head1 DEPENDENCIES

None.

=head1 INCOMPATIBILITIES

None reported.

=head1 BUGS AND LIMITATIONS

No bugs have been reported.

Please report any bugs or feature requests to
C<bug-catalyst-engine-fastcgi-lighttpd@rt.cpan.org>, or through the web interface at
L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=Catalyst-Engine-FastCGI-Lighttpd>.
I will be notified, and then you'll automatically be notified of progress on
your bug as I make changes.

=head1 AUTHOR

Hironori Yoshida <yoshida@cpan.org>

=head1 LICENSE AND COPYRIGHT

This module is free software; you can redistribute it and/or
modify it under the same terms as Perl itself. See L<perlartistic>.

=cut
