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
save_game(Filename):-
	/* Function to save file */
	
	open(Filename, write, Stream),

	/* Gathering data */
	player_health(Health), 
	player_armor(Armor), 
	player_position(Pos_x, Pos_y), 
	player_weapon(W_a, W_b),
	player_inventory(Inv_a, Inv_b),
	
	supply(S_a,S_b,S_c),
	enemy(E_a, E_b, E_c),
    	deadzone(D_a,D_b),
	clock(Clock),
	num_enemies(NumEn),
	

	/* Write player data */
	write(Stream, Health), 			write(Stream, '.'), nl(Stream),
	write(Stream, Armor), 			write(Stream, '.'), nl(Stream),
	write(Stream, Pos_x), 			write(Stream, '.'), nl(Stream),
	write(Stream, Pos_y), 			write(Stream, '.'), nl(Stream),
	write(Stream, W_a), 			write(Stream, '.'), nl(Stream),
   	write(Stream, W_b), 			write(Stream, '.'), nl(Stream),
    	write(Stream, Inv_a), 			write(Stream, '.'), nl(Stream),
	write(Stream, Inv_b), 		    	write(Stream, '.'), nl(Stream),
	
	/* Write map data */
	write(Stream, S_a), 		    	write(Stream, '.'), nl(Stream),
	write(Stream, S_b), 		    	write(Stream, '.'), nl(Stream),
	write(Stream, S_c), 		    	write(Stream, '.'), nl(Stream),
    	write(Stream, E_a), 		    	write(Stream, '.'), nl(Stream),
	write(Stream, E_b), 		    	write(Stream, '.'), nl(Stream),
	write(Stream, E_c), 		    	write(Stream, '.'), nl(Stream),
	write(Stream, NumEn), 		    	write(Stream, '.'), nl(Stream),
	write(Stream, Clock), 		    	write(Stream, '.'), nl(Stream),
	write(Stream, D_a),	 		write(Stream, '.'), nl(Stream),
	write(Stream, D_a), 			write(Stream, '.'), nl(Stream),
	
	write('Save data successfully created !'), nl,
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
