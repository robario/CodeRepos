#
# $Id$
#
package Plagger::Plugin::Acme::CustomConfig_experiment;
use strict;
use warnings;
use utf8;
use version; our $VERSION = qv('0.0.1');

use base qw(Plagger::Plugin);

use Carp;
use UNIVERSAL::require;

sub register {
    my $self = shift;

    sub can_handle {
        my ($data) = @_;
        return ref $data eq 'HASH'
          && ( keys %{$data} )[0] =~ /^Acme::CustomConfig::/msx;
    }

    sub by_order {
        my ( $data, $a, $b ) = @_;
        my $order_max = 999;
        return ( ( values %{ $data->{$a} } )[0]->{order} || $order_max )
          <=> ( ( values %{ $data->{$b} } )[0]->{order} || $order_max );
    }

    my $do_walk = Plagger::Plugin->can('do_walk');
    no warnings qw(redefined);
    *Plagger::Plugin::do_walk = sub {
        my ( $self, $data ) = @_;
        my @conf;
        if ( ref $data eq 'HASH' ) {
            foreach my $key (
                sort { by_order( $data, $a, $b ) }
                grep { can_handle( $data->{$_} ) } keys %{$data}
              )
            {
                my $hash_ref = ( values %{ $data->{$key} } )[0];
                if ( $key =~ /password/msx ) {
                    $hash_ref->{is_password} = 1;
                }
                push @conf, \$data->{$key};
            }
        }
        elsif ( ref $data eq 'ARRAY' ) {
            foreach my $hash_ref ( grep { can_handle($_) } @{$data} ) {
                push @conf, \$hash_ref;
            }
        }

        foreach my $data_ref (@conf) {
            my $is_password = delete ${$data_ref}->{is_password};
            my ( $module, $conf ) = each %{ ${$data_ref} };

            $module = 'Plagger::Plugin::' . $module;
            $module->require or croak $@;
            ${$data_ref} = $module->run($conf);
            if ($is_password) {
                ${$data_ref} =
                  Plagger::Crypt->encrypt( ${$data_ref}, 'base64' );
            }
        }
        use Data::Dumper;
        carp Dumper $self;

        goto &{$do_walk};
    };
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
