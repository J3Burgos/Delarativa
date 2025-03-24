/* 
Ejercicio 11. (Mezcla ordenada —merge_sort—)

merge_sort(L, O), O es la lista que resulta de ordenar 
la lista L mediante el algoritmo de mezcla ordenada (merge sort).
*/

merge_sort([], []).
merge_sort([X], [X]).
merge_sort(Lista, Ordenada) :-
    dividir_mitad(Lista, Izq, Der),
    merge_sort(Izq, OIzq),
    merge_sort(Der, ODer),
    fusionar(OIzq, ODer, Ordenada).

/* 
dividir_mitad(L, L1, L2)
Divide la lista L en dos mitades L1 y L2 (la diferencia de longitud entre ambas es como mucho 1)
*/
dividir_mitad(L, L1, L2) :-
    length(L, N), 
    M is N // 2, 
    length(L1, M), 
    append(L1, L2, L).

/* 
fusionar(L1, L2, Resultado)
Mezcla dos listas ordenadas L1 y L2 en una única lista Resultado, también ordenada.
*/
fusionar([], L, L).
fusionar(L, [], L).
fusionar([X|Xs], [Y|Ys], [X|R]) :-
    X =< Y, 
    fusionar(Xs, [Y|Ys], R).
fusionar([X|Xs], [Y|Ys], [Y|R]) :-
    X > Y, 
    fusionar([X|Xs], Ys, R).



/* Tests */
?- merge_sort([5, 2, 8, 1, 4], R).
R = [1, 2, 4, 5, 8].
