#!/usr/bin/perl

use strict;
use warnings;
use autodie;

use XML::CompareML::HTML;

open my $out, '>', 'comparison.html.source';

my $converter = XML::CompareML::HTML->new(
    'input_filename' => "./scm-comparison.xml",
    'output_handle'  => \$out,
);

$converter->process();

close($out);
