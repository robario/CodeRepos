#!/usr/bin/env perl
#
# $Revision: 316 $
# $Source$
# $Date: 2007-05-18 19:00:18 +0900 (Fri, 18 May 2007) $
#
package main;
use strict;
use warnings;
our $VERSION = eval { require version; version::qv('0.0.0') };

use English qw(-no_match_vars);
use Fatal qw(open);
use FindBin qw($Bin);
use IPC::Open2;
use Module::Build::JSAN;

chdir $Bin;

my $file = 'lib/console.js';

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

my $build = Module::Build::JSAN->new(
    all_from('lib/console.js'),
    keywords       => [qw(Firebug console debug)],
    build_requires => { 'Test.Simple' => 0, },
    requires       => { 'JSAN' => 0, },
);

$build->create_build_script;

$SIG{CHLD} = 'IGNORE';
open2( my $reader, undef, 'pod2text', $file );
open my $readme, q{>}, 'README';
print {$readme} do { local $INPUT_RECORD_SEPARATOR = undef; <$reader> };
close $readme;
