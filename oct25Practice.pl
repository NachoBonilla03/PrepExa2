/*
1) Escriba frequency(E, L, Freq) tal que Freq es la cantidad de veces que E es miembro de la lista L.
*/

frequency(_, [], 0). 
frequency(E, [E|L], Freq):-
    frequency(E, L, Freq1),
    Freq is Freq1 + 1, !. 
frequency(E, [_|L], Freq):-frequency(E, L, Freq).

/*
2) Escriba minMax(A, Min, Max) que dada una lista de números A, encuentre el mínimo Min y el máximo Max de A (en una sola pasada sobre A).
*/
minMax([], 1, 0). 
minMax([E|A], Min, Max):-
    minMax(A, Min1, Max1),     
    Min is min(E, Min1),      
    Max is max(E, Max1), !. 

/*
3) Escriba allpairs(A, B, P) talque P es la lista de todos los árboles a+b tales que
a está en A y b en B. No use aún metapredicados como maplist o findall o similares.
Ejemplo
allpairs([1, 2], [a, b, c], P)
P = [1+a, 1+b, 1+c, 2+a, 2+b, 2+c]
*/

allpairs([], _, []). 
allpairs([E|A], B, P):- 
    paired(E, B, P1), 
    allpairs(A, B, P2),
    append(P1, P2, P).

paired(_, [], []). 
paired(E, [X|B], [E+X|P]):- 
    paired(E,B,P).  





/*
4) Dada una lista L y un número N, escriba sublist(L, N, S) 
donde S es sublista contigua (y que respeta el orden en L) de L de largo N. 
Solo puede usar append, length y backtracking.
Ejemplo (note que no está una como [a, d] pues no es contigua, 
ni tampoco [b, a] porque no respeta el orden)
sublist([a, b, d, e], 2, S).
S = [a, b] ;
S = [b, d] ;
S = [d, e] ;
false
*/
sublist([], _, _).
sublist([X|L], N,S):-
    subElem(X,L,N,S). 
sublist([_|L],N,S):-
    sublist(L,N,S). 

subElem(_,_,0,[]). 
subElem(X,[B|L],N,[X|Subl]):-
    N>0, 
    N1 is N-1,
    subElem(B,L,N1,Subl).


