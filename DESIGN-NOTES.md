Design Notes
============

tsssf-www is a web application for playing [Twilight Sparkle's Secret Shipfic
Folder][1] with friends on the Internet.  The application will be built from a
jQuery UI talking to a RESTful API representing a SQLite database.  Games,
players, and possibly records will be persistent.

Games and Players
-----------------

The system spans a collection of `Players` and `Games`, each with persistent
existence.  A `Player` may be involved in zero or more `Games at any given
time and may have completed zero or more `Games` in the past.

A `Game` may be in one of three states:  `starting`, `playing`, or `completed`.
A `Game` that is `starting` may have *zero or more `Players`*.  While in the
`starting` state, `Players` may be added freely to a `Game`.  In order to
enter the `playing` state, it must have *at least one `Player`*.

Once in the `playing` state, the set of `Players` is fixed (though see
_Retiring_ below).  While in the `playing` state, a `game` cycles through the
`Players` in turn, accepting one or more `Plays` ending in a `TurnEnd` from
each.  Once a `Player` achieves the `Game's` `VictoryCondition`, the game
enters the `completed` state.

Games in the `completed` state accept no further input.

* Players may be retired

Plays
-----


[1]: http://tsssf-tcg.tumblr.com/   TSSSF
