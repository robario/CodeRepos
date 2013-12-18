#!/usr/bin/env perl
#
# $Id: Build.PL 1782 2007-11-19 07:36:41Z holidays-l $
#
package main;
use strict;
use warnings;
use utf8;
our $VERSION = eval { require version; version::qv('0.0.1') };

use Carp;
use English qw(-no_match_vars);
use Module::Build::JSAN;

my $build = Module::Build::JSAN->new(
    module_name    => 'Object.toSource',
    license        => 'mit',
    dist_author    => 'Hironori Yoshida <yoshida@cpan.org>',
    dist_abstract  => 'toSource',
    dist_version   => $VERSION,
    keywords       => [qw(object)],
    build_requires => { 'Test.Simple' => 0.21, },
    requires       => {},
    sign           => 1,
);
$build->create_build_script;
