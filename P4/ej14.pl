% esRosadelfa(O, N): verifica si O es una rosadelfa de grado N.
esRosadelfa(nil, _).
esRosadelfa(hoja(X), _) :- tipo(X).
esRosadelfa(nodo(X, Hijos), N) :-
    tipo(X),
    length(Hijos, G), G =< N,
    esListaRosadelfas(Hijos, N).

% esListaRosadelfas(L, N): verifica si todos los elementos de L son rosadelfas de grado N.
esListaRosadelfas([], _).
esListaRosadelfas([R|Rs], N) :-
    esRosadelfa(R, N),
    esListaRosadelfas(Rs, N).

% tipo(X): define el tipo permitido para los elementos (aquí, enteros).
tipo(X) :- integer(X).




% Tests
?- esRosadelfa(nodo(1, [hoja(2), hoja(3)]), 2).
true.

?- esRosadelfa(nodo(1, [hoja(2), hoja(3), hoja(4)]), 2).
false.

?- esRosadelfa(nodo(a, [hoja(2)]), 2).
false.
