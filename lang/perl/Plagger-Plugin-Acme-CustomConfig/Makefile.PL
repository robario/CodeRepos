#
# $Id$
#
package main;
use strict;
use warnings;
use utf8;
our $VERSION = eval { require version; version::qv('0.0.1') };

use inc::Module::Install;
eval {
    require ExtUtils::MakeMaker::Coverage;
    ExtUtils::MakeMaker::Coverage->import;
};

name 'Plagger-Plugin-Acme-CustomConfig';
version "$VERSION";
perl_version '5.008';
all_from 'lib/Plagger/Plugin/Acme/CustomConfig.pm';

requires 'version';

use_test_base;

auto_install;
WriteAll meta => 0, sign => 1;

1;
