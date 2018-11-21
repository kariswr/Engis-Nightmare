command(X) :-
    \+ X = new,
    \+ X = load(Y),
    \+ X = save(Y),
    \+ X = status,
    \+ X = map,
    \+ X = n,
    \+ X = s,
    \+ X = e,
    \+ X = w,
    \+ X = look,
    \+ X = take(Y),
    \+ X = drop(Y),
    \+ X = use(Y),
    \+ X = attack,
    \+ X = help,
    \+ X = quit,
    write('No such command.'), nl.

/*---------- NEW GAME ----------*/
command(new) :-
    set_game_ready,
    init_game,
    write('New game started.'), nl.

/*---------- LOAD ----------*/
command(load(X)) :-
    set_game_ready,
    write('Create procedure/function to read external file.'), nl.

/*---------- SAVE ----------*/
command(save(X)) :-
    write('Create procedure/function to write to external file.'), nl.

/*---------- STATUS ----------*/
command(status) :-
    \+ game_ready(false), !,
    show_status.

command(status) :-
    game_ready(false),
    write('Please load a file or create a new game first.'), nl.

/*---------- MAP ----------*/
command(map) :- 
    write('Create procedure/function to show the map.'), nl.

/*---------- MOVING ----------*/
command(n) :-
    write('Create procedure/function to move player north.'), nl.

command(s) :-
    write('Create procedure/function to move player south.'), nl.

command(e) :-
    write('Create procedure/function to move player east.'), nl.

command(w) :-
    write('Create procedure/function to move player west.'), nl.

/*---------- LOOK ----------*/
command(look) :-
    write('Create procedure/function to show close-up map.'), nl.

/*---------- TAKE ----------*/
command(take(X)) :-
    write('Create procedure/function to remove object from map and insert to inventory.'), nl.

/*---------- DROP ----------*/
command(drop(X)) :-
    write('Create procedure/function to remove object from inventory and insert to map.'), nl.

/*---------- USE ----------*/
command(use(X)) :-
    write('Create procedure/function to remove object from inventory and modify player status.'), nl.

/*---------- ATTACK ----------*/
command(attack) :-
    write('Create procedure/function to remove enemy from map, drop objects, and modify player status.'), nl.

/*---------- HELP ----------*/
command(help) :-
    show_help.

/*---------- QUIT ----------*/
command(quit) :- 
    nl,
    write(' Exiting the game...'), nl,
    nl,
    nl.