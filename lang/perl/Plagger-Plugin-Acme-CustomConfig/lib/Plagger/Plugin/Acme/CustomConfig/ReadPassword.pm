#
# $Id$
#
package Plagger::Plugin::Acme::CustomConfig::ReadPassword;
use strict;
use warnings;
use utf8;
use version; our $VERSION = qv('0.0.1');

use Term::ReadKey;

sub run {
    my ( $class, $data ) = @_;

    if ( exists $data->{prompt} ) {
        printf {*STDERR} '%s [%s] ', $data->{prompt}, $data->{default};
    }

    my $value;
    eval {
        ReadMode('noecho');
        $value = ReadLine(0);
        chomp $value;
    } or undef $value;
    ReadMode(0);
    if ( !$value ) {
        $value = $data->{default};
    }
    return $value;
}

1;

__END__

=head1 NAME

Plagger::Plugin::Acme::CustomConfig::ReadPassword - CustomConfig plugin

=head1 VERSION

This document describes Plagger::Plugin::Acme::CustomConfig::ReadPassword version 0.0.1

=head1 SYNOPSIS

L<Plagger::Plugin::Acme::CustomConfig>

=head1 DESCRIPTION

Acme::CustomConfig plugin.

=head1 SUBROUTINES/METHODS

=head2 run(\%config)

Read the password and return it.

Show prompt if exists %config{prompt}.

=head1 DIAGNOSTICS

None.

=head1 CONFIGURATION AND ENVIRONMENT

Plagger::Plugin::Acme::CustomConfig::ReadPassword requires no configuration files or environment variables.

=head1 DEPENDENCIES

L<Term::ReadKey>

=head1 INCOMPATIBILITIES

None reported.

=head1 BUGS AND LIMITATIONS

No bugs have been reported.

Please report any bugs or feature requests to
C<bug-plagger-plugin-acme-customconfig@rt.cpan.org>, or through the web interface at
L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=Plagger-Plugin-Acme-CustomConfig>.
I will be notified, and then you'll automatically be notified of progress on
your bug as I make changes.

=head1 AUTHOR

Hironori Yoshida <yoshida@cpan.org>

=head1 LICENSE AND COPYRIGHT

This module is free software; you can redistribute it and/or
modify it under the same terms as Perl itself. See L<perlartistic>.

=cut
