:-use_module(library(clpfd)).
:-use_module(library(lists)).

%id, nome, autor, tema, 
book(1, 'Memorial do Covento', 		'Saramago', 'Romance', 	1995, 3, 15).
book(2, 'Lusiadas', 				'Camoes', 	'Classic', 	1995, 3, 15).
book(3, 'Maias', 					'Eca', 		'Classic', 	1995, 3, 15).
book(4, 'A Viagem do Elefante', 	'Saramago', 'Romance', 	1995, 2, 15).


listBooks(List, MaxHeight) :-
	findall([Id, Author,BookW, BookH],
			book(Id, _, Author, _, _, BookW, BookH),
			ListTemp),
	checkBookHeight(ListTemp, ListTemp2, MaxHeight),
	addShelfSpace(ListTemp2, List).

checkBookHeight([],[],_).
checkBookHeight([Book|T], BookResult, MaxHeight):-
	nth0(3, Book, BookHeight),
	BookHeight > MaxHeight,
	write('Um livro não foi adicionado'), %EDITAR PARA FICAR BONITO COM NOME E ASSIM NÉ
	checkBookHeight(T,  BookResult, MaxHeight).


checkBookHeight([Book|T], [BResH|BResT],MaxHeight):-
	nth0(3, Book, BookHeight),
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

livros(Books, NrShelves, MaxWidthShelf, MaxHeight):-
	%length(Books, N),
	listBooks(Books, MaxHeight),

	

	getShelvesSpaces(Books, ShelveSpaces),

	flatten(ShelveSpaces, ShelveSpacesFlattened),

	domain(ShelveSpacesFlattened, 1, NrShelves),
	
	initializeShelves(ShelveSpacesFlattened, NrShelves, MaxWidthShelf, 0),

	labeling([], ShelveSpacesFlattened).


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


initializeShelves(_,Max, _, Max).
initializeShelves(SSpaces, NrShelves, MaxWidthShelf, CurrShelf):-
	NextShelf is CurrShelf + 1,
	count(NextShelf, SSpaces, #=<, MaxWidthShelf), 
	initializeShelves(SSpaces, NrShelves, MaxWidthShelf, NextShelf). 

	

