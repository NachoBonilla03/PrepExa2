/*
0) Sin usar el shell determine si T1 y T2 unifican o no. Confirme su respuesta en el shell.
T1 = foo( [X |[[X+a] ]],g(X)), T2 = foo( [g(Z)|[[g(a)+Y]]], g(g(Y)) )
*/

/*
1) Escriba solve(+N, -P) que  dado un entero no negativo N retorne triples P=[X, Y, Z] talque X + Y + Z  
suman exactamente N, donde X, Y, y Z son enteros no negativos.
*/


/*
2) Escriba mymap(:G, +L, -M) recursiva que funcione exactamente como maplist(G, L, M) de Prolog.
*/

/*
3) Termine biesc de forma que maneje el caso planteado en clase. Compile print como console.log.
*/

/*
4) Haga un nuevo caso así y logre su compilación en JS con biesc (recuerde que estamos por ahora solo generando JS). Caso:
let splash = (msg) => print(msg)
let greetings = () => "Hello World!"
let version = (4 + 1 - 2)
splash("Testing helloworld Version " + version + " ***")
print(greetings())
*/

/*
5) Modifique biesc para que genere un archivo de salida. Siga este ejemplo:
open(Filename, write, Stream), % un stream es una abstracción de archivo
set_output(Stream), % cambia el stdout al stream
biesc(Filename),    % llama el "compilador"
close(Stream)       % cierra el archivo
*/