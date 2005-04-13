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
                    'text' => "Monotone",
                    'url' => "monotone/",
                    'title' => ("Monotone - an Open Source Distributed " .
                        "Version Control System"),
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
                            'url' => "subversion/Subversion-Win32-Installation-Guide.txt",
                            'title' => ("A Quick-start guide for Installing " . 
                                "Subversion on a Microsoft Windows System"),
                            'skip' => 1,
                        },
                    ],
                },
            ],
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
            'url' => "comparison/",
            'text' => "Comparison",
            'title' => "A Detailed Comparison of Many Version Control Systems",
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
