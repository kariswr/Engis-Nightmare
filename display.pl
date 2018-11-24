/* Note: It's recommended to design a display without fixed width and centered properties,
**       since the font and window size may vary for each computer.
*/

show_title :-
    nl,
    write('------------------------------------------------------------------------------------------'), nl,
    write('                                        GAME TITLE                                        '), nl,
    write('------------------------------------------------------------------------------------------'), nl,
    nl,
    write('                                   Created by Noob-log.                                   '), nl,
    nl,
    nl,
    write('                             For list of commands, type \'help\'.                             '), nl,
    nl,
    nl.

prompt(Input) :-
    nl,
    write('>> '), read(Input),
    nl.

show_credits :-
    nl,
    write('------------------------------------------------------------------------------------------'), nl,
    write('                                         NOOB-LOG                                         '), nl,
    write('------------------------------------------------------------------------------------------'), nl,
    write('                              Muhammad Rizki Fonna (13516001)                             '), nl,
    write('                             Lydia Astrella Wiguna (13517019)                             '), nl,
    write('                                 Karina Iswara (135170031)                                '), nl,
    write('                                  Saskia Imani (13517142)                                 '), nl,
    write('------------------------------------------------------------------------------------------'), nl,
    nl,
    nl.

/*---------- GAME MESSAGES ----------*/
message_command_invalid :- write('No such command.'), nl.
message_new_game :- write('New game started.'), nl.
message_load_game :- write('Game loaded.'), nl.
message_warning :- 
    write('This will overwrite your current game. Continue? y/n'), nl,
    read(Answer), nl,
    Answer == 'y'.
message_save_game :- write('Game saved.'), nl.
message_game_not_ready :- write('Please load a file or create a new game first.'), nl.
message_exit_game :- write('Exiting the game...'), nl.
message_player_in_deadzone :- write('You got deadzoned!'), nl.
message_take_succeed(Name) :- write('You take '), write(Name), write('.'), nl.
message_invent_full :- write('Sorry, your inventory is full.'), nl.
message_nonenemy_around :- write('There is no enemy around you.'), nl.
message_supply_notfound(Name):- write('Sorry, there is no '), write(Name), write(' in your inventory.').
message_nonenemy_here:- write("There is no enemy here. You can't attack the enemy."), nl.
message_no_ammo:- write("You ran out of ammo. You can't attack the enemy."), nl.
message_no_weapon:- write("You don't hold any weapon. You can't attack the enemy. Please use one of your weapon in inventory."), nl.
message_drop_succeed(Name):-write('You have successfully drop the '), write(Name), write('.'), nl.

/*---------- STATUS ----------*/
write_inventory([],Num).
write_inventory([X|Xs],Num) :-write(Num), write('. '), write(X), nl, Y is Num+1, write_inventory(Xs,Y).

show_status :-
    player_position(I,J),
    player_armor(Armor),
    player_weapon(WeaponName, WeaponAmmo),
    player_health(HP),
    clock(Ticks),
    
    write('   ---PLAYER---'), nl,
    nl,
    write('Position : ('), write(I), write(','), write(J), write(')'), nl,
    write('Armor    : '), write(Armor), nl,
    write('Weapon   : '), write(WeaponName), nl,
    write('Ammo     : '), write(WeaponAmmo), nl,
    write('Health   : '), write(HP), nl,
    write('Time     : '), write(Ticks),nl,
    nl,

    write('---IN GAME STATUS---'), nl,
    nl,
    write('Time     : '), write(Ticks), nl,
    nl,
    
    write('  ---INVENTORY---'),nl,
    nl,
    player_inventory(L,Max),
    write('Capacity : '), write(Max),nl,
    Num is 1,
    write_inventory(L,Num).

/*---------- MAP ----------*/

/*mengecek lebar deadzone*/
deadzone_check(X) :- deadzone(4,4), X is 4, !.
deadzone_check(X) :- deadzone(3,3), X is 3, !.
deadzone_check(X) :- deadzone(2,2), X is 2, !.
deadzone_check(X) :- deadzone(1,1), X is 1, !.
deadzone_check(X) :- deadzone(0,0), X is 0.

/*menampilkan sebaris map di mana player berada*/
show_player_between(D,P2) :- D2 is D+1, P2 =:=D2,
	between(0,D,I),
		write(' X '),
	(I=:=D),
	write(' P '),
	S3 is P2+1,
	S4 is 10-D,
	between(S3,S4,K),
		write(' - '),
	(K=:=S4),
	between(0,D,L),
		write(' X '),
	(L=:=D),
	nl, !.

