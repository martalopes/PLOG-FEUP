%%%%%%%%% CHECK MOVEMENT %%%%%%%%%%%

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
	Elem =< 0,
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
	Elem =< 0,
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
	Elem =< 0,
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
	Elem =< 0,
	searchVector(NewCurrRow, NewCurrCol, DeltaRow, DeltaCol, It1, ur, Board).
	
searchVector(_,_,0,X,X,r,_).

searchVector(CurrRow, CurrCol, DeltaRow, DeltaCol, It,  r, Board):-
	It1 is It + 1,
	It1 =< abs(DeltaCol),
	NewCurrCol = CurrCol + 1,
	getMatrixElemAt(CurrRow, NewCurrCol, Board, Elem),
	Elem =< 0,
	searchVector(CurrRow, NewCurrCol, DeltaRow, DeltaCol, It1, r, Board).
	
searchVector(_,_,0,X1,X,l,_):-
	X =:= abs(X1).

searchVector(CurrRow, CurrCol, DeltaRow, DeltaCol, It, l, Board):-
	It1 is It + 1,
	It1 =< abs(DeltaCol),
	NewCurrCol = CurrCol - 1,
	getMatrixElemAt(CurrRow, NewCurrCol, Board, Elem),
	Elem =< 0,
	searchVector(CurrRow, NewCurrCol, DeltaRow, DeltaCol, It1, l, Board).

searchVector(_,_,X,0,X,d,_).

searchVector(CurrRow, CurrCol, DeltaRow, DeltaCol, It, d, Board):-
	It1 is It + 1,
	It1 =< abs(DeltaRow),
	NewCurrRow = CurrRow + 1,
	getMatrixElemAt(NewCurrRow, CurrCol, Board, Elem),
	Elem =< 0,
	searchVector(NewCurrRow, CurrCol, DeltaRow, DeltaCol, It1, d, Board).

searchVector(_,_,X1,0,X,u,_):-
	X =:= abs(X1).

searchVector(CurrRow, CurrCol, DeltaRow, DeltaCol, It, u, Board):-
	It1 is It + 1,
	It1 =< abs(DeltaRow),
	NewCurrRow = CurrRow - 1,
	getMatrixElemAt(NewCurrRow, CurrCol, Board, Elem),
	Elem =< 0,
	searchVector(NewCurrRow, CurrCol, DeltaRow, DeltaCol, It1, u, Board).

validInput(CurrRow,CurrCol, DestRow, DestCol, Board):-
	((DestRow =:= 6, DestCol =:= 6) -> fail; 
	calculateLevel(CurrRow, CurrCol, CurrLevel),
	calculateLevel(DestRow, DestCol, DestLevel),
	CurrLevel > DestLevel,
	DeltaRow is DestRow - CurrRow,
	DeltaCol is DestCol - CurrCol,
	validMove(DeltaRow, DeltaCol, VecDirection),
	searchVector(CurrRow, CurrCol, DeltaRow, DeltaCol, 0, VecDirection, Board),
	write('ok'),nl,nl).



validInput(_,_,_,_,_):-
	write('Not a valid move! Try again.'), nl,nl,
	fail.


noMovement(CurrRow, CurrCol, DestRow, DestCol, Board):-
	calculateLevel(CurrRow, CurrCol, CurrLevel),
	calculateLevel(DestRow, DestCol, DestLevel),
	CurrLevel > DestLevel,
	DeltaRow is DestRow - CurrRow,
	DeltaCol is DestCol - CurrCol,
	validMove(DeltaRow, DeltaCol, VecDirection),
	searchVector(CurrRow, CurrCol, DeltaRow, DeltaCol, 0, VecDirection, Board), !,fail. 

noMovement(_,_,_,_,_):- true.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%% CHECK CAPTURE %%%%%%%%%%%%%%%%%%


checkCapture(PieceRow, PieceCol, Piece, Board, FinalBoard):-
	checkCaptureU(PieceRow, PieceCol, Piece, Board, Board1),
	checkCaptureD(PieceRow, PieceCol, Piece, Board1, Board2),
	checkCaptureL(PieceRow, PieceCol, Piece, Board2, Board3),
	checkCaptureR(PieceRow, PieceCol, Piece, Board3, Board4),
	checkCaptureUL(PieceRow, PieceCol, Piece, Board4, Board5),
	checkCaptureUR(PieceRow, PieceCol, Piece, Board5, Board6),
	checkCaptureDL(PieceRow, PieceCol, Piece, Board6, Board7),
	checkCaptureDR(PieceRow, PieceCol, Piece, Board7, FinalBoard).


checkCaptureU(PieceRow, PieceCol, Piece, Board, Board1):-
	CheckRow is PieceRow - 1,
	CheckCol is PieceCol, 
	getMatrixElemAt(CheckRow, CheckCol, Board, CheckPiece),
	reverseColor(Piece, CheckPiece), 
	checkCaptureU2(CheckRow, CheckCol, CheckPiece, Board, Board1).

