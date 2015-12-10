:-use_module(library(clpfd)).
:-use_module(library(lists)).


/*[[l1,a1,t1,2005,alt1,larg1],.....]
Apresentar:
[[l1,l2],[l3,l4],[l5,l6,l7]]
Computar:
[[25,25],[20,20]]


validrow([L,A,T,D,Al,La],P,SumLarg):-
	La+SumLarg #<=LarguraPrat.



validBookshelf([],_,_,_).
validBookshelf(_,[],_,_).

validBookshelf([Livro|Tail], [P|T1],[SumLarg|T2]}):-
validrow(Livro,P,SumLarg);
validBookshelf(Livro,T1,T2).
*/


vl([],_).
vl([Livro|T],R):-
	verificalargura(T,R1),
	element(6, Livro, LarguraLivro),
	sum(LarguraLivro,R1,R).

verificalargura([Livro|T],Lmax):-
	vl([Livro|T],R),
	R #=< Lmax.


verificaaltura([],_).
verificaaltura([Livro|T], Amax):-
	verificaaltura(T, Amax),
	element(5, Livro, AlturaLivro),
	AlturaLivro #=< Amax.


getprateleira([[]|Resto],[],Resto).
getprateleira([Livro|T],[Livro|T2],Resto):-
	getprateleira(T,T2,Resto).

verificaprateleira([],_,_).
verificaprateleira(L, Lmax, Amax):-
	getprateleira(L,P,T),
	verificaprateleira(T,Lmax,Amax).

verificaLivro([],[]).
verificaLivro([[A,B,C,D,E,F],[],[A1,B1,C1,D1,E1,F1]|T],[[A,B,C,D,E,F],[A1,B1,C1,D1,E1,F1]|T2]):-
	verificaLivro([[A1,B1,C1,D1,E1,F1]|T],T2).
verificaLivro([[A,B,C,D,E,F]|T],[[A,B,C,D,E,F]|T2]):-
	verificaLivro(T,T2).

verificaLivro(_,[]).


livros(Livros, NrPrateleiras, LarguraPrat, AlturaPrat, Prateleiras):-
LarguraPrat#>0,
AlturaPrat#>0,
NrPrateleiras#>0,permutation(Livros,NewLivros),
verificaLivro(Prateleiras,NewLivros),

append(Prateleiras,L).

