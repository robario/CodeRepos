#!/usr/bin/env perl
#
# $Revision: 381 $
# $Source$
# $Date: 2006-10-22 17:51:13 +0900 (Sun, 22 Oct 2006) $
#
package main;
use strict;
use warnings;
our $VERSION = eval { require version; version::qv( (qw$Revision: 381 $)[1] / 1000 ) };

use English qw(-no_match_vars);
use Fatal qw(open);
use FindBin qw($Bin);
use IPC::Open2;
use Module::Build;

chdir $Bin;

my $file = 'lib/JSONHttpRequest.js';

sub all_from {
    my $path = shift;

    my %args;
    $args{license} = 'perl';

    open my $fh, q{<}, $path;
    my $content = do { local $INPUT_RECORD_SEPARATOR = undef; <$fh> };
    close $fh;

    ( $args{dist_name}, $args{dist_abstract} ) = $content =~ m{
        NAME       # =head1
        \s*        #
        (\S+)      # name
        \s*-\s*    # delimiter
        (.*?)$     # abstract
    }msx;
    ( $args{dist_author} ) = $content =~ m{
        AUTHOR     # =head1
        \s*        #
        (.*?)$     # author
    }msx;
    ( $args{dist_version} ) = $content =~ m{
        $args{dist_name}\W+VERSION # variable
        \s*=\s*                    # asign
        ([^;]+);                   # number
    }msx;
    $args{dist_version} = eval { $args{dist_version} };    # to number

    return %args;
}

my $build = Module::Build->new(
    all_from($file),
    requires       => {},
    build_requires => {
        'JSAN'        => 0,
        'Test.Simple' => 0,
    },
);
$build->create_build_script;

$build->dispatch('distmeta');

$SIG{CHLD} = 'IGNORE';
open2( my $reader, undef, 'pod2text', $file );
open my $readme, q{>}, 'README';
print {$readme} do { local $INPUT_RECORD_SEPARATOR = undef; <$reader> };
close $readme;

$build->dispatch('manifest');
