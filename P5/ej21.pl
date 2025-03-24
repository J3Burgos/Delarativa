% Versión ineficiente (doble recursión)
fib(1, 1).
fib(2, 1).
fib(N, F) :-
    N > 2,
    N1 is N - 1, N2 is N - 2,
    fib(N1, F1),
    fib(N2, F2),
    F is F1 + F2.

% Versión eficiente con acumulador (fib2)
fib2(N, F) :- fib2(N, F, _).

fib2(0, 0, 0) :- !.
fib2(1, 1, 1) :- !.
fib2(2, 1, 1) :- !.
fib2(N, F, Fn_1) :-
    N1 is N - 1,
    fib2(N1, Fn_1, Fn_2),
    F is Fn_1 + Fn_2.



% Comparación entre fib (ineficiente) y fib2 (eficiente con acumulador)

test_fib_completo :-
    N = 35,  % suficientemente grande para notar diferencia sin bloquear

    T1A is cputime,
    fib(N, _),
    T1B is cputime,
    T1 is T1B - T1A,

    T2A is cputime,
    fib2(N, _),
    T2B is cputime,
    T2 is T2B - T2A,

    (T2 > 0 -> S is T1 / T2 ; S = infinito),

    nl, writeln('--- Comparación de Fibonacci ---'),
    format('fib (~w): ~6f s~n', [N, T1]),
    format('fib2(~w): ~6f s~n', [N, T2]),
    nl,
    format('Speedup de fib2 sobre fib: ~2f~n', [S]),
    nl.
