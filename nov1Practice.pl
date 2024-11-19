/*
2) Siguiendo los ejemplos de hoy, escriba un float_packman(Float, I, O) 
que retorne en Float los codes de un flotante que ocurra al inicio de la lista de codes I, 
sobrando O. Use el packman de whitespace para primero para eliminar whitespaces.
*/

/*
3) Usando la técnica de hoy en clase, haga un packman let_packman(-Tokens, +Source) que reciba un átomo Source, lo descomponga en sus codes, donde Source tiene frases tipo let tal como como '  \tlet xyz = 1.5  ' y retorne todos los tokens en Source en una lista. Use packmen compuestos independientes: whitespace, let, identifier, equal, float. ¡No use aún DCG! Ejemplo:
1 ?- let_packman('  let   xyz =   1.5  ', Tokens).
Tokens = [let, xyz, =, 1.5]
true
*/