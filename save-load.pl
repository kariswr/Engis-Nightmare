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
    asserta(player_inventory([],10)).

init_enemies :- 
	spawn_enemy,
	spawn_enemy,
	spawn_enemy,
	spawn_enemy,
	spawn_enemy,
	spawn_enemy,
	spawn_enemy,
	spawn_enemy,
	spawn_enemy,
	spawn_enemy. 

init_supplies :-
	drop_supply,
	drop_supply,
	drop_supply,
	drop_supply,
	drop_supply,
	drop_supply,
	drop_supply,
	drop_supply,
	drop_supply,
	drop_supply,
	drop_supply,
	drop_supply,
	drop_supply,
	drop_supply,
	drop_supply.

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
    asserta(num_enemies(10)),
    asserta(clock(0)),
    init_deadzone.

/*---------- LOAD ----------*/
read_things(Stream,[]):- 
	at_end_of_stream(Stream). 

read_things(Stream,[H|T]):- 
	\+  at_end_of_stream(Stream), 
	read(Stream,H), 
	read_things(Stream,L).

assert_things([]).
assert_things([H|T]) :-
	asserta(H),
	assert_things(T).

load_game(Filename):-
	open(Filename, read, Stream),

	read_things(Stream, Data),
	assert_things(Data),

	message_load_game,
	close(Stream).


/*---------- SAVE ----------*/
save_enemies([], Stream).
save_enemies([(Type,EI,EJ)|ELT], Stream) :-
	write(Stream, enemy(Type,EI,EJ)), write(Stream, '.'), nl(Stream),
	save_enemies(ELT, Stream).

save_supplies([], Stream).
save_supplies([(Name,SI,SJ)|SLT], Stream) :-
	write(Stream, supply(Name,SI,SJ)), write(Stream, '.'), nl(Stream),
	save_supplies(SLT, Stream).

save_deadzones([], Stream).
save_deadzones([(DI,DJ)|DLT], Stream) :-
	write(Stream, deadzone(DI,DJ)), write(Stream, '.'), nl(Stream),
	save_deadzones(DLT, Stream).

save_game(Filename):-
	open(Filename, write, Stream),

	player_position(I,J),
	player_armor(Armor),
	player_health(Health),
	player_weapon(Weapon,Ammo),
	player_inventory(IL,Cap),
	clock(Ticks),
	num_enemies(NumEn),

	write(Stream, player_position(I,J)),		write(Stream, '.'), nl(Stream),
	write(Stream, player_armor(Armor)), 		write(Stream, '.'), nl(Stream),
	write(Stream, player_weapon(Weapon,Ammo)), 	write(Stream, '.'), nl(Stream),
	write(Stream, player_health(Health)), 		write(Stream, '.'), nl(Stream),
    write(Stream, player_inventory(IL,Cap)), 	write(Stream, '.'), nl(Stream),
	write(Stream, clock(Ticks)), 		    	write(Stream, '.'), nl(Stream),
	write(Stream, num_enemies(NumEn)), 			write(Stream, '.'), nl(Stream),

	enemy_list(EL),
	save_enemies(EL, Stream),
	supply_list(SL),
	save_supplies(SL, Stream),
	deadzone_list(DL),
	save_deadzones(DL, Stream),
	message_save_game,
	close(Stream).
	
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
