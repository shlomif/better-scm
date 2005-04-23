#!/usr/bin/perl

use strict;
use warnings;

use HTML::Latemp::GenMakeHelpers;

my $generator =
    HTML::Latemp::GenMakeHelpers->new(
        'hosts' =>
        [
            {
                'id' => "berlios",
                'source_dir' => "src",
                'dest_dir' => "\$(D)",
            },
            {
                'id' => "common",
                'source_dir' => "common",
                'dest_dir' => "\$(D)",
            },
        ],
    );

$generator->process_all();
