#!/usr/bin/env perl
use Mojolicious::Lite;

# Documentation browser under "/perldoc"
plugin 'PODRenderer';

get '/' => sub {
    my ($self) = @_;

    $self->render('board');
};

get '/api/player/:id' => sub {
};

get '/api/game/:id' => sub {
};

=pod

post '/api/card-placement' => sub {
    my ($self) = @_;
    my $card_ID = $self->param('card_ID');
    my $position = $self->param('position');


};

=cut

get '/api/board' => sub {
    my ($self) = @_;

    my $size = 9;
    my @grid = map {
        my $row_i = $_;
        [
            map {
                $row_i % 2
                    ? $_ % 2 ? 'P' : 'S' # pony row
                    : $_ % 2 ? 'S' : ' ' # ship row
            } (1 .. $size) 
        ]
    } (1 .. $size);

    $self->render(
        json => {
            grid => \@grid,
        },
    );
};

post '/api/board' => sub {
    my ($self) = @_;
    my $card = uri_unescape($self->param('card'));

    my ($cardname) = ($card =~ m!/Pony - (.*)\.png!);
    warn $cardname;

    use URI::Escape qw/uri_unescape/;
    use HTML::Entities qw/encode_entities/;
    $self->render(text => encode_entities($cardname));
};

app->start();
__DATA__

@@ board.html.ep
% layout 'default';
% title 'TSSSF';
TSSSF crude-as-balls gameboard
<div id="hand">
    <img class="pony card"
        src="https://dl.dropboxusercontent.com/u/68743442/TSSSF%20Low%20Rez/Pony%20-%20Smarty%20Pants.png">
    <img class="pony card"
        src="https://dl.dropboxusercontent.com/u/68743442/TSSSF%20Low%20Rez/Pony%20-%20Queen%20Chrysalis.png">
    <img class="pony card"
        src="https://dl.dropboxusercontent.com/u/68743442/TSSSF%20Low%20Rez/Pony%20-%20Princess%20Cadence.png">
    <img class="pony card"
        src="https://dl.dropboxusercontent.com/u/68743442/TSSSF%20Low%20Rez/Pony%20-%20Cheerilee.png">
    <img class="ship card"
        src="https://dl.dropboxusercontent.com/u/68743442/TSSSF%20Low%20Rez/Ship%20-%20Cult%20Meeting.png">
    <img class="ship card"
        src="https://dl.dropboxusercontent.com/u/68743442/TSSSF%20Low%20Rez/Ship%20-%20I%20Read%20That%20In%20A%20Book%20Once.png">
    <img class="ship card"
        src="https://dl.dropboxusercontent.com/u/68743442/TSSSF%20Low%20Rez/Ship%20-%20There%20Are%20No%20Breaks%20On%20The%20Love%20Train.png">
</div>

<table id="gameboard"></table>

<script>

var my_template_format = function() {
  var s = arguments[0];
  for (var i = 0; i < arguments.length - 1; i++) {       
    var reg = new RegExp("\\{" + i + "\\}", "gm");             
    s = s.replace(reg, arguments[i + 1]);
  }

  return s;
};

function fetch_and_display_board() {
    jQuery.get("/api/board", undefined,
        function(data, textStatus, jqXHR) {
            display_board(data.grid);
        }
    );
}

function display_board(grid) {
    var table = $( '<table width="100%"></table>');

    for (var row_i = 0; row_i < grid.length; ++row_i) {
        var row = $('<tr></tr>');
        var grid_row = grid[row_i];
        for (var col_i = 0; col_i < grid_row.length; ++col_i) {
            var cell_type = (
                  grid_row[col_i] == "P" ? "pony space"
                : grid_row[col_i] == "S" ? "ship space"
                                         : "no space"
            );

            if (cell_type == "no space") {
                row.append(
                    my_template_format(
                        empty_grid_cell_template, cell_type
                    )
                );
            } else {
                row.append(
                    my_template_format(
                        grid_cell_template,
                        cell_type,
                        cell_type == "pony space" ? pony_card_URI : ship_card_URI
                    )
                );
            }
        }

        table.append(row);
    }
    $( "#gameboard" ).replaceWith(table);
    table.attr('id', 'gameboard');
    activate_board();
}

/* Turn on all the draggability and callback that make the board actually /do/ stuff. */
function activate_board() {
    $( ".card" ).draggable();

    $( ".space" ).filter(" .pony" ).droppable(
        {
            accept:     "[class~='card'][class~='pony']",
            tolerance:  "pointer",
            hoverClass: "hovering",
            drop:       function(event, ui) {
                var uri = ui.draggable.attr("src");

                jQuery.post("/api/board", {card: uri},
                    function(data, textStatus, jqXHR) {
                        alert("Pony dropped:  " + data);
                    }
                );
            }
        }
    );
    $( ".space" ).filter(" .ship" ).droppable(
        {
            accept:     "[class~='card'][class~='ship']",
            tolerance:  "pointer",
            hoverClass: "hovering",
            drop:       function (event, ui) {
                alert("Gooooooooal!");
            }
        }
    );
}

var empty_grid_cell_template = '<td class="{0}"></td>';
var grid_cell_template = '<td class="{0}"><img src="{1}"></td>';

var pony_card_URI = "https://dl.dropboxusercontent.com/u/68743442/TSSSF%20Low%20Rez/Back%20-%20Pony.png";
var ship_card_URI = "https://dl.dropboxusercontent.com/u/68743442/TSSSF%20Low%20Rez/Back%20-%20Ship.png";

$( document ).ready(function() {
    fetch_and_display_board();
});

</script>

@@ layouts/default.html.ep
<!DOCTYPE html>
<html>
    <head>
        <title><%= title %></title>
        <script src="http://code.jquery.com/jquery-2.1.1.min.js"></script>
        <script src="http://code.jquery.com/ui/1.10.4/jquery-ui.min.js"></script>

        <style>
            td { color: blue }
            td.hovering { color: red }
        </style>
    </head>
    <body><%= content %></body>
</html>
