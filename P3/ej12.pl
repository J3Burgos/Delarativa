/*
Ejercicio 12.

eval(P, V, R): R es el resultado de evaluar el polinomio P para el valor V de la variable x.
La variable x se trata como constante simbólica. Se permite el uso de +, -, *, **.
*/

% Caso 1: Polinomio con suma
eval(P + Q, V, R) :-
    eval(P, V, RP),
    eval(Q, V, RQ),
    R is RP + RQ.

% Caso 2: Polinomio con resta
eval(P - Q, V, R) :-
    eval(P, V, RP),
    eval(Q, V, RQ),
    R is RP - RQ.

% Caso 3: Monomio constante
eval(C, _, C) :-
    integer(C), !.

% Caso 4: Monomio del tipo C * x ** N
eval(C * x ** N, V, R) :-
    integer(C), integer(N),
    R is C * V ** N, !.

% Caso 5: Monomio del tipo C * x
eval(C * x, V, R) :-
    integer(C),
    R is C * V, !.

% Caso 6: Variable x sola
eval(x, V, V) :- !.

% Caso 7: x elevada a una potencia
eval(x ** N, V, R) :-
    integer(N),
    R is V ** N.




% Tests
?- eval(5 * x ** 2 + 1, 4, R).
R = 81.

?- eval(3 * x ** 3 - 2 * x + 7, 2, R).
R = 21.
