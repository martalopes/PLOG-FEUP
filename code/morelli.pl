include('auxiliar.pl').

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%        BOARD DRAWING        %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%Adding a New Line%%%%%%%%%

addLine(_, A, A).

addLine([H|T], I, S):-
	I1 is I+1,
	fillLine(H, 0, S),
	addLine(T, I1, S). 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%Fills Line%%%%%%%%%%%
fillLine(_, A,A).

fillLine([H|T], I, S):-
	I1 is I+1,
	H = '  ',
	fillLine(T, I1, S).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%Prints Line%%%%%%%%%%%

printLine([]):-
	write('|').

printLine([H|T]):-
	write('|'),
	write(' '),
	getSymbol(H, H1),
	write(H1),
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

printFirstDivisor(I, S):-
	I1 is I+1,
	write('|'),
	write('----'),
	printFirstDivisor(I1, S).

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

printIndice(I,S):-
	I < 10,
	I1 is I+1,
	write('    '),
	write(I1),
	write(''),
	printIndice(I1, S).

printIndice(I,S):-
	I > 9,
	I1 is I+1,
	write('   '),
	write(I1),
	printIndice(I1, S).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%% Prints Board %%%%%%%%%%

printMorelli([], _).

printMorelli([H|T], I):-
	printIndiceV(I),
	
	printLine(H), nl,
	write('  '),
	printDivisor(H), nl,
	I1 is I+1,
	printMorelli(T, I1).
	
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%Example%%%%%%%%%%%%%%
gameExample1(K) :-
	K =
	[
	[black, black, black, black, black, black, black, black, black, black, black, black, black],
	[white, empty, empty, empty, empty, empty, empty, empty, empty, empty, empty, empty, black],
	[white, empty, empty, empty, empty, empty, empty, empty, empty, empty, empty, empty, black],
	[white, empty, empty, empty, empty, empty, empty, empty, empty, empty, empty, empty, black],
	[white, empty, empty, empty, empty, empty, empty, empty, empty, empty, empty, empty, black],
	[white, empty, empty, empty, empty, empty, empty, empty, empty, empty, empty, empty, black],
	[white, empty, empty, empty, empty, empty, emptyCenter, empty, empty, empty, empty, empty, black],
	[white, empty, empty, empty, empty, empty, empty, empty, empty, empty, empty, empty, black],
	[white, empty, empty, empty, empty, empty, empty, empty, empty, empty, empty, empty, black],
	[white, empty, empty, empty, empty, empty, empty, empty, empty, empty, empty, empty, black],
	[white, empty, empty, empty, empty, empty, empty, empty, empty, empty, empty, empty, black],
	[white, empty, empty, empty, empty, empty, empty, empty, empty, empty, empty, empty, black],
	[white, white, white, white, white, white, white, white, white, white, white, white, black]
	].

gameExample2(K) :-
	K =
	[
	[black, empty, black, black, black, black, black, black, empty, black, black, black, black],
	[white, empty, empty, empty, empty, empty, empty, empty, empty, empty, empty, empty, black],
	[white, empty, empty, black, empty, empty, empty, empty, empty, empty, empty, empty, black],
	[white, empty, empty, empty, empty, empty, empty, empty, black, empty, empty, empty, black],
	[white, empty, empty, empty, empty, empty, empty, empty, empty, empty, empty, empty, black],
	[empty, empty, white, empty, empty, empty, empty, empty, empty, empty, empty, empty, black],
	[white, empty, empty, empty, empty, empty, emptyCenter, empty, empty, empty, empty, empty, black],
	[white, empty, empty, empty, empty, empty, empty, empty, empty, empty, empty, empty, black],
	[white, empty, empty, empty, empty, empty, empty, empty, empty, empty, empty, empty, black],
	[white, empty, empty, empty, empty, empty, empty, empty, empty, empty, empty, empty, black],
	[white, empty, empty, empty, white, empty, empty, empty, empty, empty, empty, empty, black],
	[white, empty, empty, empty, empty, empty, empty, empty, empty, empty, empty, empty, black],
	[white, white, empty, white, white, white, white, white, white, white, white, white, black]
	].

gameExample3(K) :-
	K =
	[
	[empty, empty, empty, empty, empty, empty, empty, empty, empty, empty, empty, empty, empty],
	[empty, empty, empty, empty, empty, empty, empty, empty, empty, empty, empty, empty, empty],
	[empty, empty, empty, empty, empty, empty, empty, empty, black, empty, empty, empty, empty],
	[empty, empty, empty, black, black, black, black, black, black, empty, empty, empty, empty],
	[empty, empty, black, black, black, black, black, black, black, empty, empty, empty, empty],
	[empty, empty, empty, black, white, white, black, white, black, empty, empty, empty, empty],
	[empty, empty, white, black, white, white, whiteTower, black, black, empty, empty, empty, empty],
	[empty, empty, white, black, white, white, white, black, empty, black, empty, empty, empty],
	[empty, empty, white, white, white, white, white, white, black, white, empty, empty, empty],
	[empty, empty, empty, black, white, white, white, white, empty, white, empty, empty, empty],
	[empty, empty, empty, white, empty, empty, empty, empty, white, white, empty, empty, empty],
	[empty, empty, empty, empty, empty, empty, empty, empty, empty, empty, empty, empty, empty],
	[empty, empty, empty, empty, empty, empty, empty, empty, empty, empty, empty, empty, empty]
	].



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

startMorelli(I, S):-
	%addLine([H|T], I, S),
	gameExample1(K),
	printIndice(0,S),
	write('  '),
	printFirstDivisor(0, S),
	printMorelli(K, 0).

