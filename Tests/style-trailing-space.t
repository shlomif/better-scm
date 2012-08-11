#!/usr/bin/perl

use strict;
use warnings;

use Test::More tests => 1;

use Test::TrailingSpace;

my $finder = Test::TrailingSpace->new(
    {
        root => '.',
        filename_regex => qr/(?:(?:\.(?:t|pm|pl|PL|yml|json|wml|txt|xml|html|xhtml|sh|xsl|css|cfg|dsl|ttml|mak))|MANIFEST|README|Makefile|Changes|TODO|unchanged|DONE)\z/,
    },
);

# TEST
$finder->no_trailing_space(
    "No trailing space was found."
);

