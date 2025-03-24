%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% peso(A, P): P es el número de nodos (peso) del árbol A.
peso(nil, 0).
peso(hoja(_), 1).
peso(nodo(_, Hijos), P) :-
    pesoLista(Hijos, PH),
    P is PH + 1.

% pesoLista(L, P): P es la suma de los pesos de los árboles en la lista L.
pesoLista([], 0).
pesoLista([A|Resto], P) :-
    peso(A, PA),
    pesoLista(Resto, PR),
    P is PA + PR.


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% grado(A, G): G es el grado maximo del arbol A.
grado(nil, 0).
grado(hoja(_), 0).
grado(nodo(_, Hijos), G) :-
    length(Hijos, G1),
    maxGradoLista(Hijos, G2),
    G is max(G1, G2).

% maxGradoLista(L, G): G es el grado maximo entre los arboles de la lista L.
maxGradoLista([], 0).
maxGradoLista([A|Resto], G) :-
    grado(A, GA),
    maxGradoLista(Resto, GR),
    G is max(GA, GR).



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% frontera(A, F): F es la lista de hojas (valores de hoja/1) del árbol A.
frontera(nil, []).
frontera(hoja(X), [X]).
frontera(nodo(_, Hijos), F) :-
    fronteraLista(Hijos, F).

% fronteraLista(L, F): F es la concatenación de las fronteras de los árboles en L.
fronteraLista([], []).
fronteraLista([A|Resto], F) :-
    frontera(A, FA),
    fronteraLista(Resto, FR),
    append(FA, FR, F).



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% preorden(A, L): L es la lista de nodos visitados en recorrido preorden.
preorden(nil, []).
preorden(hoja(X), [X]).
preorden(nodo(X, Hijos), [X|R]) :-
    preordenLista(Hijos, R).

% preordenLista(L, R): R es el recorrido preorden concatenado de los árboles en L.
preordenLista([], []).
preordenLista([A|Resto], R) :-
    preorden(A, RA),
    preordenLista(Resto, RR),
    append(RA, RR, R).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


?- A = nodo(1, [hoja(2), nodo(3, [hoja(4), hoja(5)])]),
   peso(A, P), grado(A, G), frontera(A, F), preorden(A, L).
P = 5,
G = 2,
F = [2, 4, 5],
L = [1, 2, 3, 4, 5].
