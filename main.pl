:- include('constants.pl').
:- include('save-load.pl').
:- include('player.pl').
:- include('display.pl').
:- include('command.pl').
:- include('enemy-supply.pl').

start :-
    show_title,
    asserta(game_ready(false)),
    repeat,
        prompt(Input),
        command(Input),
        (Input == 'quit'),
        show_credits.