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
        src="https://dl.dropboxusercontent.com/u/68743442/freedom-fighter-pinkie-pie.png">
    <img class="pony card"
        src="https://dl.dropboxusercontent.com/u/68743442/freedom-fighter-pinkie-pie.png">
    <img class="pony card"
        src="https://dl.dropboxusercontent.com/u/68743442/freedom-fighter-pinkie-pie.png">
    <img class="pony card"
        src="https://dl.dropboxusercontent.com/u/68743442/freedom-fighter-pinkie-pie.png">
    <img class="pony card"
        src="https://dl.dropboxusercontent.com/u/68743442/freedom-fighter-pinkie-pie.png">
    <img class="goal card"
        src="https://dl.dropboxusercontent.com/u/68743442/multiply.png">
</div>

<table id="gameboard">
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
        <td class="<%= $type %>"><%= $row_index %> - <%= $col_index %></td>
%   }
    </tr>
% }
<script>
$( ".card" ).draggable();
$( ".space" ).filter(" .pony" ).droppable(
    {
        accept: "[class~='card'][class~='pony']"
    }
);
//$( ".space" ).filter(" .ship" ).html('SHIP SPACE');
$( "td[class~='space'][class~='ship']" ).html('SHIP SPACE');
</script>

@@ layouts/default.html.ep
<!DOCTYPE html>
<html>
    <head>
        <title><%= title %></title>
        <script src="http://code.jquery.com/jquery-2.1.1.min.js"></script>
        <script src="http://code.jquery.com/ui/1.10.4/jquery-ui.min.js"></script>
    </head>
    <body><%= content %></body>
</html>
