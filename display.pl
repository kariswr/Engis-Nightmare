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

/*---------- STATUS ----------*/
write_inventory :- write('Create procedure to show player inventory.'), nl.

show_status :-
    player_position(I,J),
    player_armor(Armor),
    player_weapon(WeaponName, WeaponAmmo),
    player_health(HP),

    write('PLAYER'), nl,
    nl,
    write('Position : ('), write(I), write(','), write(J), write(')'), nl,
    write('Armor    : '), write(Armor), nl,
    write('Weapon   : '), write(WeaponName), nl,
    write('Ammo     : '), write(WeaponAmmo), nl,
    write('Health   : '), write(HP), nl,
    write_inventory.

/*---------- MAP ----------*/

/*---------- LOOK ----------*/

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