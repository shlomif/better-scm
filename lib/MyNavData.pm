package MyNavData;

use strict;
use warnings;

use MyManageNews qw/ get_news_manager /;

my $hosts = {
    'scm' => {
        'base_url' => "http://better-scm.shlomifish.org/",
    },
};

my $news_manager = get_news_manager();

my $tree_contents = {
    'host'  => "scm",
    'text'  => "Better SCM",
    'title' => "Better SCM Initiative",
    'subs'  => [
        {
            'text' => "Home",
            'url'  => "",
        },
        {
            'text' => "News",
            'url'  => "news/",
            'subs' =>
                [ @{ $news_manager->get_navmenu_items( 'num_items' => 5 ) }, ],
        },
        {
            'text'   => "General Docs",
            'url'    => "docs/",
            'expand' => { 're' => "" },
            'title'  => (
                      "General Documents that don't Belong to "
                    . "Anywhere More Specific."
            ),
            'subs' => [
                {
                    'text' => "This site became mostly irrelevant",
                    'url'  => "docs/this-site-is-irrelevant/"
                },
                {
                    'text'       => "Call for Arms",
                    'url'        => "http://www.advogato.org/article/546.html",
                    'skip'       => 1,
                    'url_is_abs' => 1,
                },
                {
                    'text'  => "Evolution as a VCS User",
                    'url'   => "docs/shlomif-evolution.html",
                    'title' =>
                        "Shlomi Fish' Evolution as a Revision Control User",
                },
                {
                    'text'  => "Nice Tries, but...",
                    'url'   => "docs/nice_trys.html",
                    'title' => (
                              "Opinion on Several Attempts to Make an "
                            . "Incomplete Version Control System"
                    ),
                },
            ],
        },
        {
            'text'   => "Alternatives",
            'url'    => "alternatives/",
            'expand' => { 're' => "" },
            'subs'   => [
                {
                    'text'  => "Aegis",
                    'url'   => "aegis/",
                    'title' => "Aegis - an SCM by Peter Miller",
                },
                {
                    'text'  => "Arch",
                    'url'   => "arch/",
                    'title' => "A Distributed Version Control System",
                },
                {
                    'text'  => "Bazaar",
                    'url'   => "alternatives/bazaar/",
                    'title' => (
                              "Bazaar - an Open Source Distributed "
                            . "Version Control System"
                    ),
                },
                {
                    'text'  => "BitKeeper",
                    'url'   => "bk/",
                    'title' => (
                        "A Proprietary Distributed Version" . " Control System"
                    ),
                    'subs' => [
                        {
                            'text'  => "Suitability for FOSS",
                            'url'   => "bk/bk_suitability.html",
                            'title' => (
                                      "Suitability of BitKeeper for Open"
                                    . " Source Projects"
                            ),
                        },
                        {
                            'text'  => "Relicensing BK",
                            'url'   => "bk/relicensing_bk.html",
                            'title' => (
                                      "Changing the BitKeeper License and"
                                    . " Why it is Needed"
                            )
                        },
                        {
                            'text'  => "Demise of Gratis Version",
                            'url'   => "bk/demise-of-gratis-bitkeeper.html",
                            'title' => (
                                      "The Demise of the Gratis"
                                    . " BitKeeper Licensing"
                            ),
                        },
                        {
                            'text'  => "What BitMover Got Wrong?",
                            'url'   => "bk/what-bitmover-got-wrong.html",
                            'title' => (
                                      "An essay that explains what BitMover"
                                    . " did not understand in the long and sad "
                                    . "history of the BitKeeper gratis license."
                            ),
                        },
                        {
                            'text' => "The BitKeeper Ghost",
                            'url'  => "bk/the-bitkeeper-ghost.html",
                        },
                    ],
                },
                {
                    'text'  => "Darcs",
                    'url'   => "alternatives/darcs/",
                    'title' => (
                              "Darcs - an Open Source Distributed "
                            . "Version Control System"
                    ),
                },
                {
                    'text'  => "Git",
                    'url'   => "alternatives/git/",
                    'title' => (
                              "A fast, distributed, open-source "
                            . "version control system"
                    ),
                },
                {
                    'text'  => "Mercurial",
                    'url'   => "alternatives/mercurial/",
                    'title' => (
                              "Mercurial - an Open Source Distributed "
                            . "Version Control System"
                    ),
                },
                {
                    'text'  => "Monotone",
                    'url'   => "monotone/",
                    'title' => (
                              "Monotone - an Open Source Distributed "
                            . "Version Control System"
                    ),
                },
                {
                    'text'  => "Perforce",
                    'url'   => "alternatives/perforce/",
                    'title' => (
                        "Perforce - a Commercial Version " . "Control Solution"
                    ),
                },
                {
                    'text'  => "Subversion",
                    'url'   => "subversion/",
                    'title' => (
                              "A Version Control System that Aims to "
                            . "Provide a Good Alternative to CVS"
                    ),
                    'subs' => [
                        {
                            'text'  => "A Compelling Alternative",
                            'url'   => "subversion/compelling_alternative.html",
                            'title' => (
                                      "Subversion - A Compelling "
                                    . "Alternative to CVS and BitKeeper"
                            ),
                        },
                        {
                            'text'  => "Win32 Installation Guide",
                            'url'   => "subversion/Svn-Win32-Inst-Guide.html",
                            'title' => (
                                      "A Quick-start guide for Installing "
                                    . "Subversion on a Microsoft Windows System"
                            ),
                        },
                    ],
                },
                {
                    'text'  => "Vesta",
                    'url'   => "vesta/",
                    'title' => (
                              "Vesta - a Distributed SCM with a "
                            . "special filesystem service"
                    ),
                },
            ],
        },
        {
            'text'  => "What to Avoid",
            'url'   => "to-avoid/",
            'title' => "Version Control Systems to Avoid",
        },
        {
            'text' => "Mailing List",
            'url'  => "mailing-list.html",
        },
        {
            'text'  => "IRC",
            'url'   => "irc/",
            'title' => "Chat about Version Control using the Internet",
        },
        {
            'text'  => "Links",
            'url'   => "links.html",
            'title' => "Links of Relevance",
        },
        {
            'text'  => "Humour",
            'url'   => "humour/",
            'title' => "Version Control Humour",
        },
        {
            'separator' => 1,
            'skip'      => 1,
        },
        {
            'url'   => "comparison/",
            'text'  => "Comparison",
            'title' => "A Detailed Comparison of Many Version Control Systems",
            'subs'  => [
                {
                    'url'   => "comparison/comparison.html",
                    'text'  => "The Comparison Itself",
                    'title' => "The Comparison Text Itself",
                },
            ],
        },
        {
            'separator' => 1,
            'skip'      => 1,
        },
        {
            'url'   => "site-map/",
            'text'  => "Site Map",
            'title' => "A Page Concentrating all the Pages on the Site",
        },
        {
            'separator' => 1,
            'skip'      => 1,
        },
        {
            'url'   => "faq/",
            'text'  => "FAQ - Frequently Asked Questions",
            'title' => "Frequently Asked Questions with Answers about the Site",
        },
        {
            'url'    => "contribute/",
            'text'   => "Contribute",
            'title'  => "How to Contribute to this Site",
            'expand' => { 're' => "" },
            'subs'   => [
                {
                    'url'   => "source/",
                    'text'  => "Site Sources",
                    'title' => (
                              "How to Get and Manipulate the Source"
                            . " Code of this Site"
                    ),
                },
            ],
        },
    ],
};

sub get_params
{
    return (
        'hosts'         => $hosts,
        'tree_contents' => $tree_contents,
    );
}

sub get_hosts
{
    return $hosts;
}

1;
