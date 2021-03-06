package TSSSF::BoardState;
use Moose;
use namespace::autoclean;

extends 'DBIx::Class::Objects::Base';

use JSON qw/to_json from_json/;

sub put_card {
    my ($self, $card_ID, $position) = @_;

    my $board = from_json($self->contents);
    my ($row_i, $col_i) = ($position =~ /^(\d+)\-(\d+)$/);
    $board->[$row_i]->[$col_i]->{card} = $card_ID;

    my $new_contents = to_json($board);
    warn "Replacing board with $new_contents";
    $self->contents($new_contents);
    $self->update();

    return;
}

__PACKAGE__->meta->make_immutable;

1;

