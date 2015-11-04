clearScreen(0).

clearScreen(N):-
	nl,
	N1 is N-1,
	clearScreen(N1).

getChar(Answer):-
	get_char(Answer),
	get_char(_).

getInt(Answer):-
	get_code(TempA),
	Answer is TempA - 48.

cleanBuffer:-
	get_code(_).

pressEnterToContinue:-
	write('Press <Enter> to continue.'), nl,
	waitForEnter, !.

waitForEnter:-
	get_char(_).


%%% 1. element row; 2. element column; 3. matrix; 4. query element.
getMatrixElemAt(0, ElemCol, [ListAtTheHead|_], Elem):-
	getListElemAt(ElemCol, ListAtTheHead, Elem).

getMatrixElemAt(ElemRow, ElemCol, [_|RemainingLists], Elem):-
	ElemRow > 0,
	ElemRow1 is ElemRow-1,
	getMatrixElemAt(ElemRow1, ElemCol, RemainingLists, Elem).

%%% 1. element position; 2. list; 3. query element.
getListElemAt(0, [ElemAtTheHead|_], ElemAtTheHead).
getListElemAt(Pos, [_|RemainingElems], Elem):-
	Pos > 0,
	Pos1 is Pos-1,
	getListElemAt(Pos1, RemainingElems, Elem).


%%% 1. element row; 2. element column; 3. element to use on replacement; 3. current matrix; 4. resultant matrix.
setMatrixElemAtWith(0, ElemCol, NewElem, [RowAtTheHead|RemainingRows], [NewRowAtTheHead|RemainingRows]):-
	setListElemAtWith(ElemCol, NewElem, RowAtTheHead, NewRowAtTheHead).
setMatrixElemAtWith(ElemRow, ElemCol, NewElem, [RowAtTheHead|RemainingRows], [RowAtTheHead|ResultRemainingRows]):-
	ElemRow > 0,
	ElemRow1 is ElemRow-1,
	setMatrixElemAtWith(ElemRow1, ElemCol, NewElem, RemainingRows, ResultRemainingRows).

%%% 1. position; 2. element to use on replacement; 3. current list; 4. resultant list.
setListElemAtWith(0, Elem, [_|L], [Elem|L]).
setListElemAtWith(I, Elem, [H|L], [H|ResL]):-
	I > 0,
	I1 is I-1,
	setListElemAtWith(I1, Elem, L, ResL).




checkEnd(Board, Row, Max, Max):-
	Row2 is Row + 1, 
	checkEnd(Board, Row2, 0, Max).


checkEnd(Board, Row, Col, Max):-
	RowPlus is Row + 1,
	RowMinus is Row - 1,
	ColPlus is Col + 1,
	ColMinus is Col - 1,

	%getMatrixElemAt(Row, Col, Board, Elem),
	%(Elem =:= 0 -> checkEnd(Board, Row, ColPlus, Max); true),

	%getMatrixElemAt(Row, Col, Board, PieceTest),
	%(Piece \= PieceTest -> checkEnd(Board, Row, ColPlus, Max, End, Piece); true),
	noMovement(Row, Col, RowPlus, Col, Board), 
	noMovement(Row, Col, RowMinus, Col, Board), 
	noMovement(Row, Col, Row, ColPlus, Board), 
	noMovement(Row, Col, Row, ColMinus, Board), 
	noMovement(Row, Col, RowPlus, ColPlus, Board), 
	noMovement(Row, Col, RowPlus, ColMinus, Board), 
	noMovement(Row, Col, RowMinus, ColPlus, Board), 
	noMovement(Row, Col, RowMinus, ColMinus, Board), 
	checkEnd(Board, Row, ColPlus, Max).

checkEnd(_, Max, Max, Max):-
	!, fail.

checkEnd(_,_,_,_):- fail.





