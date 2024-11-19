/*
Pendiente
*/

expression( E ) --> atomic( E ); addition( E ).
atomic( I ) --> identifier( I ).
atomic( N ) --> number( N ).
addition( Left / Right ) --> expression( Left ), "+", expression( Right ).
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