use utf8;
package TSSSF::Schema::Result::BoardState;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

TSSSF::Schema::Result::BoardState

=cut

use strict;
use warnings;

use base 'DBIx::Class::Core';

=head1 TABLE: C<board_state>

=cut

__PACKAGE__->table("board_state");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 contents

  data_type: 'blob'
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "contents",
  { data_type => "blob", is_nullable => 0 },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");


# Created by DBIx::Class::Schema::Loader v0.07039 @ 2014-05-25 23:19:37
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:o7BARBxQjMvERuVQpVwu7Q


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
