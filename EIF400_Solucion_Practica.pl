%%%%%%%%%%%%%%%%%%%%%%%%%%%%% A %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
/*
0) Sin usar el shell determine si `T1` y `T2` unifican o no. Confirme su respuesta en el shell.

`T1 = foo( [X |[[X+a] ]],g(X))`, y 
`T2 = foo( [g(Z)|[[g(a)+Y]]], g(g(Y)) )`
*/
/*
  Sí unifican con X=g(a), Y=a, Z=a.
*/
/*
A1) Escriba una `DCG` que represente esta gramática de ANTLR:
```java
expression : atomic | addition;
atomic : identifier | number;
addition : expression '+' expression;
identifier : IDENT;
number : NUM;
IDENT: [a-zA-Z]+;
NUM : [0-9]+
WS : [ \t\r\n]+ -> skip
*/
expression( E ) --> atomic( E ); addition( E ).
atomic( I ) --> identifier( I ).
atomic( N ) --> number( N ).
addition( Left + Right ) --> expression( Left ), "+", expression( Right ).
identifier( id(I) ) --> ws, letters( L ), {atom_codes(I, L)}, ws.
number( num(N) ) -->  ws, digits(D), {number_codes(N, D)}, ws.

letters( [C | L] ) --> [C], {code_type(C, alpha)}, moreLetters(L).
moreLetters( [C | L] ) --> [C], {code_type(C, alpha)}, moreLetters(L).
moreLetters( [] ) --> [].

digits( [C | L] ) --> [C], {code_type(C, digit)}, moreDigits(L).
moreDigits( [C | L] ) --> [C], {code_type(C, digit)}, moreDigits(L).
moreDigits( [] ) --> [].

ws --> [C], {code_type(C, space)}, ws.
ws --> [].

test_grammar :-
	atom_codes('  xyz + 123', Codes),
	expression(Ast, Codes, []),
	writeln(Ast), 
	!
.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% B %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
/*
B0) Escriba metapredicados `map/3` y `reduce/4` y `filter/3` en `Prolog`, como si no existieran ya metapredicados como `maplist/3`, `foldl/4` ni `include/3`. Use recursión.
*/

map(_, [], []).
map(F, [X | R],[FX | FR] ) :- call(F, X, FX), map(F, R, FR).

reduce(_, [], A, A).
reduce(F, [E | L], A, Z) :- call(F, A, E, A1), reduce(F, L, A1, Z). 

filter(_, [], []).
filter(F, [E | L], [E | FL] ) :- call(F, E), !, filter(F, L, FL).
filter(F, [_ | L], FL ) :- filter(F, L, FL).

test_map_filter_reduce :-
	map([X, Y] >> (Y is X ** 2), [1, 2, 3], Squares),
	format('*** map --> ~q ***~n', [Squares]),
	%
	reduce([A, E, A1] >> (A1 is A * E), [1, 2, 3], 1, Fact),
	format('*** reduce --> ~q ***~n', [Fact]),
	%
	filter([X] >> (X mod 2 =:= 1),  [1, 2, 3], Odds),
	format('*** filter --> ~q ***~n', [Odds]),
	!
.

/*
B1) Escriba `solve(+N, -X, -Y, -Z)` que retorne los números `X`, `Y`, `Z` tales que `X + Y + Z = N`. No use `CLP`.
*/
solve(N, X, Y, Z) :-
	between(0, N, X),
	NX is N - X,
	between(0, NX, Y),
	Z is NX - Y
.

test_solve :-
	forall(solve(3, X, Y, Z), 
	       format('*** X=~d Y=~d Z=~d ***~n', [X, Y, Z]))
