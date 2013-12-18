#!/usr/bin/env perl
#
# $Id$
#
use strict;
use warnings;
use utf8;
use version; our $VERSION = qv('0.0.1');

use lib qw(. t);
use Test::Base tests => 4;
use Catalyst::Test 'MyApp';

my $res = request('/foo/-_-http://www.example.com/');

is( $res->code, 200, 'request is success' );
is( $res->header('Content-Length'), 438, 'Content-Length' );
is( $res->header('Server'), 'Apache/2.2.3 (CentOS)', 'Server' );
like( $res->content, qr{\Q\E<TITLE>Example\ Web\ Page</TITLE>\E}msx,
    'content' );
