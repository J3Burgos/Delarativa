%% quicksort(L, O)
%% O es la lista ordenada que resulta de aplicar quicksort a L

quicksort([], []).
quicksort([Pivote|Resto], Ordenada) :-
    dividir_con_pivote(Resto, Pivote, Menores, Mayores),
    quicksort(Menores, OM),
    quicksort(Mayores, OMAY),
    append(OM, [Pivote|OMAY], Ordenada).

%% dividir_con_pivote(L, N, L1, L2)
%% Predicado auxiliar que separa la lista L en L1 y L2 usando N como pivote.
%% Se reutiliza la idea del ejercicio 9 (partir), pero se aplica directamente
%% a Resto, ya que el pivote ya ha sido extraído.

dividir_con_pivote([], _, [], []).
dividir_con_pivote([X|Xs], N, [X|L1], L2) :-
    X =< N,
    dividir_con_pivote(Xs, N, L1, L2).
dividir_con_pivote([X|Xs], N, L1, [X|L2]) :-
    X > N,
    dividir_con_pivote(Xs, N, L1, L2).



%% Tests
?- quicksort([5, 3, 8, 1, 4], R).
R = [1, 3, 4, 5, 8].
