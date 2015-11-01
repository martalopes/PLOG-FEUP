level(1, purple).
level(2, blue).
level(3, green).
level(4, yellow).
level(5, orange).
level(6, red).

validMove(X,X, dr).   %% down right
validMove(-X,-X, ul). %% up left
validMove(-X,X, dl).  %% down left
validMove(X,-X, ur).  %% up right
validMove(X,0, r).   %% right
validMove(0,X, d).   %% down
validMove(-X,0, l).  %% left
validMove(0,-X, u).  %% up


calculateLevel(X,Y, Level):-
	DeltaX is 7-X,
	DeltaY is 7-Y,
	Level is max(DeltaX, DeltaY),
	level(Level, Color).

searchVector(_,_,X,X,X,dr,_).

searchVector(CurrX, CurrY, DeltaX, DeltaY, It, dr, Board):-
	It1 is It + 1,
	It1 =< DeltaX,
	It1 =< DeltaY,
	NewCurrX = CurrX + 1,
	NewCurrY = CurrY + 1,
	getMatrixElemAt(NewCurrX, NewCurrY, Board, Elem),
	Elem =:= 0,
	searchVector(NewCurrX, NewCurrY, DeltaX, DeltaY, It1, dr, Board).
	


%searchVector(CurrX, CurrY, DeltaX, DeltaY, It, ul, Board):-

%searchVector(CurrX, CurrY, DeltaX, DeltaY, It, dl, Board):-

%searchVector(CurrX, CurrY, DeltaX, DeltaY, It, ur, Board):-

%searchVector(CurrX, CurrY, DeltaX, DeltaY, It,  r, Board):--

%searchVector(CurrX, CurrY, DeltaX, DeltaY, It, d, Board):-

%searchVector(CurrX, CurrY, DeltaX, DeltaY, l, Board):-

%searchVector(CurrX, CurrY, DeltaX, DeltaY, u, Board):-
	


validInput(CurrX,CurrY, DestX, DestY, Board):-
	calculateLevel(CurrX, CurrY, CurrLevel),
	calculateLevel(DestX, DestY, DestLevel),
	CurrLevel > DestLevel,
	DeltaX is DestX - CurrX,
	DeltaY is DestY - CurrY,
	validMove(DeltaX, DeltaY, VecDirection),
	searchVector(CurrX, CurrY, DeltaX, DeltaY, 0, VecDirection, Board),
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