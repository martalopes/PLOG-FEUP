:- use_module(library(random)).
:- include('auxiliar.pl').
:- include('menu.pl').
:- include('checkmove.pl').
:- include('checkcapture.pl').

gameExample(K) :-
	K =
	[
	[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
	[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
	[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
	[0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0],
	[0, 0, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0],
	[0, 0, 0, 1, 2, 2, 1, 2, 1, 0, 0, 0, 0],
	[0, 0, 2, 1, 2, 2, 4, 1, 1, 0, 0, 0, 0],
	[0, 0, 2, 1, 2, 2, 2, 1, 0, 1, 0, 0, 0],
	[0, 0, 2, 2, 2, 2, 2, 2, 1, 2, 0, 0, 0],
	[0, 0, 0, 1, 2, 2, 2, 2, 2, 2, 0, 0, 0],
	[0, 0, 0, 2, 0, 0, 0, 0, 0, 2, 0, 0, 0],
	[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
	[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
	].
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%        BOARD DRAWING        %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%--Creating a New Line--%%%%

addLine(_, Max, Max, _).  %stop condition

addLine([H|T], 0, BoardSize, [Y|Z]):-		%adds the first line with random piece
	fillFirstLine(H, 0, BoardSize, [Y|Z]),
	addLine(T, 1, BoardSize, [Y|Z]). 

addLine([H|_], I, BoardSize, [Y|Z]):-		%adds the last line which is the reverse of the first
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

firstPiece([H|T], _, BoardSize):- %%%ALTERADO!!!!!!!!!pcausa de singletons
	random(1,3,First),
	H = First,
	fillLine(T, 1, BoardSize, First).

fillLine(_, Max, Max, _).

fillLine([H|_], I,BoardSize, First):- %%%ALTERADO!!!!!!!!!pcausa de singletons
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

printDivisor([_|T]):- %%%ALTERADO!!!!!!!!!pcausa de singletons
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
	I1 < 11,
	write(' '),
	write(I).

printIndiceV(I):-
	I1 is I+1,
	I1 > 10,
	write(I).


%%%Prints Horizontal Indice %%%%

printIndice(A,A):- 
	nl.

printIndice(I,BoardSize):-
	I < 11,
	I1 is I+1,
	write('    '),
	write(I),
	printIndice(I1, BoardSize).

printIndice(I,BoardSize):-
	I > 10,
	I1 is I+1,
	write('   '),
	write(I),
	printIndice(I1, BoardSize).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%% Prints Board %%%%%%%%%%

printGameZone([], _).

printGameZone([H|T], I):-
	printIndiceV(I), %prints vertical indice
	printLine(H), nl, 
	write('  '),
	printDivisor(H), nl,
	I1 is I+1,
	printGameZone(T, I1).

printMorelli(Board, I, BoardSize):-
	printIndice(0,BoardSize), %prints horizontal indice
	write('  '),
	printFirstDivisor(0, BoardSize), %prints first divisor
	printGameZone(Board, I).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%--Main Function--%%%%%%%
startMorelli:- %I is zero, S is board size
	mainMenu.

startDrawingBoard(_, BoardSize, Board1):-
	addLine(Board1, 0, BoardSize, _). %%%ALTERADO!!!!!!!!!pcausa de singletons
	%printIndice(0,BoardSize), %prints horizontal indice
	%write('  '),
	%printFirstDivisor(0, BoardSize). %prints first divisor
	%printMorelli(Board, 0). %prints board

%%%%%% PLAYER VS. PLAYER %%%%%%%
playGamePvP(Board,Player):-
	%startDrawingBoard(0,13, Board),
	gameExample(Board),
	setMatrixElemAtWith(6, 6, -1, Board, Board1), !,
	startGame(Board1, Player).

startGame(Board,Player):-
	getPlayerColor(Player, Piece), 
	checkEnd(Board, 1, 1, 13, Piece),
	getPlayerInput(Board,Player).

gameOver(Board):- 
	clearScreen(40),
	getMatrixElemAt(6,6, Board, Elem),
	getWinner(Winner, Elem),
	write('GAME OVER'),nl,	
	write('The winner is: '), write(Winner),nl,nl,
	printMorelli(Board, 0, 13),
	startMorelli.

getPlayerInput(Board,Player):-
	printMorelli(Board, 0, 13),
	printMessage(Player),
	getPieceCoords(Board, Player, CurrRow, CurrCol),
	getDestCoords(Board, Player, CurrRow, CurrCol, _, _).



getPieceCoords(Board, Player, CurrRow, CurrCol):-
	%getPlayerColor(Player, Piece2),
	write('Piece row? (example: 1.)'), nl,
	read(CurrRow),nl,
	write('Piece col? (example: 1.)'), nl,
	read(CurrCol),nl,
	getMatrixElemAt(CurrRow, CurrCol, Board, Piece),
	getPlayerColor(Player, Piece).

getPieceCoords(Board,Player,_,_):-
	write('ERROR!!! That is not your piece! Try again.'),nl,nl,
	startGame(Board, Player).


getDestCoords(Board, Player, CurrRow, CurrCol, DestRow, DestCol):-
	write('Destination row? (example: 1.)'), nl,
	read(DestRow),nl,
	write('Destination col? (example: 1.)'), nl,
	read(DestCol),nl,
	validInput(CurrRow, CurrCol, DestRow, DestCol, Board),
	getPlayerColor(Player, Piece),
	setMatrixElemAtWith(DestRow, DestCol, Piece, Board, Board1),
	setMatrixElemAtWith(CurrRow, CurrCol, 0, Board1, Board2),
	checkCapture(DestRow, DestCol, Piece, Board2, Board3),
	checkCenter(DestRow, DestCol, Piece, Board3, Board4),
	%checkEnd(Board, 1, 1, 11, End),% Piece2),
	%(End =:= 1 -> write('END OF GAME'); true),
	switchPlayer(NextPlayer, Player),
	startGame(Board4, NextPlayer).
	

getDestCoords(Board, Player, _, _, _, _):- %%%ALTERADO!!!!!!!!!pcausa de singletons
	write('Destination unknown'),nl,nl,
	startGame(Board, Player).



printMessage(Player):-
	Player == blackPlayer, write('Black Player turn: '),nl.

printMessage(Player):-
	Player == whitePlayer, write('White Player turn: '),nl.


checkCenter(DestRow, DestCol, Piece, Board, Board1):-
	DeltaRow is 6 - DestRow,
	DeltaCol is 6 - DestCol,

	P1Row is 6 - DeltaRow,
	P1Col is 6 - DeltaCol,

	getMatrixElemAt(P1Row, P1Col, Board, P1),
	P1 =:= Piece,

	P2Row is 6 + DeltaCol,
	P2Col is 6 - DeltaRow,

	getMatrixElemAt(P2Row, P2Col, Board, P2),
	P2 =:= Piece,


	P3Row is 6 - DeltaCol,
	P3Col is 6 + DeltaRow,

	getMatrixElemAt(P3Row, P3Col, Board, P3),
	P3 =:= Piece,

	getTower(Piece, Tower),

	setMatrixElemAtWith(6, 6, Tower, Board, Board1).

checkCenter(_,_,_,Board,Board1):-
	getMatrixElemAt(6,6, Board, GetPiece),
	setMatrixElemAtWith(6, 6, GetPiece, Board, Board1).


%endGame(DestRow, DestCol, Piece, Board, Board1):-

