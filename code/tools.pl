clearScreen(0).

clearScreen(N):-
	nl,
	N1 is N-1,
	clearScreen(N1).

getChar(Answer):-
	get_char(Answer),
	get_char(_).

pressEnterToContinue:-
	write('Press <Enter> to continue.'), nl,
	waitForEnter, !.

waitForEnter:-
	get_char(_).