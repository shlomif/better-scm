#!/usr/bin/env perl

use strict;
use warnings;

use Test::More tests => 1;
use Path::Tiny qw/ path /;
use lib './lib';

my $SCM_POST_DEST = "./dest";

{
    my $content = path("$SCM_POST_DEST/index.html")->slurp_utf8;

    # TEST
    like( $content, qr{Version Control System}, 'Contains text.' );
}
