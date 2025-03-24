/*************************************************
Ejercicio 17. 
Calcular el speedup S de dos objetivos Prolog G1 y G2,
donde S = T2 / T1, siendo T1 el tiempo de ejecución de G1
y T2 el de G2.
*************************************************/

%% speedup(S, G1, G2): S es el speedup de G1 respecto a G2.
%% Usa cputime para calcular el tiempo de CPU consumido.

speedup(S, G1, G2) :-
    TIni1 is cputime,
    call(G1),
    TFin1 is cputime,
    T1 is TFin1 - TIni1,
    
    TIni2 is cputime,
    call(G2),
    TFin2 is cputime,
    T2 is TFin2 - TIni2,

    (T1 > 0 ->
        S is T2 / T1
    ;
        S = infinito
    ).

%% Variante con salida informativa por consola
speedup_info(S, G1, G2) :-
    TIni1 is cputime,
    call(G1),
    TFin1 is cputime,
    T1 is TFin1 - TIni1,

    TIni2 is cputime,
    call(G2),
    TFin2 is cputime,
    T2 is TFin2 - TIni2,

    write('Tiempo de G1: '), write(T1), nl,
    write('Tiempo de G2: '), write(T2), nl,

    (T1 > 0 ->
        S is T2 / T1,
        write('Speedup: '), write(S), nl
    ;
        S = infinito,
        write('Speedup: infinito (T1 = 0)'), nl
    ).
