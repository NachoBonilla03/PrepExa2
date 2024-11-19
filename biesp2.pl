

:-use_module(library(dcg/basic))
/*Estp es basicamente la forma en la que importo una libreria*/

/* packman_ws(I, O): camina en I comiendo spaces, dejando en O lo que sobra*/
packman_ws([], []).
packman_ws([C | I], O) :- code_type(C, space), !, packman_ws(I, O).
packman_ws([C | I], [C | I]).

packman_int([], [], []).
packman_int([C | R], [C | I], O) :- code_type(C, digit), !, packman_int(R, I, O).
packman_int([], [C | I], [C | I]).



test_packman(A, S) :-
	atom_codes(A, Codes), 
	packman_ws(Codes, WithoutSpaces), 
	packman_int(R, WithoutSpaces, _O),
	atom_codes(S, R)
.

/*Clase 05/11/2024*/
parser(Filename, AST):-phrase_from_file(program (AST), Filename).


program(ok,_,_). 
test_parser:-
	parser("FakeProgram.bies", AST), 
	writeln(AST)
.


rule(A,B)>-
	A=B
. 

program(ok(Aes))-->sequence_of_a(Aes)
sequence_of_a([a | Aes])-->ws, "a", sequence_of_a(Aes) 
sequence_of_a([])-->[] %Con esto indico el caso base que es que ya no quedan Aes


/*
rule()-->[] con esto indico que termine ahi
lo mismo que 
program(ok)-->[]
*/

/*Traduccion de packmanWs a dcg*/
%Original
ws([], []).
ws([C | I], O) :- code_type(C, space), !, ws(I, O).
ws([C | I], [C | I]).


ws()--> [C], {code_type(C, space)}, !, ws.
%Chequea caracter que viene de entrada y como  quiero ejecutar codigo prolog puro dentro de dcg, debo encerrarlo
dentro de {}
ws -->[].


/*Ahora queremos que sea capaz de parsear 
let x = 123
*/

/*paser de assign*/
assign-->ws, "=", ws. 

/*Parser para let*/
let-->ws, "let", ws

/* parenthesis*/
leftpar-->ws,"(",ws.
right_par-->ws,")",ws.

/*Parser de call*/
call(I)-->identifier(I), "(". 

/*parser para identificador*/
identifier(I)-->ws,letters(Letters),{Letters \= [], atom_codes(I,Letters)}, ws. 
letters([C,Letters])-->[C], {code_type(C, alpha)}, letters(Letters). 
letters([])-->[]. 

/*Parser para valores*/
integer(N)-->ws, numbers(Numbers), {Numbers \= [], number_codes(N,Numbers)}, ws. 
numbers([N, Numbers])--> [N], {code_type(N,digit)}, numbers(Numbers). 
numbers([])-->[]

/*expression de argumentos
el more args chequea coma entre argumentos
*/
args_expressions([Expr|Args])-->expression(Expr), more_args_expressions(Args). 
args_expressions([])-->[]. 
more_args_expressions([Expr|Args])-->comma, expression(Expr), more_args_expressions(Args). 
comma-->ws, ",", ws. 
more_args_expressions([])-->[]. 



/*parser de expresiones*/
parser(Filename, AST):-phrase_from_file(program (AST), Filename).
program(ok(AES))-->expressions(AES).
expressions([E, Expressions])-->expression(E), expressions(Expressions).
expression([])-->[].
expression(let(id(I), Expr))-->let, identifier(I), assign, expression(Expr).
expression(id(I),Args)-->identifier(I), leftpar,{!},args_expressions(Args), right_par.  
expression(num(N))-->numbers(N). 

