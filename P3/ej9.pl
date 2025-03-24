%% partir(L, L1, L2)
%% L1 contiene los elementos menores o iguales que N (excluyendo N),
%% L2 contiene los elementos mayores que N (también excluyendo N),
%% donde N es el primer elemento de L.

partir([], [], []).
partir([N|Resto], L1, L2) :- 
    dividir_lista(Resto, N, L1, L2).

%% dividir_lista(Lista, N, MenoresIguales, Mayores)
%% Clasifica los elementos de Lista en función de N

dividir_lista([], _, [], []).
dividir_lista([X|T], N, [X|L1], L2) :- 
    X =< N, 
    dividir_lista(T, N, L1, L2).
dividir_lista([X|T], N, L1, [X|L2]) :- 
    X > N, 
    dividir_lista(T, N, L1, L2).


%% Tests
?- partir([4, 2, 6, 5, 1, 3], L1, L2).
L1 = [2, 1, 3],
L2 = [6, 5].
