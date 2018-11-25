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
    enemy_list(EL), write(EL).

deadzones :-
    deadzone_list(DL), write(DL).

supplies :-
    supply_list(SL), write(SL).


/*---------- Clock ----------*/
update_clock :-
    retract(clock(X)),
    Y is X + 1,
    asserta(clock(Y)).

/*---------- Spawn Enemy ----------*/
generate_enemy(0,I,J) :- asserta(enemy(customer,I,J)).
generate_enemy(1,I,J) :- asserta(enemy(star_customer,I,J)).
generate_enemy(2,I,J) :- asserta(enemy(hobo,I,J)).
generate_enemy(3,I,J) :- asserta(enemy(rodent,I,J)).
generate_enemy(4,I,J) :- asserta(enemy(flies,I,J)).
generate_enemy(5,I,J) :- asserta(enemy(food_critic,I,J)).

spawn_enemy :-
    random(0,6,Type),
    random(1,11,I),
    random(1,11,J),
    generate_enemy(Type,I,J).

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
    Row is S,
    Col is J,
    \+ deadzone(Row,Col),
    retract(enemy(Type,I,J)),
    asserta(enemy(Type,S,J)).

movement((Type, I, J), 2) :-
    S is I - 1,
    Row is S,
    Col is J,
    \+ deadzone(Row, Col),
    retract(enemy(Type,I,J)),
    asserta(enemy(Type,S,J)).

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

update_deadzone :- clock(11), !, init_deadzone1, message_update_deadzone.
update_deadzone :- clock(21), !, init_deadzone2, message_update_deadzone.
update_deadzone :- clock(31), !, init_deadzone3, message_update_deadzone.
update_deadzone :- clock(41), !, init_deadzone4, message_update_deadzone.
update_deadzone :- clock(51), !, init_deadzone5, message_update_deadzone.
update_deadzone :- clock(X).

deadzone_list(L) :- findall((X,Y), deadzone(X,Y), L).

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

/*---------- Supply Drop ----------*/
generate_supply(0) :- random(0,5,Type), random(1,11,I), random(1,11,J), generate_weapon(Type,I,J).
generate_supply(1) :- random(0,6,Type), random(1,11,I), random(1,11,J), generate_ammo(Type,I,J).
generate_supply(2) :- random(0,6,Type), random(1,11,I), random(1,11,J), generate_armor(Type,I,J).
generate_supply(3) :- random(0,15,Type), random(1,11,I), random(1,11,J), generate_ingredient(Type,I,J).
generate_supply(4) :- random(0,10,Type), random(1,11,I), random(1,11,J), generate_bag(Type,I,J).     

generate_weapon(0,I,J) :- asserta(supply(spatula,I,J)).
generate_weapon(1,I,J) :- asserta(supply(silverware_sling,I,J)).
generate_weapon(2,I,J) :- asserta(supply(salt_shaker,I,J)).
generate_weapon(3,I,J) :- asserta(supply(msg_shaker,I,J)).
generate_weapon(4,I,J) :- asserta(supply(trashbag,I,J)).

generate_ammo(0,I,J) :- asserta(supply(forks,I,J)).
generate_ammo(1,I,J) :- asserta(supply(knives,I,J)).
generate_ammo(2,I,J) :- asserta(supply(spoons,I,J)).
generate_ammo(3,I,J) :- asserta(supply(salt,I,J)).
generate_ammo(4,I,J) :- asserta(supply(msg,I,J)).
generate_ammo(5,I,J) :- asserta(supply(trash,I,J)).

generate_armor(0,I,J) :- asserta(supply(tray,I,J)).
generate_armor(1,I,J) :- asserta(supply(hand,I,J)).
generate_armor(2,I,J) :- asserta(supply(chef_hat,I,J)).
generate_armor(3,I,J) :- asserta(supply(pot,I,J)).
generate_armor(4,I,J) :- asserta(supply(apron,I,J)).
generate_armor(5,I,J) :- asserta(supply(mittens,I,J)).

generate_ingredient(0,I,J) :- asserta(supply(patty,I,J)).
generate_ingredient(1,I,J) :- asserta(supply(moldy_patty,I,J)).
generate_ingredient(2,I,J) :- asserta(supply(cheese,I,J)).
generate_ingredient(3,I,J) :- asserta(supply(moldy_cheese,I,J)).
generate_ingredient(4,I,J) :- asserta(supply(milk,I,J)).
generate_ingredient(5,I,J) :- asserta(supply(spoiled_milk,I,J)).
generate_ingredient(6,I,J) :- asserta(supply(rice,I,J)).
generate_ingredient(7,I,J) :- asserta(supply(bread,I,J)).
generate_ingredient(8,I,J) :- asserta(supply(moldy_bread,I,J)).
generate_ingredient(9,I,J) :- asserta(supply(banana,I,J)).
generate_ingredient(10,I,J) :- asserta(supply(banana_peel,I,J)).
generate_ingredient(11,I,J) :- asserta(supply(egg,I,J)).
generate_ingredient(12,I,J) :- asserta(supply(raw_egg,I,J)).
generate_ingredient(13,I,J) :- asserta(supply(chicken_meat,I,J)).
generate_ingredient(14,I,J) :- asserta(supply(chicken,I,J)).

generate_bag(0,I,J) :- asserta(supply(extra_pocket,I,J)).
generate_bag(1,I,J) :- asserta(supply(extra_pocket,I,J)).
generate_bag(2,I,J) :- asserta(supply(extra_pocket,I,J)).
generate_bag(3,I,J) :- asserta(supply(flour_sack,I,J)).
generate_bag(4,I,J) :- asserta(supply(flour_sack,I,J)).
generate_bag(5,I,J) :- asserta(supply(cardboard_box,I,J)).
generate_bag(6,I,J) :- asserta(supply(cardboard_box,I,J)).
generate_bag(7,I,J) :- asserta(supply(cardboard_box,I,J)).
generate_bag(8,I,J) :- asserta(supply(trolley,I,J)).
generate_bag(9,I,J) :- asserta(supply(fridge,I,J)).

drop_supply :-
    random(0, 5, R),
    generate_supply(R). 

update_supplies :- clock(X), 0 is mod(X,5), !, drop_supply.
update_supplies :- clock(X), \+ 0 is mod(X,5).

supply_list(L) :- findall((Type,I,J), supply(Type,I,J), L).

/*---------- The One Procedure to Change It All ----------*/
tick_tock :-
    update_clock,
    update_deadzone,
    player_in_deadzone,
    update_supplies, !,
    update_enemies, !. 

