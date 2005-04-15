package MyNavLinks;

use strict;
use warnings;

use vars qw($nav_buttons_html);

use base 'Class::Accessor';

__PACKAGE__->mk_accessors(qw(root nav_links));

use Template;

sub new
{
    my $class = shift;
    my $self = {};
    bless $self, $class;
    $self->initialize(@_);
    return $self;
}

sub initialize
{
    my $self = shift;
    my %args = (@_);
    %{$self} = %args;
}

sub get_nav_buttons_html
{
    my $self = shift;

    my (%args) = (@_);
    
    my $with_accesskey = $args{'with_accesskey'};

    my $nav_links = $self->nav_links();
    my $root = $self->root();    

    my $template = 
        Template->new(
        {
            'POST_CHOMP' => 1,
        }
        );

    my @buttons =
    (
        { 
            'dir' => "prev", 
            'button' => "left", 
            'title' => "Previous Page",
        },
        { 
            'dir' => "up", 
            'button' => "up", 
            'title' => "Up in the Site",
        },
        {
            'dir' => "next", 
            'button' => "right", 
            'title' => "Next Page",
        },
    );

    foreach my $button (@buttons)
    {
        my $dir = $button->{'dir'};
        if ($button->{'exists'} = exists($nav_links->{$dir}))
        {
            $button->{'link'} = $nav_links->{$dir};
        }
    }
    
    my $vars = 
    {
        'buttons' => \@buttons,
        'root' => $root,
        'with_accesskey' => $with_accesskey,
    };
    
    my $nav_links_template = <<'EOF';
[% USE HTML %]
[% FOREACH b = buttons %]
[% SET key = substr(b.dir, 0, 1) %]
<li>
[% IF b.exists %]
<a href="[% HTML.escape(b.link) %]" title="[% b.title %] (Alt+[% uc(key) %])"
[% IF with_accesskey %]
acceskey="[% key %]"
[% END %]
>[% END %]<img src="[% root %]/images/arrow-[% b.button %][% UNLESS b.exists %]-disabled[% END %].png"
alt="[% b.title %]" class="bless" />[% IF b.exists %]</a>
[% END %]
</li>
[% END %]
EOF
    
    my $nav_buttons_html = "";
    
    $template->process(\$nav_links_template, $vars, \$nav_buttons_html);
    return $nav_buttons_html;
}

1;

