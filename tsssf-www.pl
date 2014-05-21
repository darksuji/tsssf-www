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

<table id="gameboard" width="100%">
% for my $row_index (1 .. 7) {
    <tr>
%   for my $col_index (1 .. 7) {
%       my $type;
%       if ($row_index % 2) {
%           if ($col_index % 2) {
%               $type = 'pony space';
%           } else {
%               $type = 'ship space';
%           }
%       } else {
%           if ($col_index % 2) {
%               $type = 'ship space';
%           } else {
%               $type = 'no space';
%           }
%       }
        <td class="<%= $type %>">
%           if ($type eq 'pony space') {
                <img src="https://dl.dropboxusercontent.com/u/68743442/TSSSF%20Low%20Rez/Back%20-%20Pony.png">
%           } elsif ($type eq 'ship space') {
                <img src="https://dl.dropboxusercontent.com/u/68743442/TSSSF%20Low%20Rez/Back%20-%20Ship.png">
%           }
%#        <%= $row_index %> - <%= $col_index %>
        </td>
%   }
    </tr>
% }
<script>
$( ".card" ).draggable();

$( ".space" ).filter(" .pony" ).droppable(
    {
        accept:     "[class~='card'][class~='pony']",
        tolerance:  "pointer",
        hoverClass: "hovering",
        drop:       function (event, ui) {
            alert("Gooooooooal!");
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
