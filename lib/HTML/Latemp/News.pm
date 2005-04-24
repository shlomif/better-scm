package HTML::Latemp::News;

use strict;
use warnings;

package HTML::Latemp::News::Base;

use base 'Class::Accessor';

sub new
{
    my $class = shift;
    my $self = {};
    bless $self, $class;
    $self->initialize(@_);
    return $self;
}

package HTML::Latemp::News::Item;

our @ISA=(qw(HTML::Latemp::News::Base));

__PACKAGE__->mk_accessors(qw(index title id description author date 
    category text));

sub initialize
{
    my $self = shift;

    my (%args) = (@_);

    foreach my $k (keys(%args))
    {
        if (! $self->can($k))
        {
            die "Unknown property for HTML::Latemp::News::Item - \"$k\"!";
        }
        $self->set($k, $args{$k});
    }
}

package HTML::Latemp::News;

our @ISA=(qw(HTML::Latemp::News::Base));

__PACKAGE__->mk_accessors(qw(copyright description docs generator items 
    language link managing_editor rating title ttl webmaster));

use XML::RSS;

sub input_items
{
    my $self = shift;

    my $items = shift;

    return 
    [ 
        map 
        { $self->input_single_item($_, $items->[$_]) } 
        (0 .. $#$items)
    ];
}

sub input_single_item
{
    my $self = shift;
    my ($index, $inputted_item) = (@_);

    return 
        HTML::Latemp::News::Item->new(
            %$inputted_item,
            'index' => $index,
        );
}

sub initialize
{
    my $self = shift;

    my %args = (@_);

    my $items = $args{'news_items'};

    $self->items(
        $self->input_items($items)
    );

    $self->title($args{'title'});
    $self->link($args{'link'});
    $self->language($args{'language'});
    $self->rating($args{'rating'} || '(PICS-1.1 "http://www.classify.org/safesurf/" 1 r (SS~~000 1))');
    $self->copyright($args{'copyright'} || "");
    $self->docs($args{'docs'} || "http://blogs.law.harvard.edu/tech/rss");
    $self->ttl($args{'ttl'} || "360");
    $self->generator($args{'generator'} || "Perl and XML::RSS");
    $self->webmaster($args{'webmaster'});
    $self->managing_editor($args{'managing_editor'} || $self->webmaster());
    $self->description($args{'description'});

    return 0;
}

sub add_item_to_rss_feed
{
    my $self = shift;
    my %args = (@_);

    my $item = $args{'item'};
    my $rss_feed = $args{'feed'};

    my $item_url = $self->get_item_url($item);

    $rss_feed->add_item(
        'title' => $item->title(),
        'link' => $item_url,
        'permaLink' => $item_url,
        'enclosure' => { 'url' => $item_url, },
        'description' => $item->description(),
        'author' => $item->author(),
        'pubDate' => $item->date(),
        'category' => $item->category(),
    );
}

sub get_item_url
{
    my $self = shift;
    my $item = shift;
    return $self->link() . "news/" . $item->id() . "/";
}

sub generate_rss_feed
{
    my $self = shift;

    my %args = (@_);

    my $rss_feed = XML::RSS->new('version' => "2.0");
    $rss_feed->channel(
        'title' => $self->title(),
        'link' => $self->link(),
        'language' => $self->language(),
        'description' => $self->description(),
        'rating' => $self->rating(),
        'copyright' => $self->copyright(),
        'pubDate' => (scalar(localtime())),
        'lastBuildDate' => (scalar(localtime())),
        'docs' => $self->docs(),
        'ttl' => $self->ttl(),
        'generator' => $self->generator(),
        'managingEditor' => $self->managing_editor(),
        'webMaster' => $self->webmaster(),
    );

    my $num_items_to_include = $args{'num_items'} || 10;

    my $items = $self->items();

    if (@$items < $num_items_to_include)
    {
        $num_items_to_include = scalar(@$items);
    }

    foreach my $single_item (@$items[(-$num_items_to_include) .. (-1)])
    {
        $self->add_item_to_rss_feed(
            'item' => $single_item,
            'feed' => $rss_feed,
        );
    }

    my $filename = $args{'output_filename'} || "rss.xml";
    
    $rss_feed->save($filename);
}

1;