checkCaptureU(_, _, _, Board, Board1):- %%%ALTERADO!!!!!!!!!pcausa de singletons
	getMatrixElemAt(6,6, Board, GetPiece),
	setMatrixElemAtWith(6, 6, GetPiece, Board, Board1).
	

checkCaptureU(_, _, _, _,_).

checkCaptureU2(PieceRow, PieceCol, Piece, Board, Board1):-
	CheckRow is PieceRow - 1,
	CheckCol is PieceCol, 
	getMatrixElemAt(CheckRow, CheckCol, Board, CheckPiece), 
	reverseColor(Piece, CheckPiece),  
	setMatrixElemAtWith(PieceRow, PieceCol, CheckPiece, Board, TempBoard),
	checkCenter(PieceRow, PieceCol, CheckPiece, TempBoard, Board1).
	
checkCaptureU2(_, _, _, _,_):-
	fail.


checkCaptureD(PieceRow, PieceCol, Piece, Board, Board1):-
	CheckRow is PieceRow + 1,
	CheckCol is PieceCol, 
	getMatrixElemAt(CheckRow, CheckCol, Board, CheckPiece),
	reverseColor(Piece, CheckPiece), 
	checkCaptureD2(CheckRow, CheckCol, CheckPiece, Board, Board1).

checkCaptureD(_, _, _, Board, Board1):- %%%ALTERADO!!!!!!!!!pcausa de singletons
	getMatrixElemAt(6,6, Board, GetPiece),
	setMatrixElemAtWith(6, 6, GetPiece, Board, Board1).
	

checkCaptureD(_, _, _, _,_).

checkCaptureD2(PieceRow, PieceCol, Piece, Board, Board1):-
	CheckRow is PieceRow + 1,
	CheckCol is PieceCol, 
	getMatrixElemAt(CheckRow, CheckCol, Board, CheckPiece), 
	reverseColor(Piece, CheckPiece),  
	setMatrixElemAtWith(PieceRow, PieceCol, CheckPiece, Board, TempBoard),
	checkCenter(PieceRow, PieceCol, CheckPiece, TempBoard, Board1).
	
checkCaptureD2(_, _, _, _,_):-
	fail.


checkCaptureL(PieceRow, PieceCol, Piece, Board, Board1):-
	CheckRow is PieceRow,
	CheckCol is PieceCol-1, 
	getMatrixElemAt(CheckRow, CheckCol, Board, CheckPiece),
	reverseColor(Piece, CheckPiece), 
	checkCaptureL2(CheckRow, CheckCol, CheckPiece, Board, Board1).

checkCaptureL(_, _, _, Board, Board1):- %%%ALTERADO!!!!!!!!!pcausa de singletons
	getMatrixElemAt(6,6, Board, GetPiece),
	setMatrixElemAtWith(6, 6, GetPiece, Board, Board1).
	

checkCaptureL(_, _, _, _,_).

checkCaptureL2(PieceRow, PieceCol, Piece, Board, Board1):-
	CheckRow is PieceRow,
	CheckCol is PieceCol - 1, 
	getMatrixElemAt(CheckRow, CheckCol, Board, CheckPiece), 
	reverseColor(Piece, CheckPiece),  
	setMatrixElemAtWith(PieceRow, PieceCol, CheckPiece, Board, TempBoard),
	checkCenter(PieceRow, PieceCol, CheckPiece, TempBoard, Board1).
	
checkCaptureL2(_, _, _, _,_):-
	fail.


checkCaptureR(PieceRow, PieceCol, Piece, Board, Board1):-
	CheckRow is PieceRow,
	CheckCol is PieceCol+1, 
	getMatrixElemAt(CheckRow, CheckCol, Board, CheckPiece),
	reverseColor(Piece, CheckPiece), 
	checkCaptureR2(CheckRow, CheckCol, CheckPiece, Board, Board1).

checkCaptureR(_, _, _, Board, Board1):- %%%ALTERADO!!!!!!!!!pcausa de singletons
	getMatrixElemAt(6,6, Board, GetPiece),
	setMatrixElemAtWith(6, 6, GetPiece, Board, Board1).
	

checkCaptureR(_, _, _, _,_).

checkCaptureR2(PieceRow, PieceCol, Piece, Board, Board1):-
	CheckRow is PieceRow,
	CheckCol is PieceCol + 1, 
	getMatrixElemAt(CheckRow, CheckCol, Board, CheckPiece), 
	reverseColor(Piece, CheckPiece),  
	setMatrixElemAtWith(PieceRow, PieceCol, CheckPiece, Board, TempBoard),
	checkCenter(PieceRow, PieceCol, CheckPiece, TempBoard, Board1).
	
checkCaptureR2(_, _, _, _,_):-
	fail.


checkCaptureUL(PieceRow, PieceCol, Piece, Board, Board1):-
	CheckRow is PieceRow - 1,
	CheckCol is PieceCol - 1, 
	getMatrixElemAt(CheckRow, CheckCol, Board, CheckPiece),
	reverseColor(Piece, CheckPiece), 
	checkCaptureUL2(CheckRow, CheckCol, CheckPiece, Board, Board1).

