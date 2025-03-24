% construirRosadelfa(L, G, R): construye una rosadelfa R de grado G a partir de la lista L.
construirRosadelfa([], _, nil).
construirRosadelfa([X], _, hoja(X)).
construirRosadelfa([X|L], G, nodo(X, SubArboles)) :-
    dividirEnGHijos(L, G, Grupos),
    construirHijos(Grupos, G, SubArboles).

% construirHijos(Grupos, G, SubArboles): construye una lista de subárboles a partir de los grupos.
construirHijos([], _, []).
construirHijos([L|Ls], G, [A|Arboles]) :-
    construirRosadelfa(L, G, A),
    construirHijos(Ls, G, Arboles).

% dividirEnGHijos(L, G, Grupos): divide la lista L en como mucho G grupos equilibrados.
dividirEnGHijos(L, G, Grupos) :-
    length(L, N),
    ( G > N ->
        listificar(L, Grupos)
    ;
        BaseSize is N // G,
        Extra is N mod G,
        dividir(L, BaseSize, Extra, Grupos)
    ).

% listificar(L, LL): convierte una lista [a,b,c] en [[a],[b],[c]].
listificar([], []).
listificar([X|Xs], [[X]|R]) :- listificar(Xs, R).

% dividir(L, Base, Extra, Partes): divide L en Partes, usando tamaños Base o Base+1 si Extra > 0.
dividir([], _, _, []).
dividir(L, Base, Extra, [P|Partes]) :-
    (Extra > 0 ->
        Len is Base + 1,
        E1 is Extra - 1
    ;
        Len is Base,
        E1 is 0
    ),
    length(P, Len),
    append(P, Resto, L),
    dividir(Resto, Base, E1, Partes).
