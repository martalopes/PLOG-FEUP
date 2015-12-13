:-use_module(library(clpfd)).
:-use_module(library(lists)).
:-use_module(library(random)).

%id, nome, autor, tema, 
book(1, 'Memorial do Covento', 		1, 'Romance', 	1995, 3, 15).
book(2, 'Lusiadas', 				2, 'Classic', 	1995, 3, 15).
book(3, 'Lol', 						1, 'Romance', 	1995, 2, 15).
%book(3, 'Maias', 					'Eca', 		'Classic', 	1995, 3, 15).
book(4, 'A Viagem do Elefante', 	1, 'Romance', 	1995, 2, 15).


listBooks(List, MaxHeight) :-
	findall([Id, Author,BookW, BookH],
			book(Id, _, Author, _, _, BookW, BookH),
			ListTemp),
	checkBookHeight(ListTemp, ListTemp2, MaxHeight),
	addShelfSpace(ListTemp2, List).

getIdAuthor([], L, L):- write(L).
getIdAuthor([LH|LT], PrevResList, ResList):-
	nth0(0, LH, Bk),
	nth0(0, Bk, ID),
	nth0(1, Bk, Author),
	Book = [[ID, Author]],
	append(PrevResList, Book, ResList2),
	getIdAuthor(LT, ResList2, ResList).

checkBookHeight([],[],_).
checkBookHeight([Book|T], BookResult, MaxHeight):-
	nth0(3, Book, BookHeight),
	BookHeight > MaxHeight,
	write('Um livro não foi adicionado'), %EDITAR PARA FICAR BONITO COM NOME E ASSIM NÉ
	checkBookHeight(T,  BookResult, MaxHeight).


checkBookHeight([Book|T], [BResH|BResT],MaxHeight):-
	BResH = Book,
	checkBookHeight(T, BResT, MaxHeight).




getSizeOfBook(SizeOfBook, [_,_,SizeOfBook,_]).

setBookSpaces(Spaces, SizeOfBook):-
	length(Spaces, SizeOfBook),
	startSetEquals(Spaces).

setEquals(_, []).
setEquals(Value, [LH | LT]) :-
	Value #= LH,
	setEquals(Value, LT).

startSetEquals([LH |LT]) :-
	setEquals(LH, LT).




addShelfSpace([], []).
addShelfSpace([LH |LT], [ListH | ListT]) :-
	getSizeOfBook(SizeOfBook, LH),
	setBookSpaces(Spaces, SizeOfBook),
	ListH = [LH, Spaces],
	addShelfSpace(LT, ListT).

getShelvesSpaces([],[]).
getShelvesSpaces([[_, ShelfH] | BooksT], [ShelfH |ShelfT]) :-
	getShelvesSpaces(BooksT, ShelfT).

livros(BooksRes, NrShelves, MaxWidthShelf, MaxHeight):-
	listBooks(Books, MaxHeight),
	length(Books, Size),
	length(BooksRes, Size),


	getShelvesSpaces(Books, ShelveSpaces),
	flatten(ShelveSpaces, ShelveSpacesFlattened),
	domain(ShelveSpacesFlattened, 1, NrShelves),	
	initializeShelves(ShelveSpacesFlattened, NrShelves, MaxWidthShelf, 0),

	random_permutation(BooksRes, Books),
	costAuthor(BooksRes,Size,0,CostRes),	

	
	nl,write('Custo:'), write(CostRes),
flatten(BooksRes, BooksResF),
	labeling([minimize(CostRes)],BooksResF).


/*flatten(Res, List), write(Res),
domain(List, 1, N),


all_distinct(List),

labeling([],List),
write(Res)*/


flatten([],[]).
flatten([LH|LT], Flattened) :-
	is_list(LH),
	flatten(LH, FlattenedTemp),
	append(FlattenedTemp, LT2, Flattened),
	flatten(LT, LT2).
	
flatten([LH | LT], [LH | FlattenedT]) :-
	\+is_list(LH),
	flatten(LT, FlattenedT).


initializeShelves(SSpaces,Max, _, Max):-
	labeling([], SSpaces).
initializeShelves(SSpaces, NrShelves, MaxWidthShelf, CurrShelf):-
	NextShelf is CurrShelf + 1,
	count(NextShelf, SSpaces, #=<, MaxWidthShelf), 
	initializeShelves(SSpaces, NrShelves, MaxWidthShelf, NextShelf). 




costAuthor(_,0,Cost,CostRes):-
	CostRes #= Cost.

costAuthor([BH|BT], X,Cost, CostRes):-

	nth0(0,BH, H1),
	nth0(1,H1,AuthorHead),
	nth0(0,BT,Head),
	nth0(0, Head, HeadTemp),
	nth0(1,HeadTemp,AuthorTail),

	AuthorHead \= AuthorTail,
	Cost1 #= Cost + 1,
	X1 is X-1,
	costAuthor(BT, X1,Cost1, CostRes).

costAuthor([_|BT], X,Cost, CostRes):-
	X1 is X-1,
	costAuthor(BT, X1,Cost, CostRes).







