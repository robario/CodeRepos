package RSTGateway::Controller::Root;

use strict;
use warnings;
use base 'Catalyst::Controller';

#
# Sets the actions in this controller to be registered with no prefix
# so they function identically to actions created in MyApp.pm
#
__PACKAGE__->config->{namespace} = '';

=head1 NAME

RSTGateway::Controller::Root - Root Controller for RSTGateway

=head1 DESCRIPTION

[enter your description here]

=head1 METHODS

=cut

=head2 default

=cut

sub default : Private {
}

use IO::All;
sub rst2s5 : Local {
    my ( $self, $c ) = @_;

    $c->req->param('rst') > io('/tmp/rst');
    my $s5 = `rst2s5.py /tmp/rst`;
    $c->res->body($s5);
}

=head2 end

Attempt to render a view, if needed.

=cut 

sub end : ActionClass('RenderView') {}

=head1 AUTHOR

Yoshida Hironori,U-E-TIMES_TOKYO\hironori.yoshida,S-1-5-21-4088943327-2718059405-2938860389-1160

=head1 LICENSE

This library is free software, you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;