checkCaptureUL(_, _, _, Board, Board1):- %%%ALTERADO!!!!!!!!!pcausa de singletons
	getMatrixElemAt(6,6, Board, GetPiece),
	setMatrixElemAtWith(6, 6, GetPiece, Board, Board1).
	

checkCaptureUL(_, _, _, _,_).

checkCaptureUL2(PieceRow, PieceCol, Piece, Board, Board1):-
	CheckRow is PieceRow - 1,
	CheckCol is PieceCol - 1, 
	getMatrixElemAt(CheckRow, CheckCol, Board, CheckPiece), 
	reverseColor(Piece, CheckPiece),  
	setMatrixElemAtWith(PieceRow, PieceCol, CheckPiece, Board, TempBoard),
	checkCenter(PieceRow, PieceCol, CheckPiece, TempBoard, Board1).
	
checkCaptureUL2(_, _, _, _,_):-
	fail.


checkCaptureUR(PieceRow, PieceCol, Piece, Board, Board1):-
	CheckRow is PieceRow - 1,
	CheckCol is PieceCol + 1, 
	getMatrixElemAt(CheckRow, CheckCol, Board, CheckPiece),
	reverseColor(Piece, CheckPiece), 
	checkCaptureUR2(CheckRow, CheckCol, CheckPiece, Board, Board1).

checkCaptureUR(_, _, _, Board, Board1):- %%%ALTERADO!!!!!!!!!pcausa de singletons
	getMatrixElemAt(6,6, Board, GetPiece),
	setMatrixElemAtWith(6, 6, GetPiece, Board, Board1).
	

checkCaptureUR(_, _, _, _,_).

checkCaptureUR2(PieceRow, PieceCol, Piece, Board, Board1):-
	CheckRow is PieceRow - 1,
	CheckCol is PieceCol + 1, 
	getMatrixElemAt(CheckRow, CheckCol, Board, CheckPiece), 
	reverseColor(Piece, CheckPiece),  
	setMatrixElemAtWith(PieceRow, PieceCol, CheckPiece, Board, TempBoard),
	checkCenter(PieceRow, PieceCol, CheckPiece, TempBoard, Board1).
	
checkCaptureUR2(_, _, _, _,_):-
	fail.


checkCaptureDL(PieceRow, PieceCol, Piece, Board, Board1):-
	CheckRow is PieceRow + 1,
	CheckCol is PieceCol - 1, 
	getMatrixElemAt(CheckRow, CheckCol, Board, CheckPiece),
	reverseColor(Piece, CheckPiece), 
	checkCaptureDL2(CheckRow, CheckCol, CheckPiece, Board, Board1).

checkCaptureDL(_, _, _, Board, Board1):- %%%ALTERADO!!!!!!!!!pcausa de singletons
	getMatrixElemAt(6,6, Board, GetPiece),
	setMatrixElemAtWith(6, 6, GetPiece, Board, Board1).
	

checkCaptureDL(_, _, _, _,_).
checkCaptureDL2(PieceRow, PieceCol, Piece, Board, Board1):-
	CheckRow is PieceRow + 1,
	CheckCol is PieceCol - 1, 
	getMatrixElemAt(CheckRow, CheckCol, Board, CheckPiece), 
	reverseColor(Piece, CheckPiece),  
	setMatrixElemAtWith(PieceRow, PieceCol, CheckPiece, Board, TempBoard),
	checkCenter(PieceRow, PieceCol, CheckPiece, TempBoard, Board1).
	
checkCaptureDL2(_, _, _, _,_):-
	fail.


checkCaptureDR(PieceRow, PieceCol, Piece, Board, Board1):-
	CheckRow is PieceRow + 1,
	CheckCol is PieceCol + 1, 
	getMatrixElemAt(CheckRow, CheckCol, Board, CheckPiece),
	reverseColor(Piece, CheckPiece), 
	checkCaptureDR2(CheckRow, CheckCol, CheckPiece, Board, Board1).

checkCaptureDR(_, _, _, Board, Board1):- %%%ALTERADO!!!!!!!!!pcausa de singletons
	getMatrixElemAt(6,6, Board, GetPiece),
	setMatrixElemAtWith(6, 6, GetPiece, Board, Board1).
	

checkCaptureDR(_, _, _, _,_).

checkCaptureDR2(PieceRow, PieceCol, Piece, Board, Board1):-
	CheckRow is PieceRow + 1,
	CheckCol is PieceCol + 1, 
	getMatrixElemAt(CheckRow, CheckCol, Board, CheckPiece), 
	reverseColor(Piece, CheckPiece),  
	setMatrixElemAtWith(PieceRow, PieceCol, CheckPiece, Board, TempBoard),
	checkCenter(PieceRow, PieceCol, CheckPiece, TempBoard, Board1).
	
checkCaptureDR2(_, _, _, _,_):-
	fail.


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%% CHECK CENTER %%%%%%%%%%%%%%%%%%%


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


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