show_player_between(D,P2) :- D2 is 10-D, P2 =:= D2,
	between(0,D,I),
		write(' X '),
	(I=:=D),
	S1 is D+1,
	S2 is P2-1,
	between(S1,S2,J),
		write(' - '),
	(J=:=S2),
	write(' P '),
	between(0,D,L),
		write(' X '),
	(L=:=D),
	nl, !.

show_player_between(D,P2) :-
	between(0,D,I),
		write(' X '),
	(I=:=D),
	S1 is D+1,
	S2 is P2-1,
	between(S1,S2,J),
		write(' - '),
	(J=:=S2),
	write(' P '),
	S3 is P2+1,
	S4 is 10-D,
	between(S3,S4,K),
		write(' - '),
	(K=:=S4),
	between(0,D,L),
		write(' X '),
	(L=:=D),
	nl.


/*menampilkan sebaris safezone yang tidak ada player*/
show_safezone_between :-
	deadzone_check(D),
	between(0,D,I),
		write(' X '),
	(I=:=D),
	S1 is D+1,
	S2 is 10-D,
	between(S1,S2,J),
		write(' - '),
	(J=:=S2),
	between(0,D,K),
		write(' X '),
	(K=:=D),
	nl.
	
show_map :-
	player_position(P1,P2), deadzone_check(D), D2 is D+1, P1 =:= D2,
	between(0,D,I),
		between(0,11,J),
			write(' X '),
		(J=:=11),
		nl,
	(I=:=D),
	S1 is D+1,
	S2 is P1-1,
	show_player_between(D,P2),
	S3 is P1+1,
	S4 is 10-D,
	between(S3,S4,L),
		show_safezone_between,
	(L=:=S4),
	between(0,D,M),
		between(0,11,N),
			write(' X '),
		(N=:=11),
		nl,
	(M=:=D), !.	
			
show_map :-
	player_position(P1,P2), deadzone_check(D), D2 is 10-D, P1 =:= D2,
	between(0,D,I),
		between(0,11,J),
			write(' X '),
		(J=:=11),
		nl,
	(I=:=D),
	S1 is D+1,
	S2 is P1-1,
	between(S1,S2,K),
		show_safezone_between,
	(K=:=S2),
	show_player_between(D,P2),
	between(0,D,M),
		between(0,11,N),
			write(' X '),
		(N=:=11),
		nl,
	(M=:=D), !.
	
show_map :-
	player_position(P1,P2), deadzone_check(D),
	between(0,D,I),
		between(0,11,J),
			write(' X '),
		(J=:=11),
		nl,
	(I=:=D),
	S1 is D+1,
	S2 is P1-1,
	between(S1,S2,K),
		show_safezone_between,
	(K=:=S2),
	show_player_between(D,P2),
	S3 is P1+1,
	S4 is 10-D,
	between(S3,S4,L),
		show_safezone_between,
	(L=:=S4),
	between(0,D,M),
		between(0,11,N),
			write(' X '),
		(N=:=11),
		nl,
	(M=:=D).	
		
/*---------- LOOK ----------*/

/*data test*/
/*deadzone(3,1).

enemy(ryan, 2, 2).
enemy(prim, 2, 2).
player_position(2,2).
supply(egg,2,2).
supply(egg,2,1).
supply(spoon,3,3).
supply(pan,2,2).
supply(hat,3,3).
supply(egg,1,1).
supply(hat,2,2).
ingredient(egg,1).
ammo(spoon,1,2).
weapon(pan,3).
armor(hat,4).*/

show_legend:-
	write('  --------LEGENDS--------'), nl,
	write(' X = deadzone'),nl,
	write(' P = player'),nl,
	write(' E = enemy'),nl,
	write(' I = ingredient'),nl,
	write(' W = weapon'),nl,
	write(' A = armor'),nl,
	write(' O = ammo'),nl,
	write(' - = safezone with nothing on it'),nl.

show_square(I,J):- deadzone(I,J), write(' X '), !.
show_square(I,J):- player_position(I,J), write(' P '), !.
show_square(I,J):- enemy(_,I,J), write(' E '), !.
show_square(I,J):- supply(Name,I,J), ingredient(Name,_), write(' I '), !.
show_square(I,J):- supply(Name,I,J), weapon(Name,_), write(' W '), !.
show_square(I,J):- supply(Name,I,J), armor(Name,_), write(' A '), !.
show_square(I,J):- supply(Name,I,J), ammo(Name,_,_), write(' O '), !.
show_square(I,J):- write(' _ '),!.

