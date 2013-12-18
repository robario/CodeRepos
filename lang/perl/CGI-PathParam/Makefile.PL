#
# $Id$
#
package main;
use strict;
use warnings;
use utf8;
our $VERSION = eval { require version; version::qv('0.04') };

use inc::Module::Install;
eval {
    require ExtUtils::MakeMaker::Coverage;
    ExtUtils::MakeMaker::Coverage->import;
};

name 'CGI-PathParam';
version "$VERSION";
all_from 'lib/CGI/PathParam.pm';

requires 'version';

use_test_base;

auto_install;
WriteAll meta => 0, sign => 1;

1;
