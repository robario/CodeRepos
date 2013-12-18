#
# $Id: Makefile.PL 11 2007-04-09 04:34:01Z hironori.yoshida $
#
use strict;
use warnings;
our $VERSION = eval { require version; version::qv('0.0.1') };

use inc::Module::Install;
eval {
    require ExtUtils::MakeMaker::Coverage;
    ExtUtils::MakeMaker::Coverage->import;
};

name 'Catalyst-Controller-Delegate';
version "$VERSION";
perl_version '5.006';
all_from 'lib/Catalyst/Controller/Delegate.pm';

requires 'version';
requires 'LWP::UserAgent';
requires 'URI::Escape';

auto_install;
use_test_base;

WriteAll;
