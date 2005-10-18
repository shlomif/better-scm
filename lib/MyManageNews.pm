package MyManageNews;

use base 'Exporter';

our @EXPORT=(qw(get_news_manager));

use strict;
use warnings;

use HTML::Latemp::News;

my @news_items =
(
    (map 
        { 
            +{%$_, 
                'author' => "Shlomi Fish", 
                'category' => "Better SCM", 
                'text' => "Hello"
            }
        }
        (
        {
            'title' => "Changes of 18-April-2005",
            'id' => "changes-2005-04-18",
            'description' => q{Around 18 April, 2005, the Better SCM Site has seen a lot of changes. Click the link for details on them.},
            'date' => "2005-04-18",
        },
        {
            'title' => "The Better SCM RSS Feed",
            'id' => "2005-04-25-rss-feed",
            'description' => q{The Better SCM Site now has an RSS feed. It will be periodically updated with news about the site, and possibly latest happening in the Version Control Systems/Source Configuration Management world. To use it, add http://better-scm.berlios.de/rss.xml to your RSS aggregator.},
            'date' => "2005-04-25",
        },
        {
            'title' => "New BitKeeper Essay + PureCM Added to the Comparison",
            'id' => "changes-2005-05-18",
            'description' => q{There's a new BitKeeper essay on the Better-SCM 
            site and PureCM was added to the comparsion.},
            'date' => "2005-05-18",
        },
        {
            'title' => "\"The BitKeeper Ghost\"",
            'id' => "changes-2005-10-18",
            'description' => q{A New Essay: "The BitKeeper Ghost" was added
            to the Better-SCM Site. It covers the latest developments in 
            the BitKeeper Saga after the department of Bryan O'Sullivan
            from Mercurial.},
            'date' => "2005-05-18",
        },
        )
    )
);

sub gen_news_manager
{
    return
        HTML::Latemp::News->new(
            'news_items' => \@news_items,
            'title' => "Better SCM News",
            'link' => "http://better-scm.berlios.de/",
            'language' => "en-US",
            'copyright' => "Copyright by Shlomi Fish, (c) 2005",
            'webmaster' => "Shlomi Fish <shlomif\@iglu.org.il>",
            'managing_editor' => "Shlomi Fish <shlomif\@iglu.org.il>",
            'description' => "News of the Better SCM Site - a site for Version Control and Source Configuration Management news and advocacy",
        );
}

# A singleton.
{
    my $news_manager;

    sub get_news_manager
    {
        if (!defined($news_manager))
        {
            $news_manager = gen_news_manager();
        }
        return $news_manager;
    }
}

1;
