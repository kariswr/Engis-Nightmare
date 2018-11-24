/* Write code to manage the game clock, and to make the enemies move.
** The code will be implemented to player procedures/functions.
** Optional: - Write code to arrange periodical supply drops.
**           - Inventory expansion must be discussed further.
*/

/*---------- Debugging ----------*/
dummy_clock :-
    asserta(clock(0)).

dummy_enemies :-
    asserta(enemy(a,1,1)),
    asserta(enemy(b,1,5)),
    asserta(enemy(c,1,9)),
    asserta(enemy(d,5,1)),
    asserta(enemy(e,5,4)),
    asserta(enemy(f,5,9)),
    asserta(enemy(g,9,1)),
    asserta(enemy(h,9,5)),
    asserta(enemy(i,9,9)).

init_dummy :-
    dummy_clock,
    dummy_enemies,
    dummy_deadzone,
    print_info.

dummy_deadzone :-
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

print_info :-
    clock(Ticks),
    write('Time: '), write(Ticks), nl,
    enemies.

enemies :-
    enemy_list(L), write(L).

deadzones :-
    setof(X, deadzone(X,X), DL), write(DL).


/*---------- Clock ----------*/
update_clock :-
    retract(clock(X)),
    Y is X + 1,
    asserta(clock(Y)).

/*---------- Enemy Movement ----------*/
enemy_list(EL) :- findall((Type,I,J), enemy(Type,I,J), EL).

move_enemies([]).

move_enemies([Head|Tail]) :-
    random(0, 5, R),
    movement(Head, R),
    move_enemies(Tail).

movement((Type,I,J), 0) :-
    S is 0.

movement((Type,I,J), 1) :-
    S is I + 1,
    Row is I,
    Col is S,
    \+ deadzone(Row,Col),
    retract(enemy(Type,I,J)),
    asserta(enemy(Type,S,J)).

movement((Type, I, J), 2) :-
    S is I - 1,
    Row is I,
    Col is S,
    \+ deadzone(Row, Col),
    retract(enemy(Type, I, J)),
    asserta(enemy(Type, S, J)).

movement((Type, I, J), 3) :-
    S is J + 1,
    Row is I,
    Col is S,
    \+ deadzone(Row, Col),
    retract(enemy(Type, I, J)),
    asserta(enemy(Type, I, S)).

movement((Type, I, J), 4) :-
    S is J - 1,
    Row is I,
    Col is S,
    \+ deadzone(Row, Col),
    retract(enemy(Type, I, J)),
    asserta(enemy(Type, I, S)).

update_enemies :-
    enemy_list(L1), move_enemies(L1),
    enemies_in_deadzone(L2), kill_enemies(L2). 

/*---------- Deadzone ----------*/
init_deadzone1 :-
    asserta(deadzone(1,1)),
    asserta(deadzone(1,2)),
    asserta(deadzone(1,3)),
    asserta(deadzone(1,4)),
    asserta(deadzone(1,5)),
    asserta(deadzone(1,6)),
    asserta(deadzone(1,7)),
    asserta(deadzone(1,8)),
    asserta(deadzone(1,9)),
    asserta(deadzone(1,10)),
    asserta(deadzone(10,1)),
    asserta(deadzone(10,2)),
    asserta(deadzone(10,3)),
    asserta(deadzone(10,4)),
    asserta(deadzone(10,5)),
    asserta(deadzone(10,6)),
    asserta(deadzone(10,7)),
    asserta(deadzone(10,8)),
    asserta(deadzone(10,9)),
    asserta(deadzone(10,10)),
    asserta(deadzone(2,1)),
    asserta(deadzone(3,1)),
    asserta(deadzone(4,1)),
    asserta(deadzone(5,1)),
    asserta(deadzone(6,1)),
    asserta(deadzone(7,1)),
    asserta(deadzone(8,1)),
    asserta(deadzone(9,1)),
    asserta(deadzone(2,10)),
    asserta(deadzone(3,10)),
    asserta(deadzone(4,10)),
    asserta(deadzone(5,10)),
    asserta(deadzone(6,10)),
    asserta(deadzone(7,10)),
    asserta(deadzone(8,10)),
    asserta(deadzone(9,10)).

