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
	

searchVector(_,_,X,X,Y,ul,_):-
	Y is abs(X).
	
searchVector(CurrX, CurrY, DeltaX, DeltaY, It, ul, Board):-
	It1 is It + 1,
	It1 =< DeltaX,
	It1 =< DeltaY,
	NewCurrX = CurrX - 1,
	NewCurrY = CurrY - 1,
	getMatrixElemAt(NewCurrX, NewCurrY, Board, Elem),
	Elem =:= 0,
	searchVector(NewCurrX, NewCurrY, DeltaX, DeltaY, It1, ul, Board).

searchVector(_,_,X,Y,Y,dl,_):-
	Y is abs(X).
	
searchVector(CurrX, CurrY, DeltaX, DeltaY, It, dl, Board):-
	It1 is It + 1,
	It1 =< DeltaX,
	It1 =< DeltaY,
	NewCurrX = CurrX - 1,
	NewCurrY = CurrY + 1,
	getMatrixElemAt(NewCurrX, NewCurrY, Board, Elem),
	Elem =:= 0,
	searchVector(NewCurrX, NewCurrY, DeltaX, DeltaY, It1, dl, Board).

searchVector(_,_,Y,X,Y,ur,_):-
	Y is abs(X).
	
searchVector(CurrX, CurrY, DeltaX, DeltaY, It, ur, Board):-
	It1 is It + 1,
	It1 =< DeltaX,
	It1 =< DeltaY,
	NewCurrX = CurrX + 1,
	NewCurrY = CurrY - 1,
	getMatrixElemAt(NewCurrX, NewCurrY, Board, Elem),
	Elem =:= 0,
	searchVector(NewCurrX, NewCurrY, DeltaX, DeltaY, It1, ur, Board).

searchVector(_,_,Y,_,Y,r,_).
	
searchVector(CurrX, CurrY, DeltaX, DeltaY, It,  r, Board):-
	It1 is It + 1,
	It1 =< DeltaX,
	NewCurrX = CurrX + 1,
	getMatrixElemAt(NewCurrX, NewCurrY, Board, Elem),
	Elem =:= 0,
	searchVector(NewCurrX, NewCurrY, DeltaX, DeltaY, It1, r, Board).

searchVector(_,_,_,Y,Y,d,_).
	
searchVector(CurrX, CurrY, DeltaX, DeltaY, It, d, Board):-
	It1 is It + 1,
	It1 =< DeltaY,
	NewCurrY = CurrY + 1,
	getMatrixElemAt(NewCurrX, NewCurrY, Board, Elem),
	Elem =:= 0,
	searchVector(NewCurrX, NewCurrY, DeltaX, DeltaY, It1, d, Board).

searchVector(_,_,X,_,Y,l,_):-
	Y is abs(X).
	
searchVector(CurrX, CurrY, DeltaX, DeltaY, l, Board):-
	It1 is It + 1,
	It1 =< DeltaX,
	NewCurrX = CurrX - 1,
	getMatrixElemAt(NewCurrX, NewCurrY, Board, Elem),
	Elem =:= 0,
	searchVector(NewCurrX, NewCurrY, DeltaX, DeltaY, It1, l, Board).

searchVector(_,_,_,X,Y,u,_):-
	Y is abs(X).
	
searchVector(CurrX, CurrY, DeltaX, DeltaY, u, Board):-
	It1 is It + 1,
	It1 =< DeltaY,
	NewCurrY = CurrY - 1,
	getMatrixElemAt(NewCurrX, NewCurrY, Board, Elem),
	Elem =:= 0,
	searchVector(NewCurrX, NewCurrY, DeltaX, DeltaY, It1, l, Board).
	


validInput(CurrX,CurrY, DestX, DestY, Board):-
	calculateLevel(CurrX, CurrY, CurrLevel),
	calculateLevel(DestX, DestY, DestLevel),
	CurrLevel > DestLevel,
	DeltaX is DestX - CurrX,
	DeltaY is DestY - CurrY,
	validMove(DeltaX, DeltaY, VecDirection),
	searchVector(CurrX, CurrY, DeltaX, DeltaY, 1, VecDirection, Board),
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