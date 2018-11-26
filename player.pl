countElmt([],0).
countElmt([_|T],X) :- countElmt(T,N), X is N+1.

is_member(A,[B|_]) :- A == B.
is_member(A,[B|C]) :- A \== B, is_member(A,C).

addElmt(X, L, [X|L]).

ammo_ammount(Damage,EnHealth,Ammo) :- Damage >= EnHealth, Ammo is 1.
ammo_ammount(Damage,EnHealth,Ammo) :- Damage < EnHealth,X is EnHealth-Damage, ammo_ammount(Damage,X,N), Ammo is N +1. 

delete_one(_, [], []).
delete_one(Elmt, [Elmt|Tail], Tail).
delete_one(Elmt, [Head|Tail], [Head|Result]) :-
  delete_one(Elmt, Tail, Result).

match(A,B) :- A == silverware_sling, B == forks.
match(A,B) :- A == silverware_sling, B == knives.
match(A,B) :- A == silverware_sling, B == spoons.
match(A,B) :- A == salt_shaker, B == salt.
match(A,B) :- A == msg_shaker, B == msg.
match(A,B) :- A == trashbag, B == trash.

/*---------- N, S, W, E ----------*/
n :- retract(player_position(I,J)), 
	X is I-1, 
	asserta(player_position(X,J)),
	message_location.

s :- retract(player_position(I,J)), 
	X is I+1, 
	asserta(player_position(X,J)),
	message_location.

w :- retract(player_position(I,J)),
	 X is J-1, 
	asserta(player_position(I,X)),
	message_location.

e :- retract(player_position(I,J)),
	 X is J+1, 
	asserta(player_position(I,X)),
	message_location.	

/*---------- TAKE ----------*/
take(Name) :- supply(Name,I,J),
			 player_position(I,J),
			 player_inventory(L,Max), 
			 countElmt(L,X),
			 X <Max, 
			 append(L,[Name],Result),
			 retract(player_inventory(L,Max)),
			 asserta(player_inventory(Result,Max)),
			 retract(supply(Name,I,J)),
			 message_take_succeed(Name), !.

take(Name) :- supply(Name,I,J),
			player_position(I,J), 
			player_inventory(L,Max), 
			countElmt(L,X), 
			X == Max,
			message_take_inventfull, !.

take(Name) :-
			player_position(I,J),
			\+supply(Name,I,J), 
			message_take_notfound(Name).

/*---------- DROP ----------*/
drop(Name) :- player_inventory(L,Max),
			is_member(Name,L),
			delete_one(Name,L,X), 
			retract(player_inventory(L,Max)),
			asserta(player_inventory(X,Max)),
			player_position(I,J),
			asserta(supply(Name,I,J)),
			message_drop_succeed(Name), !.

drop(Name) :- player_inventory(L,_),
			\+is_member(Name,L), 
			message_drop_notfound(Name).
 
/*---------- ATTACK ----------*/
attack :-
		player_position(I,J),
		enemy(EnName,I,J),
		player_weapon(Name,Ammo),
		weapon(Name,Damage),
		Ammo >0,
		enemy_type(EnName,EnHealth),
		Damage >= EnHealth,
		retract(enemy(EnName,I,J)),
		message_attack_succeed(EnName), !.

attack :-
		player_position(I,J),
		enemy(EnName,I,J),
		player_weapon(Name,Ammo),
		weapon(Name,Damage),
		Ammo >0,
		enemy_type(EnName,EnHealth),
		Damage < EnHealth, 
		TotalDamage is Damage*Ammo,
		TotalDamage >= EnHealth,
		ammo_ammount(Damage,EnHealth,A),
		retract(player_health(X)),
		Y is X-A, 
		asserta(player_health(Y)),
		retract(player_weapon(Name,Ammo)),
		Q is Ammo-A,
		asserta(player_weapon(Name,Q)),
		message_attack_injuredbutsucceed(EnName,A), !.

