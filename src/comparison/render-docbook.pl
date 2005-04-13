#!/usr/bin/perl -w

use strict;

use XML::CompareML::DocBook;

if (! -e "docbook")
{
    mkdir("docbook");
}

open O, ">docbook/scm-comparison.xml";

my $converter = 
    XML::CompareML::DocBook->new(
        'input_filename' => "./scm-comparison.xml",
        'output_handle' => \*O,
    );

$converter->process();

close(O);

1;

