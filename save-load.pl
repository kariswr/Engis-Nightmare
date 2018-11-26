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
    asserta(player_inventory([],2)).

init_enemies :- 
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
    asserta(clock(0)),
    init_deadzone.

/*---------- LOAD ----------*/
load_enemies(Stream) :-
    read(Stream, Type),
    \+ Type == enemy_end, !,    
    read(Stream, EI),
    read(Stream, EJ),
    asserta(enemy(Type, EI, EJ)),
    load_enemies(Stream).

load_enemies(Stream) :-
    read(Stream, Type),
    Type == dummy.

load_supplies(Stream) :-
    read(Stream, Name),
    \+ Name == supply_end, !,  
    read(Stream, SI),
    read(Stream, SJ),
    asserta(supply(Name, SI, SJ)),
    load_supplies(Stream).

load_supplies(Stream) :-
    read(Stream, Name),
    Name == dummy.

load_deadzones(Stream) :-
    read(Stream, DI),
    \+ DI == deadzone_end, !,    
    read(Stream, DJ),
    asserta(deadzone(DI, DJ)),
    load_deadzones(Stream).

load_deadzones(Stream) :-
    read(Stream, DI),
    DI == dummy.

load_game(Filename):-
	open(Filename, read, Stream),

	read(Stream, I),
	read(Stream, J),
	read(Stream, Armor),
	read(Stream, Weapon),
	read(Stream, Ammo),
	read(Stream, Health),
    read(Stream, IL),
    read(Stream, Cap),
	read(Stream, Ticks),
    
    asserta(player_position(I,J)),
    asserta(player_armor(Armor)),
    asserta(player_weapon(Weapon,Ammo)),
    asserta(player_health(Health)),
    asserta(player_inventory(IL,Cap)),
    asserta(clock(Ticks)),

    load_enemies(Stream),
    load_supplies(Stream),
    load_deadzones(Stream),

	message_load_game,
	close(Stream).


/*---------- SAVE ----------*/
save_enemies([],_).
save_enemies([(Type,EI,EJ)|ELT], Stream) :-
    write(Stream, Type), write(Stream, '.'), nl(Stream),
    write(Stream, EI), write(Stream, '.'), nl(Stream),
    write(Stream, EJ), write(Stream, '.'), nl(Stream),
	save_enemies(ELT, Stream).

save_supplies([],_).
save_supplies([(Name,SI,SJ)|SLT], Stream) :-
	write(Stream, Name), write(Stream, '.'), nl(Stream),
	write(Stream, SI), write(Stream, '.'), nl(Stream),
	write(Stream, SJ), write(Stream, '.'), nl(Stream),
	save_supplies(SLT, Stream).

save_deadzones([],_).
save_deadzones([(DI,DJ)|DLT], Stream) :-
	write(Stream, DI), write(Stream, '.'), nl(Stream),
	write(Stream, DJ), write(Stream, '.'), nl(Stream),
	save_deadzones(DLT, Stream).

save_game(Filename):-
	open(Filename, write, Stream),

	player_position(I,J),
	player_armor(Armor),
	player_health(Health),
	player_weapon(Weapon,Ammo),
	player_inventory(IL,Cap),
	clock(Ticks),

	write(Stream, I), write(Stream, '.'), nl(Stream),
	write(Stream, J), write(Stream, '.'), nl(Stream),
	write(Stream, Armor), write(Stream, '.'), nl(Stream),
	write(Stream, Weapon), write(Stream, '.'), nl(Stream),
	write(Stream, Ammo), write(Stream, '.'), nl(Stream),
	write(Stream, Health), write(Stream, '.'), nl(Stream),
    write(Stream, IL), write(Stream, '.'), nl(Stream),
    write(Stream, Cap), write(Stream, '.'), nl(Stream),
	write(Stream, Ticks), write(Stream, '.'), nl(Stream),

	enemy_list(EL),
    save_enemies(EL, Stream),
    write(Stream, 'enemy_end.'), nl(Stream),
    write(Stream, 'dummy.'), nl(Stream),
    supply_list(SL),
    save_supplies(SL, Stream),
    write(Stream, 'supply_end.'), nl(Stream),
    write(Stream, 'dummy.'), nl(Stream),
	deadzone_list(DL),
    save_deadzones(DL, Stream),
    write(Stream, 'deadzone_end.'), nl(Stream),
    write(Stream, 'dummy.'), nl(Stream),
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
    retract(clock(_)),
    retractall(deadzone(_,_)).
