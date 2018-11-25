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
    message_command_invalid.

command(X) :-
    \+ X = new,
    \+ X = load(_),
    game_ready(false), !,
    message_game_not_ready.

/*---------- NEW GAME ----------*/
command(new) :-
    game_ready(false), !,
    set_game_ready,
    init_game,
    message_new_game.

command(new) :-
    game_ready(true),
    message_warning,
    erase_memory,
    asserta(game_ready(false)),
    command(new).

/*---------- LOAD ----------*/
command(load(X)) :-
    game_ready(false), !,
    set_game_ready,
    \+load_game(X),!,
    message_load_game.

command(load(X)) :-
    game_ready(true),
    message_warning,
    erase_memory,
    asserta(game_ready(false)),
    command(load(X)).

/*---------- SAVE ----------*/
command(save(X)) :-
    save_game(X), !,
    message_save_game.

/*---------- STATUS ----------*/
command(status) :-
    show_status.

/*---------- MAP ----------*/
command(map) :- show_map.

/*---------- MOVING ----------*/
command(n) :- n, tick_tock.
command(s) :- s, tick_tock.
command(e) :- e, tick_tock.
command(w) :- w, tick_tock.

/*---------- LOOK ----------*/
command(look) :- look.

/*---------- TAKE ----------*/
command(take(X)) :- take(X), tick_tock.

/*---------- DROP ----------*/
command(drop(X)) :- drop(X), tick_tock.

/*---------- USE ----------*/
command(use(X)) :- use(X), tick_tock.

/*---------- ATTACK ----------*/
command(attack) :- attack, tick_tock.

/*---------- HELP ----------*/
command(help) :-
    show_help.

/*---------- QUIT ----------*/
command(quit) :- 
    erase_memory,
    message_exit_game.
