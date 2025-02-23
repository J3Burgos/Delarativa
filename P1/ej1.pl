%%% HECHOS EXISTENTES
% Relaciones de paternidad
padre(abraham, isaac).
padre(haran, lot).
padre(haran, melca).
padre(haran, jesca).
padre(teraj, abraham).
padre(teraj, najor).
padre(teraj, haran).
padre(abraham, ismael).
padre(isaac, esau).
padre(isaac, jacob).

% Relaciones de maternidad
madre(agar, ismael).
madre(sarai, isaac).
madre(melca, batuel).
madre(rebeca, esau).
madre(rebeca, jacob).

% Relaciones de género
hombre(isaac).
hombre(lot).
hombre(teraj).
hombre(abraham).
hombre(najor).
hombre(ismael).
hombre(esau).
hombre(jacob).
hombre(batuel).

mujer(melca).
mujer(jesca).
mujer(sarai).
mujer(agar).
mujer(rebeca).

% Relaciones de matrimonio
esposo(abraham, sarai).
esposo(najor, melca).
esposo(isaac, rebeca).


%%% REGLAS

% Ascendiente (directo e indirecto)
ascendiente_directo(X, Y) :- padre(X, Y) ; madre(X, Y).
ascendiente(X, Z) :- ascendiente_directo(X, Z).
ascendiente(X, Z) :- ascendiente_directo(X, Y), ascendiente(Y, Z).

% Descendiente (opuesto de ascendiente)
descendiente(X, Y) :- ascendiente(Y, X).

% Abuelo/Abuela
abuelo(X, Y) :- padre(X, Z), (padre(Z, Y) ; madre(Z, Y)).
abuela(X, Y) :- madre(X, Z), (padre(Z, Y) ; madre(Z, Y)).

% Hermano/Hermana
hermano(X, Y) :- padre(P, X), padre(P, Y), madre(M, X), madre(M, Y), X \= Y.
hermana(X, Y) :- hermano(X, Y), mujer(X).

% Tío/Tía (hermanos de padre o madre)
tio(X, Y) :- hermano(X, P), padre(P, Y).
tio(X, Y) :- hermano(X, M), madre(M, Y).
tia(X, Y) :- hermana(X, P), padre(P, Y).
tia(X, Y) :- hermana(X, M), madre(M, Y).

% Sobrino/Sobrina (hijos de hermanos)
sobrino(X, Y) :- hombre(X), (tio(Y, X) ; tia(Y, X)).
sobrina(X, Y) :- mujer(X), (tio(Y, X) ; tia(Y, X)).

% Primos (hijos de hermanos)
primo(X, Y) :- padre(P1, X), padre(P2, Y), hermano(P1, P2), hombre(X).
primo(X, Y) :- madre(M1, X), madre(M2, Y), hermana(M1, M2), hombre(X).
prima(X, Y) :- padre(P1, X), padre(P2, Y), hermano(P1, P2), mujer(X).
prima(X, Y) :- madre(M1, X), madre(M2, Y), hermana(M1, M2), mujer(X).

% Incesto (relaciones consideradas incestuosas)
incesto(X, Y) :- esposo(X, Y), (hermano(X, Y) ; hermana(X, Y)).
incesto(X, Y) :- padre(X, Y) ; madre(X, Y).
incesto(X, Y) :- abuelo(X, Y) ; abuela(X, Y).