attack :-
		player_position(I,J),
		enemy(EnName,I,J), 
		player_weapon(Name,Ammo), 
		weapon(Name,Damage), 
		Ammo >0, 
		enemy_type(EnName,EnHealth),
		Damage < EnHealth, 
		TotalDamage is Damage*Ammo, 
		TotalDamage < EnHealth,
		write('Test2'),		
		message_attack_playerdead, !,
		message_lose,
    	erase_memory,
   		asserta(game_ready(false)).

attack :-
		player_position(I,J), 		
		enemy(_,I,J), 
		player_weapon(_,0), 
		message_attack_noammo, !.

attack :-
		player_position(I,J), 
		enemy(_,I,J), 
		player_weapon(none,_), 
		message_attack_noweapon, !.

attack :-
		player_position(I,J),
		\+enemy(_,I,J), 
		message_attack_noenemy.


/*------------USE-------------*/
use_ingredient(0, Name, Effect) :-
	player_health(Health),
	Q is Health - Effect,
	retract(player_health(Health)),
	asserta(player_health(Q)),
	message_use_ingredient_bad(Name,Effect), !.

use_ingredient(1, Name, Effect) :-
	player_health(Health),
	Q is Health + Effect,
	retract(player_health(Health)),
	asserta(player_health(Q)),
	message_use_ingredient_good(Name,Effect), !.

use(Name) :- player_inventory(L,Max),
			is_member(Name,L),
			weapon(Name,_),
			player_weapon(none,0),
			retract(player_weapon(none,0)),
			asserta(player_weapon(Name,0)),
			delete_one(Name,L,Result),
			retract(player_inventory(L,Max)),
			asserta(player_inventory(Result,Max)),
			message_use_weapon(Name), !.

use(Name) :- player_inventory(L,Max),
			is_member(Name,L),
			weapon(Name,X),
			player_weapon(Weapon,A),
			retract(player_weapon(Weapon,A)),
			asserta(player_weapon(Name,0)),
			delete_one(Name,L,X),
			addElmt(Weapon,X,Y),
			retract(player_inventory(L,Max)),
			asserta(player_inventory(Y,Max)),
			message_use_weapon(Name), !.

use(Name) :- player_inventory(L,Max),
			is_member(Name,L),
			ingredient(Name,Effect),
			random(0,2,R),
			use_ingredient(R, Name, Effect),
			delete_one(Name,L,X),
			retract(player_inventory(L,Max)),
			asserta(player_inventory(X,Max)), !.

use(Name) :- player_inventory(L,Max),
			is_member(Name,L),
			armor(Name,Effect),
			player_armor(Strength),
			Q is Strength + Effect,
			retract(player_armor(Strength)),
			asserta(player_armor(Q)),
			delete_one(Name,L,X),
			retract(player_inventory(L,Max)),
			asserta(player_inventory(X,Max)),
			message_use_armor(Name,Effect), !.

/* use ammo(sesuai weapon ga), use bag*/
use(Name) :- player_inventory(L,_),
			is_member(Name,L),
			ammo(Name,X,Y),
			player_weapon(Weapon,Ammo),
			match(Weapon,Name),
			MaxRand is Y + 1, random(X,MaxRand,Effect),
			Q is Ammo + Effect,
			retract(player_weapon(Weapon,Ammo)),
			asserta(player_weapon(Weapon,Q)),
			delete_one(Name,L,Result),
			retract(player_inventory(L,Max)),
			asserta(player_inventory(Result,Max)),
			message_use_ammo(Name,Effect), !.

use(Name) :- player_inventory(L,_),
			is_member(Name,L),
			ammo(Name,_,_),
			player_weapon(Weapon,_),
			\+match(Weapon,Name),
			message_wrong_ammo(Weapon), !.

use(Name) :- player_inventory(L,Max),
			is_member(Name,L),
			bag(Name,W),
			Capacity is Max+W,
			delete_one(Name,L,X),
			retract(player_inventory(L,Max)),
			asserta(player_inventory(X,Capacity)),
			message_use_bag(Name,W), !.


use(Name) :- player_inventory(L,_),
			\+is_member(Name,L),
			message_use_notfound(Name).