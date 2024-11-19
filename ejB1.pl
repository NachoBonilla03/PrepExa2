solve(N, X,Y,Z):-between(0,N,X),between(0,X,Y),between(0,Y,Z), N =:=X+Y+Z.

allSolutions(N, L):- 
    findall(["X"-X,"Y"-Y,"Z"-Z],solve(N,X,Y,Z), L).