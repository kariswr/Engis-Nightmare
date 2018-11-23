set_game_ready :-
    game_ready(false), !,
    retract(game_ready(false)),
    asserta(game_ready(true)).

set_game_ready :-
    game_ready(true).

/*---------- NEW ----------*/
init_player :-
    asserta(player_position(5,5)),
    asserta(player_armor(0)),
    asserta(player_weapon(none, 0)),
    asserta(player_health(100)),
    asserta(player_inventory([],0)).

init_enemies :- 
    asserta(enemy(a,1,1)),
    asserta(enemy(b,1,5)),
    asserta(enemy(c,1,9)),
    asserta(enemy(d,5,1)),
    asserta(enemy(e,5,4)),
    asserta(enemy(f,5,9)),
    asserta(enemy(g,9,1)),
    asserta(enemy(h,9,5)),
    asserta(enemy(i,9,9)).

init_supplies :-
    asserta(supply(weapon1,5,5)),
    asserta(supply(weapon2,7,5)),
    asserta(supply(armor1,2,3)),
    asserta(supply(armor2,7,1)),
    asserta(supply(weapon1_ammo,5,5)),
    asserta(supply(weapon2_ammo,8,7)),
    asserta(supply(medicine,4,4)),
    asserta(supply(poison,6,9)).

init_deadzone :-
    asserta(deadzone(0,0)),
    asserta(deadzone(0,1)),
    asserta(deadzone(0,2)),
    asserta(deadzone(0,3)),
    asserta(deadzone(0,4)),
    asserta(deadzone(0,5)),
    asserta(deadzone(0,6)),
    asserta(deadzone(0,7)),
    asserta(deadzone(0,8)),
    asserta(deadzone(0,9)),
    asserta(deadzone(0,10)),
    asserta(deadzone(0,11)),
    asserta(deadzone(11,0)),
    asserta(deadzone(11,1)),
    asserta(deadzone(11,2)),
    asserta(deadzone(11,3)),
    asserta(deadzone(11,4)),
    asserta(deadzone(11,5)),
    asserta(deadzone(11,6)),
    asserta(deadzone(11,7)),
    asserta(deadzone(11,8)),
    asserta(deadzone(11,9)),
    asserta(deadzone(11,10)),
    asserta(deadzone(11,11)),
    asserta(deadzone(1,0)),
    asserta(deadzone(2,0)),
    asserta(deadzone(3,0)),
    asserta(deadzone(4,0)),
    asserta(deadzone(5,0)),
    asserta(deadzone(6,0)),
    asserta(deadzone(7,0)),
    asserta(deadzone(8,0)),
    asserta(deadzone(9,0)),
    asserta(deadzone(10,0)),
    asserta(deadzone(1,11)),
    asserta(deadzone(2,11)),
    asserta(deadzone(3,11)),
    asserta(deadzone(4,11)),
    asserta(deadzone(5,11)),
    asserta(deadzone(6,11)),
    asserta(deadzone(7,11)),
    asserta(deadzone(8,11)),
    asserta(deadzone(9,11)),
    asserta(deadzone(10,11)).

init_game :-
    init_player,
    init_enemies,
    init_supplies,
    asserta(num_enemies(9)),
    asserta(clock(0)),
    init_deadzone.

/*---------- LOAD ----------*/

/*---------- SAVE ----------*/

/*---------- QUIT ----------*/
erase_memory :-
    retract(game_ready(_)),
    retract(player_position(_,_)),
    retract(player_armor(_)),
    retract(player_weapon(_,_)),
    retract(player_health(_)),
    retract(player_inventory(_,_)),
    retractall(object(_,_,_)),
    retractall(enemy(_,_,_)),
    retract(num_enemies(_)),
    retract(clock(_)),
    retractall(deadzone(_,_)).