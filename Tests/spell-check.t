#!/usr/bin/env perl

use strict;
use warnings;

use Test::More;

if ( $ENV{SKIP_SPELL_CHECK} )
{
    plan skip_all => 'Skipping spell check due to environment variable';
}
else
{
    plan tests => 1;
}

{
    my $output = `./bin/spell-checker-iface 2>&1`;
    chomp($output);

    my $status = $?;

    # TEST
    is( $output, '', "No spelling errors." );

    if ($status)
    {
        die "Failed to execute ./bin/spell-checker-iface";
    }
}
