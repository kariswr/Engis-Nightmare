/* Note: It's recommended to design a display without fixed width and centered properties,
**       since the font and window size may vary for each computer.
*/

show_title :-
    nl,

write('      _______ __    _ _______ ___ __ _______ '), nl,
write('     |       |  |  | |       |   |  |       |'), nl,
write('     |    ___|   |_| |    ___|   |__|  _____|'), nl,
write('     |   |___|       |   | __|   |  | |_____ '), nl,
write('     |    ___|  _    |   ||  |   |  |_____  |'), nl,
write('     |   |___| | |   |   |_| |   |   _____| |'), nl,
write('     |_______|_|  |__|_______|___|  |_______|'), nl,
                                                                                                                                                                                                 
    nl,
	nl,
	
write('      __    _ ___ _______ __   __ _______ __   __ _______ ______   _______ '), nl,
write('     |  |  | |   |       |  | |  |       |  |_|  |   _   |    _ | |       |'), nl,
write('     |   |_| |   |    ___|  |_|  |_     _|       |  |_|  |   | || |    ___|'), nl,
write('     |       |   |   | __|       | |   | |       |       |   |_||_|   |___ '), nl,
write('     |  _    |   |   ||  |       | |   | |       |       |    __  |    ___|'), nl,
write('     | | |   |   |   |_| |   _   | |   | | ||_|| |   _   |   |  | |   |___ '), nl,
write('     |_|  |__|___|_______|__| |__| |___| |_|   |_|__| |__|___|  |_|_______|'), nl,

    nl,
    nl,
    nl,
    write('                            Created by Noob-log                           '), nl,
    nl,
    nl,
    write('                     Welcome to Expanded Engi\'s Kitchen                  '), nl,
    write('                 Let\'s protect our "beloved" Engi\'s Kitchen                  '), nl,
    nl,
    nl,
    show_help,
    nl.

prompt(Input) :-
    nl,
    write(' >> '), read(Input),
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
/* Main, Command */
message_command_invalid :- write(' No such command.'), nl.
message_game_not_ready :- write(' Please load a file or create a new game first.'), nl.
message_new_game :- write(' New game started.'), nl.
message_warning :- 
    write(' This will overwrite your current game. Continue? y/n'), nl,
    read(Answer), nl,
    Answer == 'y'.
message_exit_game :- write(' Exiting the game...'), nl.

/* Save-Load */
message_load_game :- write(' Game loaded.'), nl.
message_save_game :- write(' Game saved.'), nl.

/*Enemy-Supply*/
message_player_in_deadzone :- write(' You just trespassed! The lanlord is so angry with you and decides to close Engi\'s Kitchen.'), nl.
message_update_deadzone:-write(' Another bill just came by. The lanlord is threatening to close Engi\'s Kitchen.'), nl, write(' Check the map! Engi\'s Kitchen area has been shrunk.'), nl.

/* Take */
message_take_succeed(Name):- write(' You took '), write(Name), write('.'), nl.
message_take_inventfull :- write(' Sorry, your inventory is full.'), nl.
message_take_notfound(Name):- write(' Sorry, '),write(Name),write(' not found on your position.'),nl.

/* Drop */
message_drop_succeed(Name):-write(' You have successfully drop the '), write(Name), write('.'), nl.
message_drop_notfound(Name):- write(' Cannot find '), write(Name), write(' in your inventory.'), nl.

/* Attack */
message_attack_succeed(Name):- write(' Yes! You have defeated '), write(Name), write('.'),nl.
message_attack_injuredbutsucceed(Name,Damage):- write(' You have defeated '),write(Name),write('. '),write('But you took some hits yourself.'),nl, write(' Health -'),write(Damage),nl.
message_attack_playerdead(Name):- write(' Uh-oh... The '), write(Name), write('got the best of you.'), nl.
message_attack_noammo:- write(' You ran out of ammo. You can\'t attack the enemy.'), nl.
message_attack_noweapon:- write(' You don\'t hold any weapon. You can\'t attack the enemy. Please use one of your weapon in inventory.'), nl.
message_attack_noenemy:- write(' There is no enemy here. Your attack is useless.'), nl.

