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


/*---------- Clock ----------*/
tick_tock :-
    retract(clock(X)),
    Y is X + 1,
    asserta(clock(Y)). 

/*---------- Enemy Movement ----------*/
enemy_list(EL) :- findall((Type,I,J), enemy(Type,I,J), EL).

move_enemies([Head|Tail]) :-
    random(0, 5, R),
    movement(Head, R),
    move_enemies(Tail).

movement((Name,I,J), 0) :-
    S is 0.

movement((Name,I,J), 1) :-
    S is I + 1,
    Row is I,
    Col is S,
    \+ deadzone(Row,Col),
    retract(enemy(Name,I,J)),
    asserta(enemy(Name,S,J)).

movement((Name, I, J), 2) :-
    S is I - 1,
    Row is I,
    Col is S,
    \+ deadzone(Row, Col),
    retract(enemy(Name, I, J)),
    asserta(enemy(Name, S, J)).

movement((Name, I, J), 3) :-
    S is J + 1,
    Row is I,
    Col is S,
    \+ deadzone(Row, Col),
    retract(enemy(Name, I, J)),
    asserta(enemy(Name, I, S)).

movement((Name, I, J), 4) :-
    S is J - 1,
    Row is I,
    Col is S,
    \+ deadzone(Row, Col),
    retract(enemy(Name, I, J)),
    asserta(enemy(Name, I, S)).

/*---------- The One Procedure to Change It All ----------*/
next_tick :-
    tick_tock,
    enemy_list(EL),
    move_enemies(EL).