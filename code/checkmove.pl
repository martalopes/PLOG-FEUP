
validMove(X,X, dr):-   %% down right
  	X > 0.

validMove(X,X, ul):- %% up left
	X < 0.

validMove(X1,X, dl):-  %% down left
	X1 =:= abs(X),
	X1 > 0,
	X < 0.

validMove(X1,X, ur):- %% up right
	X =:= abs(X1),
	X1 < 0,
	X > 0.

validMove(0,X, r):-  %% right
	X > 0.

validMove(0, X, l):-  %% left
	X < 0.

validMove(X,0, d):-   %% down
	X > 0.

validMove(X,0, u):-  %% up
	X < 0.


calculateLevel(Row,Col, Level):-
	DeltaRow is abs(6-Row),
	DeltaCol is abs(6-Col),
	Level is max(DeltaRow, DeltaCol).

searchVector(_,_,X,X,X1,dr,_):-
	X1 =:= X.

searchVector(CurrRow, CurrCol, DeltaRow, DeltaCol, It, dr, Board):-
	It1 is It + 1,
	It1 =< abs(DeltaRow),
	It1 =< abs(DeltaCol),
	NewCurrRow = CurrRow + 1,
	NewCurrCol = CurrCol + 1,
	getMatrixElemAt(NewCurrRow, NewCurrCol, Board, Elem),
	Elem =:= 0,
	searchVector(NewCurrRow, NewCurrCol, DeltaRow, DeltaCol, It1, dr, Board).

searchVector(_,_,X,X,X1,ul,_):-
	X1 =:= abs(X).
	
searchVector(CurrRow, CurrCol, DeltaRow, DeltaCol, It, ul, Board):-
	It1 is It + 1,
	It1 =< abs(DeltaRow),
	It1 =< abs(DeltaCol),
	NewCurrRow = CurrRow - 1,
	NewCurrCol = CurrCol - 1,
	getMatrixElemAt(NewCurrRow, NewCurrCol, Board, Elem),
	Elem =:= 0,
	searchVector(NewCurrRow, NewCurrCol, DeltaRow, DeltaCol, It1, ul, Board).

searchVector(_,_,X1,X,X1,dl,_):-
	X1 =:= abs(X).
		
searchVector(CurrRow, CurrCol, DeltaRow, DeltaCol, It, dl, Board):-
	It1 is It + 1,
	It1 =< abs(DeltaRow),
	It1 =< abs(DeltaCol),
	NewCurrRow = CurrRow + 1,
	NewCurrCol = CurrCol - 1,
	getMatrixElemAt(NewCurrRow, NewCurrCol, Board, Elem),
	Elem =:= 0,
	searchVector(NewCurrRow, NewCurrCol, DeltaRow, DeltaCol, It1, dl, Board).

searchVector(_,_,X1,X,X,ur,_):-
	X =:= abs(X1).

searchVector(CurrRow, CurrCol, DeltaRow, DeltaCol, It, ur, Board):-
	It1 is It + 1,
	It1 =< abs(DeltaRow),
	It1 =< abs(DeltaCol),
	NewCurrRow = CurrRow - 1,
	NewCurrCol = CurrCol + 1,
	getMatrixElemAt(NewCurrRow, NewCurrCol, Board, Elem),
	Elem =:= 0,
	searchVector(NewCurrRow, NewCurrCol, DeltaRow, DeltaCol, It1, ur, Board).
	
searchVector(_,_,0,X,X,r,_).

searchVector(CurrRow, CurrCol, DeltaRow, DeltaCol, It,  r, Board):-
	It1 is It + 1,
	It1 =< abs(DeltaCol),
	NewCurrCol = CurrCol + 1,
	getMatrixElemAt(CurrRow, NewCurrCol, Board, Elem),
	Elem =:= 0,
	searchVector(CurrRow, NewCurrCol, DeltaRow, DeltaCol, It1, r, Board).
	
searchVector(_,_,0,X1,X,l,_):-
	X =:= abs(X1).

searchVector(CurrRow, CurrCol, DeltaRow, DeltaCol, It, l, Board):-
	It1 is It + 1,
	It1 =< abs(DeltaCol),
	NewCurrCol = CurrCol - 1,
	getMatrixElemAt(CurrRow, NewCurrCol, Board, Elem),
	Elem =:= 0,
	searchVector(CurrRow, NewCurrCol, DeltaRow, DeltaCol, It1, l, Board).

searchVector(_,_,X,0,X,d,_).

searchVector(CurrRow, CurrCol, DeltaRow, DeltaCol, It, d, Board):-
	It1 is It + 1,
	It1 =< abs(DeltaRow),
	NewCurrRow = CurrRow + 1,
	getMatrixElemAt(NewCurrRow, CurrCol, Board, Elem),
	Elem =:= 0,
	searchVector(NewCurrRow, CurrCol, DeltaRow, DeltaCol, It1, d, Board).

searchVector(_,_,X1,0,X,u,_):-
	X =:= abs(X1).

searchVector(CurrRow, CurrCol, DeltaRow, DeltaCol, It, u, Board):-
	It1 is It + 1,
	It1 =< abs(DeltaRow),
	NewCurrRow = CurrRow - 1,
	getMatrixElemAt(NewCurrRow, CurrCol, Board, Elem),
	Elem =:= 0,
	searchVector(NewCurrRow, CurrCol, DeltaRow, DeltaCol, It1, u, Board).


validInput(CurrRow,CurrCol, DestRow, DestCol, Board):-
	calculateLevel(CurrRow, CurrCol, CurrLevel),
	calculateLevel(DestRow, DestCol, DestLevel),
	CurrLevel > DestLevel,
	DeltaRow is DestRow - CurrRow,
	DeltaCol is DestCol - CurrCol,
	validMove(DeltaRow, DeltaCol, VecDirection),
	searchVector(CurrRow, CurrCol, DeltaRow, DeltaCol, 0, VecDirection, Board),
	write('valid').

validInput(_,_,_,_,_):-write('Not a valid move!').


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