.
/*

B2) Usando 1), escriba `all_solutions_list(+N, ?L)` tal que `L` es la lista de soluciones `[X, Y, Z]` que `solve` retorna. El orden no es relevante.
*/
all_solutions_list(N, L) :- findall([x=X, y=Y, z=Z], solve(N, X, Y, Z), L).
/*

B3) Defina un metapredicado: `gen_filtered(:Gen, :Filter, -X)` que reciba predicados `Gen/1` y `Filter/1`, y retorne las soluciones `X` que `Gen(X)` produce, pero que cumplan con el predicado `Filter(X)`. Si no se pasa el parámetro `Filter`, se retornan todas las soluciones.
*/
gen_filtered(Gen, X) :- call(Gen, X). 
gen_filtered(Gen, Filter, X) :-
     call(Gen, X), 
	 call(Filter, X)	 
.

test_gen :-
    From = 1, To = 50,
    format('*** Numbers between ~d and ~d divisible by 2 and 3 ***~n', [From, To]),
	forall( gen_filtered( between(From, To), [X] >> (X mod 2 =:= 0, X mod 3 =:= 0), X),
			writeln(X))
.
/*
B4) Escriba un predicado `sub_lists(+S, -L)` que reciba una lista `S` y retorne una lista `L` que contiene todas las sub-listas de `S`. Ejemplo: `sub_lists([2, 1, 1], L)` retornaría `L=[[], [1], [2], [1,2]]`. No
deben aparecer repetidos en `L`. Por ejemplo `[1,2]` es lo mismo que `[2,1]`. El orden no es
relevante.
*/
%%% Una Solución Recursiva %%%%%
insert_into_sublist( X, [S | RS], [ [X | S] | IRS ] ) :-  
	insert_into_sublist(X, RS, IRS), !.
insert_into_sublist( _, [], []).

sub_lists_rec(S, L) :- sort(S, SS), rec_sub_lists(SS, L). % O(nlog(n)) + O(2**n) = O(2**n)
rec_sub_lists( [], [ [] ] ).
rec_sub_lists( [X | S], L ) :- 
	rec_sub_lists(S, SL), 
	insert_into_sublist(X, SL, XSL),
	append( SL, XSL, L )
.
%%% Una Solución usando backtracking + assert/retract %%%%
/* 
	Esta usa un predicado generador que genera (muchas repeticiones).
	Se "recuerdan" las soluciones para evitar repeticiones.
	Una vez calculadas se colectan una a una.
*/ 
sub_lists_gen(S, _) :- 
	retractall( sol(_) ),
	gen_sub_lists(S, Sol), sort(Sol, SetSol), % Sería mucho mejor un hash que un sort!
	( \+sol(SetSol)-> assert( sol(SetSol) ) ; format('~q seen~n', [SetSol])),
	fail
.
sub_lists_gen(_, Sol) :-
	sol(Sol).

gen_sub_lists(_, []).
gen_sub_lists([Y], [Y]).
gen_sub_lists(S , [X | Sol]) :- S = [_, _ | _],
    append(A, [X | B], S),
	append(A, B, RS),
	gen_sub_lists(RS, Sol)   	
.

/*
B5) Usando `assert`, `retract` y `retractall`, haga predicados que permitan tener un contador mutable en `Prolog` algo como se ilustra abajo. *Sugerencia*: Estudie `gensym/2` y relativos.
*/

counter_new(Name, Value, Counter) :-
    atom(Name), number(Value),
    gensym(Name, Counter),
	retractall(counter(Counter, _, _)),
	assert( counter(Counter, name, Name) ),
	assert( counter(Counter, val, Value) )
	
.
counter_get_name(Counter, Name) :- counter(Counter, name, Name).
counter_get_value(Counter, Value) :- counter(Counter, val, Value).
counter_inc(Counter, Inc) :-
    atom(Counter), 
	retract( counter(Counter, val, OldVal) ), 
	NewVal is OldVal + Inc,
	assert(counter(Counter, val, NewVal))
.
counter_delete(Counter) :-
    retractall(counter(Counter, _, _))
.
test_counter :-
	counter_new(x, 0, Counter), 
	counter_get_name(Counter, Name),
	writeln(Name), 
	counter_get_value(Counter, InitValue),
	writeln(InitValue), 
	counter_inc(Counter, 2),
	counter_get_value(Counter, NextValue),
	writeln(NextValue),
	counter_delete(Counter)
.
	





