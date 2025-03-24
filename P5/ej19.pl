% Versión ingenua
longitud1([], 0).
longitud1([_|T], N) :- longitud1(T, Z), N is Z + 1.

% Versión eficiente con acumulador
longitud2(L, N) :- longitud2(L, N, 0).
longitud2([], A, A).
longitud2([_|T], N, A) :- A1 is A + 1, longitud2(T, N, A1).


% Comparación de longitud1, longitud2 y length

test_longitud_completo :-
    construir_lista(50000, L),  % lista suficientemente grande para observar diferencias

    % medir longitud1
    T1A is cputime,
    longitud1(L, _),
    T1B is cputime,
    T1 is T1B - T1A,

    % medir longitud2
    T2A is cputime,
    longitud2(L, _),
    T2B is cputime,
    T2 is T2B - T2A,

    % medir length
    T3A is cputime,
    length(L, _),
    T3B is cputime,
    T3 is T3B - T3A,

    % calcular speedups
    (T1 > 0 -> S21 is T1 / T2 ; S21 = infinito),
    (T3 > 0 -> S31 is T1 / T3 ; S31 = infinito),

    % mostrar resultados
    nl, writeln('--- Comparación de longitud ---'),
    format('longitud1: ~6f s~n', [T1]),
    format('longitud2: ~6f s~n', [T2]),
    format('length   : ~6f s~n', [T3]),
    nl,
    format('Speedup de longitud2 sobre longitud1: ~2f~n', [S21]),
    format('Speedup de length sobre longitud1   : ~2f~n', [S31]),
    nl.
