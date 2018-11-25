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
load_game(Filename):-
	/* Function to load file */
	
	open(Filename, read, Stream),

	player_health(Health), 
	player_armor(Armor),  
	player_position(Pos_x, Pos_y), 
	player_weapon(W_a,W_b),
	player_inventory(Inv_a,Inv_b),
	
	retract(player_health(Health)),
	retract(player_armor(Armor)),
	retract(player_position(Pos_x, Pos_y)),
	retract(player_weapon(W_a,W_b)),
	retract(player_inventory(Inv_a,Inv_b)),
	
	
	/* Read player data */
	read(Stream, New_Health), 	  	 
	read(Stream, New_Armor), 	 
	read(Stream, New_Pos_x), 	
	read(Stream, New_Pos_y),	
	read(Stream, New_W_a),
	read(Stream, New_W_b),
	read(Stream, New_Inv_a),	
	read(Stream, New_Inv_b), 
	
	asserta(player_health(New_Health)),
	asserta(player_armor(New_Armor)),
	asserta(player_position(New_Pos_x, New_Pos_y)),
	asserta(player_weapon(New_W_a, New_W_b)),
	asserta(player_inventory(New_Inv_a, New_Inv_b)),
	
	/*supply(S_a,S_b,S_c),*/
	/*enemy(E_a, E_b, E_c),*/
	/*deadzone(D_a,D_b),*/
	clock(Clock),
	enemy_list(EL),
	deadzone_list(DL),
	supply_list(SL),
	num_enemies(NumEn),

	/*retract(supply(S_a,S_b,S_c)),*/
	/*retract(enemy(E_a, E_b, E_c)),*/
	/*retract(deadzone(D_a,D_b)),*/
	retract(clock(Clock)),
	retract(enemy_list(EL)),
	retract(deadzone_list(DL)),
	retract(supply_list(SL)),
	retract(num_enemies(NumEn)),
	
	/* Read map data */
	/*read(Stream, New_S_a),*/
	/*read(Stream, New_S_b),*/
	/*read(Stream, New_S_c),*/
	/*read(Stream, New_E_a),*/
	/*read(Stream, New_E_b),*/
	/*read(Stream, New_E_c),*/
	/*read(Stream, New_D_a),*/
	/*read(Stream, New_D_b),*/
	read(Stream, New_Clock),
	read(Stream, New_EL),
	read(Stream, New_DL),
	read(Stream, New_SL),		
	read(Stream, New_NumEn),			

	/*asserta(supply(New_S_a, New_S_b, New_S_c)),*/
	/*asserta(enemy(New_E_a, New_E_b, New_E_c)),*/
	/*asserta(deadzone(New_D_a, New_D_b)),*/
	asserta(clock(New_Clock)),
	asserta(enemy_list(New_EL)),
	asserta(deadzone_list(New_DL)),
	asserta(supply_list(New_SL)),
	asserta(num_enemies(New_NumEn)),
	
	write('Data successfully loaded !'), nl,
	close(Stream).


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
	
	/*supply(S_a,S_b,S_c),*/
	/*enemy(E_a, E_b, E_c),*/
    	/*deadzone(D_a,D_b),*/
	clock(Clock),
	enemy_list(EL),
	deadzone_list(DL),
	supply_list(SL),
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
	/*write(Stream, S_a), 		    	write(Stream, '.'), nl(Stream),*/
	/*write(Stream, S_b), 		    	write(Stream, '.'), nl(Stream),*/
	/*write(Stream, S_c), 		    	write(Stream, '.'), nl(Stream),*/
    	/*write(Stream, E_a), 		    	write(Stream, '.'), nl(Stream),*/
	/*write(Stream, E_b), 		    	write(Stream, '.'), nl(Stream),*/
	/*write(Stream, E_c), 		    	write(Stream, '.'), nl(Stream),*/
	/*write(Stream, D_a),	 		write(Stream, '.'), nl(Stream),*/
	/*write(Stream, D_b), 			write(Stream, '.'), nl(Stream),*/
	write(Stream, Clock), 		    	write(Stream, '.'), nl(Stream),
	write(Stream, EL), 		    	write(Stream, '.'), nl(Stream),
	write(Stream, DL), 		    	write(Stream, '.'), nl(Stream),
	write(Stream, SL), 		    	write(Stream, '.'), nl(Stream),
	write(Stream, NumEn), 		    	write(Stream, '.'), nl(Stream),
	
		
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
