:-use_module(library(clpfd)).
:-use_module(library(lists)).

%id, nome, autor, tema, 
book(1, 'Ensaio Sobre a Cegueira', 						'Saramago', 		'Romance', 	1995, 3, 15).
book(2, 'Lusiadas', 									'Camoes', 			'Classic', 	1572, 3, 16).
book(3, 'Os Maias', 									'Eca de Queiros',	'Classic', 	1888, 2, 15).
book(4, 'A Viagem do Elefante', 						'Saramago', 		'Romance', 	2008, 2, 19).
book(5, 'O Evangelho segundo Jesus Cristo', 			'Saramago', 		'Romance', 	1991, 2, 15).
book(6, 'A Caverna', 									'Saramago', 		'Romance', 	2000, 2, 25).


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
	nth0(0, Book, ID),
	book(ID, Name, _, _,_,_,Height),
	nl,
	write('The book '),
	write(Name ), 
	write(' was not added because it has an height of '),
	write(Height),nl,
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


getEmptyShelveSpaces(_, _, [], _).
getEmptyShelveSpaces(ShelveSpacesFlattened, NrShelf, [ShelfH | ShelfT], MaxWidthShelf):-
	NrShelves1 is NrShelf+1,
	getShelfEmpty(ShelveSpacesFlattened, NrShelf, MaxWidthShelf, ShelfH),
	getEmptyShelveSpaces(ShelveSpacesFlattened, NrShelves1, ShelfT, MaxWidthShelf).


getShelfEmpty(ShelveSpacesFlattened, Shelf, MaxWidthShelf, R):-
	count(Shelf, ShelveSpacesFlattened, #=, Res),
	R #= MaxWidthShelf - Res.

removeEmpty(ShelfList, MaxWidthShelf, Res):-
	count(MaxWidthShelf, ShelfList, #=, CounterTemp),
	sum(ShelfList, #=, Total),
	Res #= Total - (CounterTemp * MaxWidthShelf).

getCostShelfUsage(ShelveSpacesFlattened, MaxWidthShelf, NrShelves, ShelfList, Res):-
	length(ShelfList, NrShelves),
	getEmptyShelveSpaces(ShelveSpacesFlattened, 1, ShelfList, MaxWidthShelf),
	removeEmpty(ShelfList, MaxWidthShelf, Res).

livros(ShelveSpaces, NrShelves, MaxWidthShelf, MaxHeight):-
	%length(Books, N),
	listBooks(Books, MaxHeight),

	getShelvesSpaces(Books, ShelveSpaces),

	flatten(ShelveSpaces, ShelveSpacesFlattened),

	getCostShelfUsage(ShelveSpacesFlattened, MaxWidthShelf, NrShelves, EmptySpaces, Cost),

	domain(ShelveSpacesFlattened, 1, NrShelves),
	
	initializeShelves(ShelveSpacesFlattened, NrShelves, MaxWidthShelf, 0),
	!,
	labeling([minimize(Cost),time_out(60000,_)], ShelveSpacesFlattened),
	printBookInfo(Books, 1),nl,
	printShelfInfo(EmptySpaces, 1),nl,
	write('### STATISTICS ###'),nl,
	print_time,
    fd_statistics,nl.


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


getBookShelf([_, [Shelf|_]], Shelf).


printBookInfo([], _).
printBookInfo([Book|Rest], IdCount):-
	Idnew is IdCount+1,
	getBookShelf(Book, Shelf),
	book(IdCount, Title, Author, _, _, Width, _),
	nl,
	write('Book '),
	write(IdCount),nl,
	write(Title),
	write(' by '), 
	write(Author),
	write(' is in shelf '),
	write(Shelf),
	write(' with a witdth of '),
	write(Width),nl,
	printBookInfo(Rest, Idnew).

printShelfInfo([], _).
printShelfInfo([H|T], IdCount):-
	Idnew is IdCount+1,
	nl,
	write('Shelf '),
	write(IdCount),
	write(' has '),
	write(H),
	write(' empty spaces.'), nl,
	printShelfInfo(T, Idnew).


reset_timer :- statistics(walltime,_).  
print_time :-
        statistics(walltime,[_,T]),
        TS is ((T//10)*10)/1000,
        nl, write('Time: '), write(TS), write('s'), nl, nl.