/* Use */
message_use_weapon(silverware_sling):- write(' You equiped silverware sling as a weapon. To use it, you must equip forks, knives, or spoons as ammunition.'),nl,!.
message_use_weapon(salt_shaker):-  write(' You equiped salt shaker as a weapon. To use it, you must equip salt as ammunition.'),nl,!.
message_use_weapon(msg_shaker):- write(' You equiped msg shaker as a weapon. To use it, you must equip msg as ammunition.'),nl,!.
message_use_weapon(trashbag):- write(' You equiped trashbag as a weapon. To use it, you must equip trash as ammunition.'),nl,!.
message_use_weapon(Name):- write(' You equiped '),write(Name),write(' as a weapon.'),nl.
message_use_ingredient_bad(patty,Damage):- Damage<0, write(' Oh, no! You just ate moldy patty. You got sick.'),nl ,write(' Health -'),write(Damage),nl,!.
message_use_ingredient_bad(cheese,Damage):- write(' Oh, no! You just ate moldy cheese. You got sick.'),nl ,write(' Health -'),write(Damage),nl,!.
message_use_ingredient_bad(milk,Damage):- write(' Oh, no! You just drank a glass of spoiled milk. You got sick.'),nl ,write(' Health -'),write(Damage),nl,!.
message_use_ingredient_bad(bread,Damage):- write(' Oh, no! You just ate a slice of moldy bread. You got sick.'),nl ,write(' Health -'),write(Damage),nl,!.
message_use_ingredient_bad(banana,Damage):- write(' Oh, no! You just ate banana peel and choked on it.'),nl ,write(' Health -'),write(Damage),nl,!.
message_use_ingredient_bad(egg,Damage):- write(' Oh, no! You just ate raw egg. Yikes... you got nausea.'),nl ,write(' Health -'),write(Damage),nl,!.
message_use_ingredient_bad(chicken,Damage):- write(' You just tried to eat the chicken alive! You received some attack from the chicken. Ouch!'),nl ,write(' Health -'),write(Damage),nl,!.

message_use_ingredient_good(milk,Value):- write(' You just drank a glass of milk.'),write(' Yum...'),nl ,write(' Health +'),write(Value),nl,!.
message_use_ingredient_good(rice,Value):- write(' You just ate a bowl of rice.'),write(' Yum...'),nl ,write(' Health +'),write(Value),nl,!.
message_use_ingredient_good(bread,Value):- write(' You just ate a slice of bread.'),write(' Yum...'),nl ,write(' Health +'),write(Value),nl,!.
message_use_ingredient_good(chicken_meat,Value):- write(' You just ate fried chicken.'),write(' Yum...'),nl ,write(' Health +'),write(Value),nl,!.
message_use_ingredient_good(Name,Value):- write(' You ate '),write(Name),write('. Yum...'),nl ,write(' Health +'),write(Value),nl,!.
message_use_armor(Name,Effect) :- write(' You use '), write(Name), write('.'), nl, write(' Armor +'), write(Effect),nl,!.
message_use_ammo(Name,Value):- write(' You load '),write(Name),write(' into your weapon. '),nl,write(' Ammunition +'),write(Value),nl.
message_wrong_ammo(Weapon):- write(' You selected wrong ammo type for '),write(Weapon),write('. '),nl.
message_use_bag(Name,X):- write(' You equipped '),write(Name),write('. '), nl,write(' Maximum Inventory Capacity +'),write(X),nl.
message_use_notfound(Name):- write(' Sorry, there is no '), write(Name), write(' in your inventory.'), nl.

message_location:- player_position(I,J), area(I,J,Name), write(' You are in the '), write(Name), write(' area.'),nl.

message_win:- 
nl,
write(' You have successfully vanquished your fears! Congratulations!'), nl,
nl,
write('      __   __  _______  __   __    _     _  ___   __    _ '), nl,
write('     |  | |  ||       ||  | |  |  | | _ | ||   | |  |  | |'), nl,
write('     |  |_|  ||   _   ||  | |  |  | || || ||   | |   |_| |'), nl,
write('     |       ||  | |  ||  |_|  |  |       ||   | |       |'), nl,
write('     |_     _||  |_|  ||       |  |       ||   | |  _    |'), nl,
write('       |   |  |       ||       |  |   _   ||   | | | |   |'), nl,
write('       |___|  |_______||_______|  |__| |__||___| |_|  |__|'), nl,
nl,
nl,
write('         Thank you for saving "beloved" Engi\'s Kitchen.'), nl.

message_lose:-
nl,
write('      __   __  _______  __   __    ___      _______  _______  _______ '), nl,
write('     |  | |  ||       ||  | |  |  |   |    |       ||       ||       |'), nl,
write('     |  |_|  ||   _   ||  | |  |  |   |    |   _   ||  _____||    ___|'), nl,
write('     |       ||  | |  ||  |_|  |  |   |    |  | |  || |_____ |   |___ '), nl,
write('     |_     _||  |_|  ||       |  |   |___ |  |_|  ||_____  ||    ___|'), nl,
write('       |   |  |       ||       |  |       ||       | _____| ||   |___ '), nl,
write('       |___|  |_______||_______|  |_______||_______||_______||_______|'), nl,
nl,
nl.

/*---------- STATUS ----------*/
write_inventory([],_).
write_inventory([X|Xs],Num) :-write(' '), write(Num), write('. '), write(X), nl, Y is Num+1, write_inventory(Xs,Y).

