
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
	setMatrixElemAtWith(PieceRow, PieceCol, CheckPiece, Board, Board1).
	
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
	setMatrixElemAtWith(PieceRow, PieceCol, CheckPiece, Board, Board1).
	
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
	setMatrixElemAtWith(PieceRow, PieceCol, CheckPiece, Board, Board1).
	
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
	setMatrixElemAtWith(PieceRow, PieceCol, CheckPiece, Board, Board1).
	
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
	setMatrixElemAtWith(PieceRow, PieceCol, CheckPiece, Board, Board1).
	
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
	setMatrixElemAtWith(PieceRow, PieceCol, CheckPiece, Board, Board1).
	
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
	setMatrixElemAtWith(PieceRow, PieceCol, CheckPiece, Board, Board1).
	
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
	setMatrixElemAtWith(PieceRow, PieceCol, CheckPiece, Board, Board1).
	
checkCaptureDR2(_, _, _, _,_):-
	fail.
