#!/usr/bin/perl

use strict;
use warnings;

use HTML::Latemp::GenMakeHelpers;

sub _exec
{
    my ( $cmd, $err ) = @_;

    if ( system(@$cmd) )
    {
        die $err;
    }
    return;
}

_exec(
    [
        'cookiecutter', '-f', '--no-input',
        'gh:shlomif/cookiecutter--shlomif-latemp-sites',
        'project_slug=.',
    ],
    'cookiecutter failed.'
);

my $generator = HTML::Latemp::GenMakeHelpers->new(
    'hosts' => [
        {
            'id'         => "common",
            'source_dir' => "common",
            'dest_dir'   => "\$(D)",
        },
        {
            'id'         => "berlios",
            'source_dir' => "src",
            'dest_dir'   => "\$(D)",
        },
    ],
);

$generator->process_all();

open my $out_fh, ">", "Makefile" or die "Cannot open Makefile $!";
print {$out_fh} "include lib/make/_Main.mak\n";
close($out_fh);
