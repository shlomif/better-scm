#!/usr/bin/perl -w

use strict;

use XML::CompareML::HTML;

open O, ">comparison.html";

my $converter = 
    XML::CompareML::HTML->new(
        'input_filename' => "./scm-comparison.xml",
        'output_handle' => \*O,
    );

$converter->process();

close(O);

1;

