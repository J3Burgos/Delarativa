/*
Ejercicio 13.

d(P, D): D es la derivada simplificada del polinomio simbólico P con respecto a la variable x.
*/

% Predicado principal
d(P, D) :-
    derivar(P, Cruda),
    simplificar(Cruda, D).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Derivación simbólica
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Derivada de suma
derivar(P + Q, DP + DQ) :-
    derivar(P, DP),
    derivar(Q, DQ).

% Derivada de resta
derivar(P - Q, DP - DQ) :-
    derivar(P, DP),
    derivar(Q, DQ).

% Derivada de constante
derivar(C, 0) :- integer(C).

% Derivada de x
derivar(x, 1).

% Derivada de x ** N
derivar(x ** N, N * x ** M) :-
    integer(N),
    M is N - 1.

% Derivada de C * x
derivar(C * x, C) :- integer(C).

% Derivada de C * x ** N
derivar(C * x ** N, R) :-
    integer(C), integer(N),
    M is N - 1,
    F is C * N,
    R = F * x ** M.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Simplificación del resultado
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

simplificar(E, S) :-
    simplify(E, R),
    (E == R -> S = R ; simplificar(R, S)).

% Reglas de simplificación básicas

% Eliminación de sumandos nulos
simplify(0 + X, X) :- !.
simplify(X + 0, X) :- !.
simplify(0 - X, -X) :- !.
simplify(X - 0, X) :- !.

% Simplificación recursiva de expresiones compuestas
simplify(A + B, SA + SB) :-
    simplify(A, SA),
    simplify(B, SB).
simplify(A - B, SA - SB) :-
    simplify(A, SA),
    simplify(B, SB).

% Reglas para potencias de 1
simplify(x ** 1, x) :- !.

% Reglas para multiplicación simplificable
simplify(C * x ** 0, C) :- integer(C), !.
simplify(1 * X, X) :- !.
simplify(X * 1, X) :- !.

% No se puede simplificar mas
simplify(E, E).




% Tests
?- d(2 * x ** 2 + 3, D).
D = 4 * x.

?- d(5 * x ** 3 + 2 * x + 7, D).
D = 15 * x ** 2 + 2.
