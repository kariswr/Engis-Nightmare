/*---------- GAME STATUS ----------*/
:- dynamic(game_ready/1).       % game_ready(boolean)

/* ---------- PLAYER STATUS ----------*/
:- dynamic(player_position/2).  % player_position(i,j)
:- dynamic(player_armor/1).     % player_armor(int)
:- dynamic(player_weapon/2).    % player_weapon(Name,Ammo)
:- dynamic(player_health/1).    % player_health(int)
:- dynamic(player_inventory/2). % player_inventory(List,Capacity)

/*---------- ENEMIES & SUPPLIES ----------*/
:- dynamic(supply/3).           % object(Name,i,j)
:- dynamic(enemy/3).            % enemy(Name,i,j)
:- dynamic(num_enemies/1).      % num_enemies(int)

/*---------- IN-GAME STATUS ----------*/
:- dynamic(clock/1).            % clock(int)
:- dynamic(deadzone/2).         % deadzone(i,j)

/*---------- ENEMY TYPES ----------*/
% enemy(Name,Health)
enemy_type(customer, 10).
enemy_type(star_customer, 20).
enemy_type(hobo, 15).
enemy_type(rodent, 5).
enemy_type(flies, 5).
enemy_type(food_critic, 30).

/*---------- WEAPON ----------*/
% weapon(Name,Damage)
weapon(spatula, 3).
weapon(silverware_sling, 5).
weapon(salt_shaker, 1).
weapon(msg_shaker, 30).
weapon(trashbag, 10).

/*--------- AMMO ----------*/
% ammo(WeaponName,MinNumber,MaxNumber)
ammo(forks, 2, 5).
ammo(knives, 2, 5).
ammo(spoons, 2, 5).
ammo(salt, 10, 30).
ammo(msg, 1, 1).
ammo(trash, 1, 3).

/*---------- ARMOR ----------*/
% armor(Name,Strength)
armor(tray, 20).
armor(hand, 20).
armor(chef_hat, 10).
armor(pot, 15).
armor(apron, 5).
armor(mittens, 5).

/*---------- INGREDIENTS ----------*/
% ingredient(Name,Effect)
ingredient(patty, 20).
ingredient(cheese, 15).
ingredient(milk, 15).
ingredient(rice, 20).
ingredient(bread, 15).
ingredient(banana, 10).
ingredient(egg, 20).
ingredient(chicken, -10).

/*---------- BAG ----------*/
% bag(Name,Capacity)
bag(extra_pocket, 1).
bag(flour_sack, 5).
bag(cardboard_box, 5).
bag(trolley, 15).
bag(fridge, 30).

/*---------- AREAS ----------*/
% area(i,j,Name)
area(1, 1, lounge).
area(2, 1, lounge).
area(3, 1, lounge).
area(4, 1, lounge).
area(5, 1, lounge).
area(6, 1, lounge).
area(1, 2, lounge).
area(2, 2, lounge).
area(3, 2, lounge).
area(4, 2, lounge).
area(5, 2, lounge).
area(6, 2, lounge).
area(1, 3, lounge).
area(2, 3, lounge).
area(3, 3, lounge).
area(4, 3, lounge).
area(5, 3, lounge).
area(6, 3, lounge).
area(1, 4, waiting_line).
area(2, 4, waiting_line).
area(3, 4, waiting_line).
area(4, 4, waiting_line).
area(5, 4, waiting_line).
area(1, 5, waiting_line).
area(2, 5, waiting_line).
area(3, 5, waiting_line).
area(4, 5, waiting_line).
area(5, 5, waiting_line).
area(1, 6, waiting_line).
area(2, 6, waiting_line).
area(3, 6, waiting_line).
area(4, 6, waiting_line).
area(5, 6, waiting_line).
area(1, 7, waiting_line).
area(2, 7, waiting_line).
area(3, 7, waiting_line).
area(4, 7, waiting_line).
area(5, 7, waiting_line).
area(6, 4, counter).
area(6, 5, counter).
area(6, 6, counter).
area(6, 7, counter).
area(1, 8, indoor_seating).
area(2, 8, indoor_seating).
area(3, 8, indoor_seating).
area(4, 8, indoor_seating).
area(5, 8, indoor_seating).
area(6, 8, indoor_seating).
area(1, 9, indoor_seating).
area(2, 9, indoor_seating).
area(3, 9, indoor_seating).
area(4, 9, indoor_seating).
area(5, 9, indoor_seating).
area(6, 9, indoor_seating).
area(1, 10, indoor_seating).
area(2, 10, indoor_seating).
area(3, 10, indoor_seating).
area(4, 10, indoor_seating).
area(5, 10, indoor_seating).
area(6, 10, indoor_seating).
area(7, 1, kitchen).
area(7, 2, kitchen).
area(7, 3, kitchen).
area(7, 4, kitchen).
area(7, 5, kitchen).
area(7, 6, kitchen).
area(7, 7, kitchen).
area(8, 1, kitchen).
area(8, 2, kitchen).
area(8, 3, kitchen).
area(8, 4, kitchen).
area(8, 5, kitchen).
area(8, 6, kitchen).
area(8, 7, kitchen).
area(9, 1, kitchen).
area(9, 2, kitchen).
area(9, 3, kitchen).
area(9, 4, kitchen).
area(9, 5, kitchen).
area(9, 6, kitchen).
area(9, 7, kitchen).
area(10, 1, kitchen).
area(10, 2, kitchen).
area(10, 3, kitchen).
area(10, 4, kitchen).
area(10, 5, kitchen).
area(10, 6, kitchen).
area(10, 7, kitchen).
area(7, 8, pantry).
area(7, 9, pantry).
area(7, 10, pantry).
area(8, 8, pantry).
area(8, 9, pantry).
area(8, 10, pantry).
area(9, 8, pantry).
area(9, 9, pantry).
area(9, 10, pantry).
area(10, 8, pantry).
area(10, 9, pantry).
area(10, 10, pantry).
