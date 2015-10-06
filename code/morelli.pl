addLine(_, A, A).

addLine([H|T], I, S):-
	I1 is I+1,
	addCol(H, 0, S),
	addLine(T, I1, S). 


addCol(_, A,A).

addCol([H|T], I, S):-
	I1 is I+1,
	H = ' ',
	addCol(T, I1, S).


printLine([]):-
	write('|').

printLine([H|T]):-
	write('|'),
	write(' '),
	write(H),
	write(' '),
	printLine(T).

printDivisor([]):-
	write('|').

printDivisor([H|T]):-
	write('|'),
	write('---'),
	printDivisor(T).

printFirstDivisor(A,A):- 
	write('|'),nl.

printFirstDivisor(I, S):-
	I1 is I+1,
	write('|'),
	write('---'),
	printFirstDivisor(I1, S).


printIndiceV(I):-
	write(I),
	write(' ').

printIndice(A,A):- 
	nl.

printIndice(I,S):-
	I1 is I+1,
	write('  '),
	write(I),
	write(' '),
	printIndice(I1, S).


printMorelli([], _).

printMorelli([H|T], I):-
	printLine(H), nl,
	printIndiceV(I),
	printDivisor(H), nl,
	I1 is I+1,
	printMorelli(T, I1).
	


startMorelli(I, S):-
	addLine([H|T], I, S),
	printIndice(0,S),
	printFirstDivisor(0, S),
	printMorelli([H|T], 0).

