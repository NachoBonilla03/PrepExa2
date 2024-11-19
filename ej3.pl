
gen_filtered(Gen, Filter, Xs) :-
    findall(X, (call(Gen, X), call(Filter, X)), Xs).

gen_filtered(Gen, Xs) :-
    findall(X, call(Gen, X), Xs).

gen(X) :- between(1, 10, X).
is_even(X) :- X mod 2 =:= 0.