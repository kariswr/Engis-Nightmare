countElmt([],0).
countElmt([_|T],X) :- countElmt(T,N), X is N+1.

is_member(A,[B|_]) :- A == B.
is_member(A,[B|C]) :- A \== B, is_member(A,C).

delElmt(A,[A|T],T).
delElmt(A,[H|T],X) :- H \== A, append(H,delElmt(A,T,X),Result), X is Result.

/*---------- N, S, W, E ----------*/
n :- retract(player_position(I,J)), 
	X is I+1, 
	asserta(player_position(X,J)).

s :- retract(player_position(I,J)), 
	X is I-1, 
	asserta(player_position(X,J)).

w :- retract(player_position(I,J)),
	 X is J-1, 
	asserta(player_position(I,X)).

e :- retract(player_position(I,J)),
	 X is J+1, 
	asserta(player_position(I,X)).

/*---------- TAKE ----------*/
take(Name) :- supply(Name,I,J),
			 player_position(I,J),
			 player_inventory(L,Max), 
			 countElmt(L,X),
			 X <Max, 
			 append([Name],L,Result),
			 L is Result,
			 retract(supply(Name,I,J)),
			 message_take_succeed.

take(Name) :- supply(Name,I,J), 
			player_position(I,J), 
			player_inventory(L,Max), 
			countElmt(L,X), 
			X == Max,
			message_invent_full.

take(Name) :- player_position(I,J), 
			\+supply(Name,I,J),
			message_itemtake_notfound.

/*---------- DROP ----------*/
drop(Name) :- player_inventory(L,Max), 
			is_member(Name,L), 
			delElmt(Name,L,X), 
			L is X,
			asserta(supply(Name,I,J)).

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
		retract(enemy(EnName,I,J)).

attack :- enemy(EnName,I,J), 
		player_position(I,J), 
		player_weapon(Name,Ammo), 
		weapon(Name,Damage), 
		Ammo >0, 
		enemy_type(EnName,EnHealth), 
		Damage < EnHealth, 
		A is EnHealth - Damage, 
		EnHealth is A,
		retract(player_health(X)), 
		Y is X-1, 
		asserta(player_health(Y)).

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
