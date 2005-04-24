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

__PACKAGE->mk_accessors(qw(index title id description author date category text));

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

__PACKAGE__->mk_accessors(qw(copyright docs generator language 
    link rating title ttl));

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

    return 0;
}

1;
