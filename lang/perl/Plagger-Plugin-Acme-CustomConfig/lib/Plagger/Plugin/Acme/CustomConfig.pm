#
# $Id$
#
package Plagger::Plugin::Acme::CustomConfig;
use strict;
use warnings;
use utf8;
use version; our $VERSION = qv('0.0.1');

use base qw(Plagger::Plugin);

use Carp;
use English qw(-no_match_vars);
use UNIVERSAL::require;

sub register {
    my ( $self, $context ) = @_;

    $context->register_hook( $self, 'plugin.init' => \&init );
    return;
}

sub init {
    my ( $self, $context ) = @_;

    foreach my $i ( 0 .. @{ $context->{plugins} } ) {
        if ( ref $context->{plugins}->[$i] ne __PACKAGE__ ) {
            next;
        }
        $i++;
        my $plugin = $context->{plugins}->[$i];    # $plugin is the next plugin.
        foreach my $ref ( @{ $self->conf } ) {
            my $module = __PACKAGE__ . q{::} . ( keys %{$ref} )[0];
            my $config = ( values %{$ref} )[0];
            $module->require or croak $EVAL_ERROR;
            my $value = $module->run($config);
            if ( defined $value ) {
                $plugin->conf->{ $config->{name} } = $value;
            }
        }
    }
    return;
}

1;

__END__

=head1 NAME

Plagger::Plugin::Acme::CustomConfig - Customize the module config interactively

=head1 VERSION

This document describes Plagger::Plugin::Acme::CustomConfig version 0.0.1

=head1 SYNOPSIS

    - module: Acme::CustomConfig
      config:
        - ReadLine:
            prompt: "Input your username: "
            name: username
        - ReadPassword:
            prompt: "Input your password: "
            name: password

    - module: Acme::CustomConfig
    - module: Subscription::LivedoorReader
      config:
        username:
          Acme::CustomConfig::ReadLine:
            prompt: What is your LDR username?
            default: your-livedoor-id
            order: 1
        password:
          Acme::CustomConfig::ReadPassword:
            prompt: What is your LDR password?
            default: your-password
            order: 2

=head1 DESCRIPTION

Customize the module config interactively.

=head1 SUBROUTINES/METHODS

=head2 register($context)

Register this plugin.

=head2 init($context)

Initialize this plugin.

=head1 DIAGNOSTICS

None.

=head1 CONFIGURATION AND ENVIRONMENT

Plagger::Plugin::Acme::CustomConfig requires no configuration files or environment variables.

=head1 DEPENDENCIES

L<UNIVERSAL::require>

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
