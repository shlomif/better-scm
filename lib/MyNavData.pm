package MyNavData;

my $hosts =
{
    'berlios' =>
    {
        'base_url' => "http://better-scm.berlios.de/",
    },
};

my $tree_contents =
{
    'host' => "berlios",
    'text' => "Better SCM",
    'title' => "Better SCM Initiative",
    'subs' =>
    [
        {
            'text' => "Home",
            'url' => "",
        },
        {
            'text' => "General Docs",
            'url' => "docs/",
            'title' => ("General Documents that don't Belong to " . 
                "Anywhere More Specific."),
            'subs' =>
            [
                {
                    'text' => "Call for Arms",
                    'url' => "http://www.advogato.org/article/546.html",
                    'skip' => 1,
                    'url_is_abs' => 1,
                },
                {
                    'text' => "Evolution as a VCS User",
                    'url' => "docs/shlomif-evolution.html",
                    'title' => "Shlomi Fish' Evolution as a Revision Control User",
                },
                {
                    'text' => "Nice Tries, but...",
                    'url' => "docs/nice_trys.html",
                    'title' => ("Opinion on Several Attempts to Make an " .
                        "Incomplete Version Control System"),
                },
            ],
        },
        {
            'text' => "Alternatives",
            'url' => "alternatives/",
            'expand' => { 're' => ""},
            'subs' => 
            [
                {
                    'text' => "Aegis",
                    'url' => "aegis/",
                    'title' => "Aegis - an SCM by Peter Miller",
                },
                {
                    'text' => "Arch",
                    'url' => "arch/",
                    'title'=> "A Distributed Version Control System",
                },
                {
                    'text' => "BitKeeper",
                    'url' => "bk/",
                    'title' => ("A Proprietary Distributed Version" . 
                        " Control System"),
                    'subs' =>
                    [
                        {
                            'text' => "Suitability for FOSS",
                            'url' => "bk/bk_suitability.html",
                            'title' => ("Suitability of BitKeeper for Open" .
                                " Source Projects"),
                        },
                        {
                            'text' => "Relicensing BK",
                            'url' => "bk/relicensing_bk.html",
                            'title' => ("Changing the BitKeeper License and" . 
                                " Why it is Needed")
                        },
                        {
                            'text' => "Demise of Gratis Version",
                            'url' => "bk/demise-of-gratis-bitkeeper.html",
                            'title' => ("The Demise of the Gratis" . 
                                " BitKeeper Licensing"),
                        },
                    ],
                },
                {
                    'text' => "Darcs",
                    'url' => "alternatives/darcs/",
                    'title' => ("Darcs - an Open Source Distributed " .
                        "Version Control System"),
                },
                {
                    'text' => "Monotone",
                    'url' => "monotone/",
                    'title' => ("Monotone - an Open Source Distributed " .
                        "Version Control System"),
                },
                {
                    'text' => "Perforce",
                    'url' => "alternatives/perforce/",
                    'title' => ("Perforce - a Commercial Version " .
                        "Control Solution"),
                },
                {
                    'text' => "Subversion",
                    'url' => "subversion/",
                    'title' => ("A Version Control System that Aims to " . 
                        "Provide a Good Alternative to CVS"),
                    'subs' =>
                    [
                        {
                            'text' => "A Compelling Alternative",
                            'url' => "subversion/compelling_alternative.html",
                            'title' => ("Subversion - A Compelling " . 
                                "Alternative to CVS and BitKeeper"),
                        },
                        {
                            'text' => "Win32 Installation Guide",
                            'url' => "subversion/Svn-Win32-Inst-Guide.html",
                            'title' => ("A Quick-start guide for Installing " . 
                                "Subversion on a Microsoft Windows System"),
                        },
                    ],
                },
                {
                    'text' => "Vesta",
                    'url' => "vesta/",
                    'title' => ("Vesta - a Distributed SCM with a " . 
                        "special filesystem service"),
                },
            ],
        },
        {
            'text' => "What to Avoid",
            'url' => "to-avoid/",
            'title' => "Version Control Systems to Avoid",
        },
        {
            'text' => "Mailing List",
            'url' => "mailing-list.html",
        },
        {
            'text' => "Links", 
            'url' => "links.html",
            'title' => "Links of Relevance",
        },
        {
            'separator' => 1,
            'skip' => 1,
        },
        {
            'url' => "comparison/",
            'text' => "Comparison",
            'title' => "A Detailed Comparison of Many Version Control Systems",
        },
        {
            'separator' => 1,
            'skip' => 1,
        },
        {
            'url' => "site-map/",
            'text' => "Site Map",
            'title' => "A Page Concentrating all the Pages on the Site",
        },
        {
            'separator' => 1,
            'skip' => 1,
        },
        {
            'url' => "source/",
            'text' => "Site Sources",
            'title' => "How to Get and Manipulate the Source Code of this Site",
        },
    ],
};

sub get_params
{
    return 
        (
            'hosts' => $hosts,
            'tree_contents' => $tree_contents,
        );
}

1;
