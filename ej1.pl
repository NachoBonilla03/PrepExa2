
ws-->[C], {code_type(C, space)}, ws. 
ws-->[].


num([C,Numbers])-->[C], {code_type(C, digit)},num(Numbers). 
num([])-->[]. 

ident([C,Letters])-->[C], {code_type(C, alpha)},ident(Letters). 
ident([])-->[]. 

number(N)-->ws, num(Numbers), {Numbers \= [], number_codes(N,Numbers)}, ws.

identifier(C)-->ws, ident(Letters), {Letters\= [], atom_codes(C,Letters)}, ws. 

atomic-->identifier. 
atomic-->number. 

expression-->atomic. 
expression-->addition. 

add-->ws, "+", ws.
addition-->expression, add, expression. 


