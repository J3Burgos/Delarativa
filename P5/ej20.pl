% Versión ingenua
suma1([], 0).
suma1([H|T], N) :- suma1(T, Z), N is Z + H.

% Versión eficiente con acumulador
suma2(L, S) :- suma2(L, 0, S).
suma2([], A, A).
suma2([H|T], A, S) :- A1 is A + H, suma2(T, A1, S).


% Comparación de suma1 y suma2 usando listas grandes de enteros

test_suma_completo :-
    construir_lista(50000, L),
    maplist(char_code, L, Nums),  % convertir letras a códigos ASCII para que sean enteros

    % medir suma1
    T1A is cputime,
    suma1(Nums, _),
    T1B is cputime,
    T1 is T1B - T1A,

    % medir suma2
    T2A is cputime,
    suma2(Nums, _),
    T2B is cputime,
    T2 is T2B - T2A,

    % calcular speedup
    (T1 > 0 -> S is T1 / T2 ; S = infinito),

    % mostrar resultados
    nl, writeln('--- Comparación de suma ---'),
    format('suma1: ~6f s~n', [T1]),
    format('suma2: ~6f s~n', [T2]),
    nl,
    format('Speedup de suma2 sobre suma1: ~2f~n', [S]),
    nl.
