sub_lists(_,[[]]).
sub_lists(X1,Salida):-
    sort(X1,X2),
    [C|R]=X2,
    combination(C,R,S),
    sub_lists(R,X),
    append([[C]],S,L),
    append(L,X,Salida)
.
combination(_,[],[]).
combination(C,[X|L], Y):-
    combination(C,L,Y1), 
    append([[C,X]],Y1,Y),!
.