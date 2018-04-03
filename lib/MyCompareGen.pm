package MyCompareGen;
#
# Short description for MyCompareGen.pm
#
# Author shlomif <shlomif@cpan.org>
# Version 0.1
use strict;
use warnings;

use XML::CompareML::HTML;

sub run
{
    my $comparison;
    open my $out, ">", \$comparison;
    binmode $out, ":encoding(UTF-8)";

    my $converter = XML::CompareML::HTML->new(
        'input_filename' => "./comparison/scm-comparison.xml",
        'output_handle'  => $out,
    );

    $converter->process();

    close($out);

    $comparison =~ s{\A.*?<body>}{}s;
    $comparison =~ s{</body>.*}{}s;

    print qq{<div class="comparison">\n$comparison\n</div>\n};

    return;
}

1;