init_deadzone2 :-
    asserta(deadzone(2,2)),
    asserta(deadzone(2,3)),
    asserta(deadzone(2,4)),
    asserta(deadzone(2,5)),
    asserta(deadzone(2,6)),
    asserta(deadzone(2,7)),
    asserta(deadzone(2,8)),
    asserta(deadzone(2,9)),
    asserta(deadzone(9,2)),
    asserta(deadzone(9,3)),
    asserta(deadzone(9,4)),
    asserta(deadzone(9,5)),
    asserta(deadzone(9,6)),
    asserta(deadzone(9,7)),
    asserta(deadzone(9,8)),
    asserta(deadzone(9,9)),
    asserta(deadzone(3,2)),
    asserta(deadzone(4,2)),
    asserta(deadzone(5,2)),
    asserta(deadzone(6,2)),
    asserta(deadzone(7,2)),
    asserta(deadzone(8,2)),
    asserta(deadzone(3,9)),
    asserta(deadzone(4,9)),
    asserta(deadzone(5,9)),
    asserta(deadzone(6,9)),
    asserta(deadzone(7,9)),
    asserta(deadzone(8,9)).

init_deadzone3 :-
    asserta(deadzone(3,3)),
    asserta(deadzone(3,4)),
    asserta(deadzone(3,5)),
    asserta(deadzone(3,6)),
    asserta(deadzone(3,7)),
    asserta(deadzone(3,8)),
    asserta(deadzone(8,3)),
    asserta(deadzone(8,4)),
    asserta(deadzone(8,5)),
    asserta(deadzone(8,6)),
    asserta(deadzone(8,7)),
    asserta(deadzone(8,8)),
    asserta(deadzone(4,3)),
    asserta(deadzone(5,3)),
    asserta(deadzone(6,3)),
    asserta(deadzone(7,3)),
    asserta(deadzone(4,8)),
    asserta(deadzone(5,8)),
    asserta(deadzone(6,8)),
    asserta(deadzone(7,8)).

init_deadzone4 :-
    asserta(deadzone(4,4)),
    asserta(deadzone(4,5)),
    asserta(deadzone(4,6)),
    asserta(deadzone(4,7)),
    asserta(deadzone(7,4)),
    asserta(deadzone(7,5)),
    asserta(deadzone(7,6)),
    asserta(deadzone(7,7)),
    asserta(deadzone(5,4)),
    asserta(deadzone(6,4)),
    asserta(deadzone(5,7)),
    asserta(deadzone(6,7)).

init_deadzone5 :-
    asserta(deadzone(5,5)),
    asserta(deadzone(5,6)),
    asserta(deadzone(6,5)),
    asserta(deadzone(6,6)).

update_deadzone :- clock(11), !, init_deadzone1.
update_deadzone :- clock(21), !, init_deadzone2.
update_deadzone :- clock(31), !, init_deadzone3.
update_deadzone :- clock(41), !, init_deadzone4.
update_deadzone :- clock(51), !, init_deadzone5.
update_deadzone :- clock(X).

player_in_deadzone :-
    deadzone(X,Y), player_position(X,Y), !,
    message_player_in_deadzone,
    erase_memory,
    asserta(game_ready(false)). 

player_in_deadzone :-
    deadzone(X,Y), \+player_position(X,Y).

enemies_in_deadzone(EL) :- findall((Type,I,J), (enemy(Type,I,J), deadzone(I,J)), EL).

kill_enemies([]).
kill_enemies([(Type,I,J)|T]) :-
    retract(enemy(Type,I,J)),
    retract(num_enemies(X)),
    Y is X - 1,
    asserta(num_enemies(Y)),
    kill_enemies(T).

/*---------- The One Procedure to Change It All ----------*/
tick_tock :-
    update_clock,
    update_deadzone,
    player_in_deadzone,
    update_enemies. 