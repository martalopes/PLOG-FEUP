:-use_module(library(clpfd)).
:-use_module(library(lists)).


book(1, 'Ensaio Sobre a Cegueira', 						1, 'Romance', 	1995, 16).
book(2, 'Lusiadas', 									2, 'Classic', 	1572, 13).
book(3, 'Os Maias', 									3, 'Classic', 	1888, 14).
book(4, 'A Viagem do Elefante', 						1, 'Romance', 	2008, 15).
book(5, 'O Evangelho segundo Jesus Cristo', 			1, 'Romance', 	1991, 15).
book(6, 'A Caverna', 									1, 'Romance', 	2000, 15).

author(1, 'Saramago').
author(2, 'Camoes').
author(3, 'Eca de Queiros').


listBooks(List) :-
	findall(Id,
			book(Id, _, _, _, _, _),
			List).

getHeightList([], _, _, _).
getHeightList([H | Rest], HeightList, I, IMax):-
	book(I, _, _, _, _, BookHeight),
	I1 is I + 1,
	element(H, HeightList, BookHeight),
	getHeightList(Rest, HeightList, I1, IMax).

sortByHeight([H1, H2 | HRest], [A1, A2 | ARest]):-
	(A1 #= A2 #=> H1 #=< H2),
	sortByHeight([H2 | HRest], [A2 | ARest]).
sortByHeight([_], [_]).

checkHeight([], _).
checkHeight([H|T], MaxHeight):-	
	H #=< MaxHeight,
	checkHeight(T, MaxHeight).

getAuthorList([], _, _, _).
getAuthorList([A | Rest], AuthorList, I, IMax):-
	book(I, _, Author, _, _, _),
	I1 is I + 1,
	element(A, AuthorList, Author),
	getAuthorList(Rest, AuthorList, I1, IMax).

sortByAuthor([A1, A2 | ARest]):-
	A1 #=< A2,
	sortByAuthor([A2|ARest]).
sortByAuthor([_]).


getYearList([], _, _, _).
getYearList([Y | Rest], YearList, I, IMax):-
	book(I, _, _, _, Year, _),
	I1 is I + 1,
	element(Y, YearList, Year),
	getYearList(Rest, YearList, I1, IMax).

sortByYear([Y1, Y2 | YRest], [H1, H2 | HRest], [A1,A2 | ARest]):-
	((H1 #= H2 #/\ A1 #= A2) #=> Y1 #=< Y2),
	sortByYear([Y2|YRest], [H2 | HRest],[A2 | ARest]).
sortByYear([_], [_], [_]).



livros(BooksRes, NrShelves, WidthShelf, MaxHeight):-
	AllShelfsSize is NrShelves*WidthShelf,
	listBooks(Books),
	length(Books, Size),
	AllShelfsSize >= Size,
	length(BooksRes, Size),
	all_distinct(BooksRes),
	domain(BooksRes, 1, Size),
	length(HeightList, Size),
	length(AuthorList, Size),
	length(YearList, Size),
	getHeightList(BooksRes, HeightList, 1, Size),
	getAuthorList(BooksRes, AuthorList, 1, Size),
	getYearList(BooksRes, YearList, 1, Size),
	sortByAuthor(AuthorList),
	sortByHeight(HeightList, AuthorList),
	checkHeight(HeightList, MaxHeight),
	sortByYear(YearList, HeightList, AuthorList),
	reset_timer,
	labeling([], BooksRes),
	printShelfs(BooksRes, 0, Size, Res),
	printResult(Res, 0, WidthShelf),
	print_time,
    fd_statistics,!.

printShelfs(_, C, C, []).
printShelfs(Books, C, Size, [LH | LT]):-
	C1 is C + 1,
	nth1(Index, Books, C1),
	book(Index, Name, Author, _,YearPub, Height),
	author(Author, AuthorName),
	LH = [Name, ' escrito por': AuthorName, ' em': YearPub, ' com altura de': Height],
	printShelfs(Books, C1, Size, LT).

printResult([],_,_):-
	write('-------------------------------------------------------------\n').
printResult([LH | LT], Counter, Max) :-
	Mod is Counter mod Max,
	Mod == 0,
	write('-------------------------------------------------------------\n'),
	NShelf is Counter div Max + 1,
	C is Counter + 1,
	write('Shelf '),
	write(NShelf), nl,
	write(LH), nl,
	printResult(LT, C, Max).

printResult([LH | LT], Counter, Max) :-
	C is Counter + 1,
	write(LH), nl,
	printResult(LT, C, Max).

reset_timer :- statistics(walltime,_).  
print_time :-
        statistics(walltime,[_,T]),
        TS is ((T//10)*10)/1000,
        nl, write('Time: '), write(TS), write('s'), nl, nl.