show_status :-
    player_position(I,J),
    player_armor(Armor),
    player_weapon(WeaponName, WeaponAmmo),
    player_health(HP),
    clock(Ticks),
    
    write('    ---PLAYER---'), nl,
    nl,
    write(' Position : ('), write(I), write(','), write(J), write(')'), nl,
    write(' Armor    : '), write(Armor), nl,
    write(' Weapon   : '), write(WeaponName), nl,
    write(' Ammo     : '), write(WeaponAmmo), nl,
    write(' Health   : '), write(HP), nl,
    nl,

    write(' ---IN GAME STATUS---'), nl,
    nl,
    write(' Time     : '), write(Ticks), nl,
    nl,
    
    write('   ---INVENTORY---'),nl,
    nl,
    player_inventory(L,Max),
    write(' Capacity : '), write(Max),nl,
    Num is 1,
    write_inventory(L,Num).

/*---------- MAP ----------*/

/*data test*/
/*deadzone(2,2).
player_position(3,3).*/

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
area(2,2,lounge).
supply(egg,2,2).
supply(egg,2,1).
supply(spoon,3,3).
supply(pan,2,2).
supply(hat,3,3).
supply(egg,1,1).
supply(hat,2,2).
supply(trolley,2,3).
ingredient(egg,1).
ammo(spoon,1,2).
weapon(pan,3).
armor(hat,4).
bag(trolley,15).*/

show_legend:-
	write('  --------LEGEND--------'), nl,
	write(' X = deadzone'),nl,
	write(' P = player'),nl,
	write(' E = enemy'),nl,
	write(' I = ingredient'),nl,
	write(' W = weapon'),nl,
	write(' A = armor'),nl,
	write(' O = ammo'),nl,
	write(' B = bag'),nl,
	write(' - = safezone with nothing on it'),nl.

show_square(I,J):- deadzone(I,J), write(' X '), !.
show_square(I,J):- player_position(I,J), write(' P '), !.
show_square(I,J):- enemy(_,I,J), write(' E '), !.
show_square(I,J):- supply(Name,I,J), ingredient(Name,_), write(' I '), !.
show_square(I,J):- supply(Name,I,J), weapon(Name,_), write(' W '), !.
show_square(I,J):- supply(Name,I,J), armor(Name,_), write(' A '), !.
show_square(I,J):- supply(Name,I,J), ammo(Name,_,_), write(' O '), !.
show_square(I,J):- supply(Name,I,J), bag(Name,_), write(' B '),!.
show_square(_,_):- write(' - '),!.

supply_enemy_look(I,J):- enemy(Name,I,J), write(' Watch out! There\'s '), write(Name), write(' on your position.'),nl.
supply_enemy_look(I,J):- supply(patty,I,J), ingredient(patty,_), write(' You see a patty. Hmm... Is it good for your health?'),nl.
supply_enemy_look(I,J):- supply(cheese,I,J), ingredient(cheese,_), write(' You see a cheese. Hmm... Is it good for your health?'),nl.
supply_enemy_look(I,J):- supply(milk,I,J), ingredient(milk,_), write(' You see a glass of milk. Hmm... Is it good for your health?'),nl.
supply_enemy_look(I,J):- supply(rice,I,J), ingredient(rice,_), write(' You see a bowl of rice. It must be good for your health...'),nl.
supply_enemy_look(I,J):- supply(bread,I,J), ingredient(bread,_), write(' You see a slice of bread. Hmm.. is it good for your health?'),nl.
supply_enemy_look(I,J):- supply(banana,I,J), ingredient(banana,_), write(' You see a banana. Hmm... Is it good for your health?'),nl.
supply_enemy_look(I,J):- supply(egg,I,J), ingredient(egg,_), write(' You see an egg. Hmm... Is it good for your health?'),nl.
supply_enemy_look(I,J):- supply(chicken,I,J), ingredient(chicken,_), write('You see a chicken. It looks delicious. Hmm... Is it good for your health?'),nl.
supply_enemy_look(I,J):- supply(Name,I,J), weapon(Name,_), write(' You see '),write(Name),write('. You can attack your "enemy" using it.'),nl.
supply_enemy_look(I,J):- supply(Name,I,J), armor(Name,_), write(' You see '),write(Name),write('. It can be pretty useful for protecting yourself.'),nl.
supply_enemy_look(I,J):- supply(Name,I,J), ammo(Name,_,_), write(' You see some '),write(Name),write('. You can use it as your weapon\'s ammo.'),nl.
supply_enemy_look(I,J):- supply(Name,I,J), bag(Name,_), write(' You see a '), write(Name), write('. You can store your belongings in it.'),nl.
supply_enemy_look(I,J):- \+supply(_,I,J) , \+enemy(_,I,J).

look :-
	player_position(I,J),
	area(I,J,Area),
	write(' You are in the '), write(Area), write(' area.'),nl,
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
