#!/usr/bin/env perl -w

use strict;

use MyNavData;
use HTML::Widgets::NavMenu;
use Data::Dumper;
use MyNavLinks;

my $filename = "/aegis/";

my $nav_bar = HTML::Widgets::NavMenu->new(
    'path_info'    => $filename,
    'current_host' => "scm",
    MyNavData::get_params(),
    'ul_classes' => [],
);

my $rendered_results = $nav_bar->render();
my $nav_html         = $rendered_results->{html};
my $nav_links        = $rendered_results->{nav_links};

print join( "\n", @$nav_html ), "\n";
print Dumper( [$rendered_results], ["\$r"] );