supply_enemy_look(I,J):- enemy(Name,I,J), write('WATCH OUT!!! '), write(Name), write(' is on your position.'),nl.
supply_enemy_look(I,J):- supply(patty,I,J), ingredient(patty,_), write('You see a patty. Hmm.. is it good for your health?'),nl.
supply_enemy_look(I,J):- supply(moldy_patty,I,J), ingredient(moldy_patty,_), write('You see a patty. Hmm.. is it good for your health?'),nl.
supply_enemy_look(I,J):- supply(cheese,I,J), ingredient(cheese,_), write('You see a cheese. Hmm.. is it good for your health?'),nl.
supply_enemy_look(I,J):- supply(moldy_cheese,I,J), ingredient(moldy_cheese,_), write('You see a cheese. Hmm.. is it good for your health?'),nl.
supply_enemy_look(I,J):- supply(milk,I,J), ingredient(milk,_), write('You see a glass of milk. Hmm.. is it good for your health?'),nl.
supply_enemy_look(I,J):- supply(spoiled_milk,I,J), ingredient(spoiled_milk,_), write('You see a glass of milk. Hmm.. is it good for your health?'),nl.
supply_enemy_look(I,J):- supply(rice,I,J), ingredient(rice,_), write('You see a bowl of rice. It must be good for your health?'),nl.
supply_enemy_look(I,J):- supply(bread,I,J), ingredient(bread,_), write('You see a slice of bread. Hmm.. is it good for your health?'),nl.
supply_enemy_look(I,J):- supply(moldy_bread,I,J), ingredient(moldy_bread,_), write('You see a slice of bread. Hmm.. is it good for your health?'),nl.
supply_enemy_look(I,J):- supply(banana,I,J), ingredient(banana,_), write('You see a banana. Hmm.. is it good for your health?'),nl.
supply_enemy_look(I,J):- supply(banana_peel,I,J), ingredient(banana_peel,_), write('You see a banana. Hmm.. is it good for your health?'),nl.
supply_enemy_look(I,J):- supply(egg,I,J), ingredient(egg,_), write('You see an egg. Hmm.. is it good for your health?'),nl.
supply_enemy_look(I,J):- supply(raw_egg,I,J), ingredient(raw_egg,_), write('You see an egg. Hmm.. is it good for your health?'),nl.
supply_enemy_look(I,J):- supply(chicken_meat,I,J), ingredient(chicken_meat,_), write('You see a chicken. It looks delicious. Hmm.. is it good for your health?'),nl.
supply_enemy_look(I,J):- supply(chicken,I,J), ingredient(chicken,_), write('You see a chicken. It looks delicious. Hmm.. is it good for your health?'),nl.
supply_enemy_look(I,J):- supply(Name,I,J), weapon(Name,_), write('You see a '),write(Name),write('. You can attack your "enemy" using it.'),nl.
supply_enemy_look(I,J):- supply(Name,I,J), armor(Name,_), write('You see a '),write(Name),write('. It can be pretty useful for protecting yourself.'),nl.
supply_enemy_look(I,J):- supply(Name,I,J), ammo(Name,_,_), write('You see a '),write(Name),write(". You can use it as your weapon's ammo."),nl.
supply_enemy_look(I,J):- \+supply(_,I,J) , \+enemy(_,I,J).

look :-
	player_position(I,J),
	area(I,J,Area),
	write('You are in the '), write(Area), write(' area.'),nl,
	supply_enemy_look(I,J),fail.

look :-
	nl,
	player_position(I,J),
	I1 is I-1,
	I2 is I+1,
	J1 is J-1,
	J2 is J+1,
	between(I1,I2,X),
		between(J1,J2,Y),
			show_square(X,Y),
		(Y=:=J2),
		nl,
	(X=:=I2),
	nl,
	show_legend.

/*---------- HELP ----------*/
show_help :-
    write(' AVAILABLE COMMANDS'), nl,
    nl,
	write(' new.            : Start a new game'), nl,
    write(' load            : load previously saved game'), nl,
	write(' save(Filename). : save your game'), nl,
	write(' status.         : show your status'), nl,
	write(' map.            : look at the map '), nl,
	write(' n. s. e. w.     : move'), nl,
	write(' look.           : look around you'), nl,
	write(' take(Object).   : pick up an object'),nl,
	write(' drop(Object).   : drop an object'), nl,
	write(' use(Object).    : use an object'), nl,
	write(' attack.         : attack enemy that crosses your path'), nl,
	write(' help.           : show available commands'), nl,
	write(' quit.           : quit the game'), nl.
