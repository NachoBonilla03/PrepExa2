/*
2) Ejercicio de investigación cort en avance usando recursión y el predicado is.
Escriba greet(N) que imprima N veces 'Hello World!".
*/
greet(0):-!. 
greet(N):-
N > 0,
format("~w~n~d", ['Hello World!',N]),
N1 is N - 1,    
greet(N1).
