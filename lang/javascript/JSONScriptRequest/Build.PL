#!/usr/bin/env perl
#
# $Id: Build.PL 4 2006-12-26 01:39:04Z hironori.yoshida $
#
package main;
use strict;
use warnings;
use utf8;
our $VERSION = eval { require version; version::qv('0.03') };

use Carp;
use English qw(-no_match_vars);
use Module::Build::JSAN;

my $build = Module::Build::JSAN->new(
    module_name    => 'JSONScriptRequest',
    license        => 'mit',
    dist_author    => 'Hironori Yoshida <yoshida@cpan.org>',
    dist_abstract  => 'Call the JSONP API like XMLHttpRequest',
    dist_version   => $VERSION,
    keywords       => [qw(json script request ajax XMLHttpRequest)],
    build_requires => { 'Test.Simple' => 0.21, },
    requires       => {},
    sign           => 1,
);
$build->create_build_script;

open my $fh, '>>', 'Build' or croak $OS_ERROR;
print {$fh} <<'EOF';

BEGIN {
    $ENV{PERL5LIB} ||= q{};    # avoid warnings at Module/Build/Base.pm:4000
    if ( my $_strip_pod = Module::Build::JSAN->can('_strip_pod') ) {
        undef *Module::Build::JSAN::_strip_pod;    ## no critic
        *Module::Build::JSAN::_strip_pod = sub {   ## no critic
            my ( $self, $dist_dir ) = @_;

            my $files = $self->find_js_files;
            foreach my $file ( keys %{$files} ) {
                $files->{$file} = ( stat "$dist_dir/$file" )[2];
                chmod oct(644), "$dist_dir/$file";
            }
            $_strip_pod->(@_);
            foreach my $file ( keys %{$files} ) {
                chmod $files->{$file}, "$dist_dir/$file";
            }
        };
    }
}

{

    package Module::Build::JSAN;

    use Carp;
    use English qw(-no_match_vars);
    use File::Path;

    sub ACTION_build {   ## no critic (NamingConventions::ProhibitMixedCaseSubs)
        eval {
            require JavaScript::Squish;
            my $self = shift;

            my $infile = 'lib/' . $self->module_name . '.js';
            open my $fh, '<', $infile or croak $OS_ERROR;
            my $js = do { local $INPUT_RECORD_SEPARATOR = undef; <$fh> };
            close $fh;
            my $compacted = JavaScript::Squish->squish($js) or croak;
            ( my $copyright = $js ) =~ s{.*\s*(Copyright[^\n]*\n).*}{// $1}msx;
            $compacted = $copyright . $compacted;

            my $outfile = $self->blib . q{/} . $infile;
            mkpath( [ $self->blib . '/lib' ], 1, oct 755 );
            print {*STDERR} "js_compactor $infile => $outfile\n";
            open $fh, '>', $outfile or croak $OS_ERROR;
            print {$fh} $compacted;
            close $fh;
        };
        if ($EVAL_ERROR) {
            print {*STDOUT} $EVAL_ERROR;
        }
        return;
    }
}
EOF
