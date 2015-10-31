%include('auxiliar.pl').

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%        BOARD DRAWING        %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%--Creating a New Line--%%%%

addLine(_, A, A).  %stop condition

addLine([H|T], I, S):-
	I1 is I+1,
	fillLine(H, 0, S),	
	addLine(T, I1, S). 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%--Fills Line--%%%%%%%%%

fillLine(_, A,A). %stop condition

fillLine([H|T], I, S):-
	I1 is I+1,
	H = '  ',
	fillLine(T, I1, S).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%--Prints Line--%%%%%%%%%

printLine([]):-
	write('|').

printLine([H|T]):-
	write('|'),
	write(' '),
	%getSymbol(H, H1),
	write('W '),
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
	printIndiceV(I), %prints vertical indice
	printLine(H), nl, 
	write('  '),
	printDivisor(H), nl,
	I1 is I+1,
	printMorelli(T, I1).
	
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%--Main Function--%%%%%%%
startMorelli(I, S):- %I is zero, S is board size
	addLine([H|T], I, S),
	printIndice(0,S), %prints horizontal indice
	write('  '),
	printFirstDivisor(0, S), %prints first divisor
	printMorelli([H|T], 0). %prints board

