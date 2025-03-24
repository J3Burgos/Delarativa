% Comparación de invertir1, invertir2 y reverse usando listas grandes

test_invertir_completo :-
    construir_lista(5000, L),
    
    % Medimos tiempo de invertir1
    T1A is cputime,
    invertir1(L, _),
    T1B is cputime,
    T1 is T1B - T1A,

    % Medimos tiempo de invertir2
    T2A is cputime,
    invertir2(L, _),
    T2B is cputime,
    T2 is T2B - T2A,

    % Medimos tiempo de reverse
    T3A is cputime,
    reverse(L, _),
    T3B is cputime,
    T3 is T3B - T3A,

    % Calculamos speedups
    (T1 > 0 -> S21 is T1 / T2 ; S21 = infinito),
    (T3 > 0 -> S3 is T1 / T3 ; S3 = infinito),

    % Resultados
    nl, writeln('--- Comparación de invertir ---'),
    format('invertir1: ~6f s~n', [T1]),
    format('invertir2: ~6f s~n', [T2]),
    format('reverse  : ~6f s~n', [T3]),
    nl,
    format('Speedup de invertir2 sobre invertir1: ~2f~n', [S21]),
    format('Speedup de reverse sobre invertir1  : ~2f~n', [S3]),
    nl.
