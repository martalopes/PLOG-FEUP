:- use_module(library(random)).
:- include('auxiliar.pl').
:- include('menu.pl').
:- include('checkmove.pl').


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%        BOARD DRAWING        %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%--Creating a New Line--%%%%

addLine(_, Max, Max, _).  %stop condition

addLine([H|T], 0, BoardSize, [Y|Z]):-		%adds the first line with random piece
	fillFirstLine(H, 0, BoardSize, [Y|Z]),
	addLine(T, 1, BoardSize, [Y|Z]). 

addLine([H|T], I, BoardSize, [Y|Z]):-		%adds the last line which is the reverse of the first
	I+1=:=BoardSize,
	fillLastLine(H, 0, BoardSize, [Y|Z]).

addLine([H|T], I, BoardSize, [Y|Z]):-		%fills the middle lines
	I1 is I+1,
	firstPiece(H, 0, BoardSize),
	addLine(T, I1, BoardSize, [Y|Z]). 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%--Fills Line--%%%%%%%%%
fillFirstLine(_, A,A,_). %stop condition

fillFirstLine([H|T], I, BoardSize, [Y|Z]):-
	I1 is I+1,
	random(1, 3, H1),
	H = H1,
	reverseColor(H2,H1),
	Y = H2,
	fillFirstLine(T, I1, BoardSize, Z).

fillLastLine(_, A,A, _). %stop condition

fillLastLine([H|T], I, BoardSize, [Y|Z]):-
	I1 is I+1,
	H = Y,
	fillLastLine(T, I1, BoardSize, Z).

firstPiece([H|T], I, BoardSize):-
	random(1,3,First),
	H = First,
	fillLine(T, 1, BoardSize, First).

fillLine(_, Max, Max, _).

fillLine([H|T], I,BoardSize, First):-
	I+1=:=BoardSize,
	reverseColor(Last, First),
	H = Last.

fillLine([H|T], I, BoardSize, First):-
	I1 is I+1,
	H = 0,
	fillLine(T, I1, BoardSize, First).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%--Prints Line--%%%%%%%%%

printLine([]):-
	write('|').

printLine([H|T]):-
	write('|'),
	write(' '),
	getSymbol(H, X),
	write(X),
	write(' '),
	printLine(T).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%Prints Divisors%%%%%%%

printDivisor([]):-
	write('|').

printDivisor([H|T]):-
	write('|'),
	write('----'),
	printDivisor(T).

printFirstDivisor(A,A):- 
	write('|'),nl.

printFirstDivisor(I, BoardSize):-
	I1 is I+1,
	write('|'),
	write('----'),
	printFirstDivisor(I1, BoardSize).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%Prints Vertical Indice%%%%%

printIndiceV(I):-
	I1 is I+1,
	I1 < 10,
	write(' '),
	write(I1).

printIndiceV(I):-
	I1 is I+1,
	I1 > 9,
	write(I1).


%%%Prints Horizontal Indice %%%%

printIndice(A,A):- 
	nl.

printIndice(I,BoardSize):-
	I < 10,
	I1 is I+1,
	write('    '),
	write(I1),
	write(''),
	printIndice(I1, BoardSize).

printIndice(I,BoardSize):-
	I > 9,
	I1 is I+1,
	write('   '),
	write(I1),
	printIndice(I1, BoardSize).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%% Prints Board %%%%%%%%%%

printMorelli([], _).

printMorelli([H|T], I):-
	printIndiceV(I), %prints vertical indice
	printLine(H), nl, 
	write('  '),
	printDivisor(H), nl,
	I1 is I+1,
	printMorelli(T, I1).
	
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%--Main Function--%%%%%%%
startMorelli:- %I is zero, S is board size
	mainMenu.

startDrawingBoard(I, BoardSize):-
	addLine(Board, 0, BoardSize, AuxList),
	printIndice(0,BoardSize), %prints horizontal indice
	write('  '),
	printFirstDivisor(0, BoardSize), %prints first divisor
	printMorelli(Board, 0), %prints board
	validInput(1,1,3,2, Board).

