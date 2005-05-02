#!/usr/bin/perl

use strict;
use warnings;

use MyManageNews;

my $news_manager = get_news_manager();

$news_manager->generate_rss_feed(
    'output_filename' => "dest/rss.xml"
);

1;
