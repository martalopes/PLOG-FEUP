:- include('tools.pl').

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%          GAME MENUS	      %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


mainMenu:-
	printMainMenu,
	getChar(Answer),
	(
		Answer = '1' -> gameMenu, mainMenu;
		Answer = '2' -> helpMenu, mainMenu;
		Answer = '3' -> aboutMenu, mainMenu;
		Answer = '4';

		nl,
		write('Error: invalid input.'), nl,
		pressEnterToContinue, nl,
		mainMenu
	).

printMainMenu:-
	clearScreen(40),
	write('---------------------------------'), nl,
	write('              MORELLI            '), nl,
	write('      Created by Richard Moxham  '), nl,
	write('---------------------------------'), nl,
	write('                                 '), nl,
	write('    1. Start Game                '), nl,
	write('    2. Rules                     '), nl,
	write('    3. About                     '), nl,
	write('    4. Quit                      '), nl,
	write('---------------------------------'), nl,
	write('Choose an option:'), nl,
	write('                                 '), nl.

gameMenu:-
	printGameMenu,
	getChar(Answer),
	(
		Answer = '1' -> startPvsP, gameMenu;
		Answer = '2' -> startPvsB, gameMenu;
		Answer = '3' -> startBvsB, gameMenu;
		Answer = '4' -> mainMenu;

		nl,
		write('Error: invalid input.'), nl,
		pressEnterToContinue, nl,
		gameMenu

	).

startPvsP:-
	clearScreen(40).

%startPvsB:-
%	startPvsBGame(Game),
%	playGame(Game).

%startBvsB:-
%	startPvsPGame(Game),
%	playGame(Game).


printGameMenu:-
	clearScreen(40),
	write('---------------------------------'), nl,
	write('             GAME MENU           '), nl,
	write('---------------------------------'), nl,
	write('                                 '), nl,
	write('    1. Player Vs. Player         '), nl,
	write('    2. Player Vs. Bot            '), nl,
	write('    3. Bot Vs. Bot               '), nl,
	write('    4. Return                    '), nl,
	write('---------------------------------'), nl,
	write('Choose an option:'), nl,
	write('                                 '), nl.


helpMenu:-
	clearScreen(40),
	write('---------------------------------'), nl,
	write('             HELP MENU           '), nl,
	write('---------------------------------'), nl,
	pressEnterToContinue.


aboutMenu:-
	clearScreen(40),
	write('---------------------------------'), nl,
	write('           ABOUT THE GAME        '), nl,
	write('---------------------------------'), nl,
	write('                                 '), nl,
	write('                                 '), nl,
	write('                                 '), nl,
	pressEnterToContinue.
	


playGame:-
	clearScreen(40),
	startDrawingBoard(0,13),

	pressEnterToContinue, !.
	