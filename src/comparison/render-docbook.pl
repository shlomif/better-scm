#!/usr/bin/env perl

use strict;
use warnings;
use autodie;

use XML::CompareML::DocBook;

if ( !-e "docbook" )
{
    mkdir("docbook");
}

open my $out, '>', 'docbook/scm-comparison.xml';

my $converter = XML::CompareML::DocBook->new(
    'input_filename' => "./scm-comparison.xml",
    'output_handle'  => \$out,
);

$converter->process();

close($out);
