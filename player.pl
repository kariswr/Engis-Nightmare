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


/*---------- N, S, W, E ----------*/
n :- retract(player_position(I,J)), 
	X is I-1, 
	asserta(player_position(X,J)).

s :- retract(player_position(I,J)), 
	X is I+1, 
	asserta(player_position(X,J)).

w :- retract(player_position(I,J)),
	 X is J-1, 
	asserta(player_position(I,X)).

e :- retract(player_position(I,J)),
	 X is J+1, 
	asserta(player_position(I,X)).	

/*---------- TAKE ----------*/
take(Name) :- supply(Name,I,J), !,
			 player_position(I,J),
			 player_inventory(L,Max), 
			 countElmt(L,X),
			 X <Max, 
			 append([Name],L,Result),
			 retract(player_inventory(L,Max)),
			 asserta(player_inventory(Result,Max)),
			 retract(supply(Name,I,J)),
			 message_take_succeed.

take(Name) :- supply(Name,I,J), !,
			player_position(I,J), 
			player_inventory(L,Max), 
			countElmt(L,X), 
			X == Max,
			message_invent_full.

take(Name) :- \+supply(Name,I,J),
			player_position(I,J), 
			message_itemtake_notfound.

/*---------- DROP ----------*/
drop(Name) :- player_inventory(L,Max),
			is_member(Name,L),
			delete_one(Name,L,X), 
			retract(player_inventory(L,Max)),
			asserta(player_inventory(X,Max)),
			asserta(supply(Name,I,J)),
			message_drop_succeed.

drop(Name) :- player_inventory(L,Max),
			\+is_member(Name,L), 
			message_inventdrop_notfound.
 
/*---------- ATTACK ----------*/
attack :- enemy(EnName,I,J),
		player_position(I,J),
		player_weapon(Name,Ammo),
		weapon(Name,Damage), 
		Ammo >0, 
		enemy_type(EnName,EnHealth), 
		Damage >= EnHealth,
		retract(enemy(EnName,I,J)),
		message_enemy_killed.

attack :- enemy(EnName,I,J), 
		player_position(I,J), 
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
		message_injured_butenemykilled.

attack :- enemy(EnName,I,J), 
		player_position(I,J), 
		player_weapon(Name,Ammo), 
		weapon(Name,Damage), 
		Ammo >0, 
		enemy_type(EnName,EnHealth),
		Damage < EnHealth, 
		TotalDamage is Damage*Ammo, 
		TotalDamage < EnHealth.

attack :- enemy(EnName,I,J), 
		player_position(I,J), 
		player_weapon(Name,Ammo), 
		weapon(Name,Damage), 
		Ammo == 0, 
		message_no_ammo.

attack :- enemy(EnName,I,J), 
		player_position(I,J), 
		player_weapon(Name,Ammo), 
		Name == 'none', 
		message_no_weapon.

attack :- \+enemy(EnName,I,J), 
		message_noenemy_here.
