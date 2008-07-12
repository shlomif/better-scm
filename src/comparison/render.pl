#!/usr/bin/perl -w

use strict;

use XML::CompareML::HTML;

system("xsltproc", 
    "--output", "comparison.html",
    "compare-ml.xsl",
    "scm-comparison.xml",
);

1;

