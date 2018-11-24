countElmt([],0).
countElmt([_|T],X) :- countElmt(T,N), X is N+1.

append([],List,List).
append([Head|Tail],List2,[Head|Result]):- append(Tail,List2,Result).

is_member(A,[B|_]) :- A == B.
is_member(A,[B|C]) :- A \== B, is_member(A,C).

delElmt(A,[A|T],T).
delElmt(A,[H|T],X) :- H \== A, append(H,delElmt(A,T,X),Result), X is Result.

/*---------- N, S, W, E ----------*/
n :- x is i+1, player_position(x,j), next_tick.
s :- x is i-1, player_position(x,j), next_tick.
w :- x is j-1, player_position(i,x), next_tick.
e :- x is j+1, player_position(i,x), next_tick.

/*---------- TAKE ----------*/
take(Name) :- supply(Name,i,j), player_position(i,j), player_inventory(L,Max), countElmt(L,x), x <Max, append([Name],L,Resutl), L is Result,retract(supply(Name,i,j)),message_take_succeed.
take(Name) :- supply(Name,i,j), player_position(i,j), player_inventory(L,Max), countElmt(L,x), x = Max,message_invent_full.
take(Name) :- player_position(i,j), \+supply(Name,i,j),message_take_failed.

/*---------- DROP ----------*/
drop(Name) :- player_inventory(L,Max), is_member(Name,L), delElmt(Name,L,X), L is X,asserta(supply(name,i,j)).
drop(Name) :- player_inventory(L,Max), \+is_member(Name,L), message_invent_notfound.
 
/*---------- ATTACK ----------*/
attack :- enemy (EnName,i,j), player_position(i,j), player_weapon(Name,Ammo), weapon(Name,Damage), Ammo >0, enemy_type(EnName,EnHealth), Damage >= EnHealth, retract(enemy(EnName,i,j)).
attack :- enemy (EnName,i,j), player_position(i,j), player_weapon(Name,Ammo), weapon(Name,Damage), Ammo >0, enemy_type(EnName,EnHealth), Damage < EnHealth, a is EnHealth - Damage, EnHealth is a, 
			retract(player_health(x)), y is x-1, asserta(player_health(y)).
attack :- enemy (EnName,i,j), player_position(i,j), player_weapon(Name,Ammo), weapon(Name,Damage), Ammo == 0, message_no_ammo.
attack :- \+enemy(EnName,i,j), message_noenemy_around.
