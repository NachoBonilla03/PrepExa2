map(_,[],[]).
map(Predicado, [P|L],[R|X]):-call(Predicado,P,R),!,map(Predicado,L,X).

isEven(X,Y):-Y is X mod 2.

reduce(_,[],_,0).
reduce(Predicado,[P|L],Acc, Res):-call(Predicado, P,Acc,R1), !, reduce(Predicado,L,Acc, R2), Res is R1+R2. 
sumar(Elemento, Acumulador, NuevoAcumulador) :-
    NuevoAcumulador is Acumulador + Elemento.


filter(_,[],[]).
filter(Predicado,[P|L],[R|X]):-call(Predicado,P), filter(Predicado,L,X), R is P.
filter(Predicado,[_|L],R):-filter(Predicado,L, R).
is_even2(X) :- X mod 2 =:= 0.