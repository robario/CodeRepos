#
# $Id$
#
package main;
use strict;
use warnings;
use utf8;
our $VERSION = eval { require version; version::qv('0.0.1') };

use inc::Module::Install;

name 'Catalyst-Engine-FastCGI-Lighttpd';
version "$VERSION";
perl_version '5.008';
all_from 'lib/Catalyst/Engine/FastCGI/Lighttpd.pm';

requires 'version';

build_requires 'Test::Base';

use_test_base;

auto_include;
auto_install;

WriteAll;

1;
