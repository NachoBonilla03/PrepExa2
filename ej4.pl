num([Digit| Numbers], [Digit|D], Z) :-
    code_type(Digit, digit),
    num(Numbers, D, Z).
num([], A, A).


/*
num([Digit|Numbers])-->[Digit], {code_type(Digit, digit)},num(Numbers). 
num([])-->[]. 
*/

6 ?- atom_codes('   abc',Codes),ws(Codes,O).
Codes = [32, 32, 32, 97, 98, 99],
O = [97, 98, 99]