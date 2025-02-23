padre(juan, maria).
padre(juan, pedro).
padre(pedro, luis).

abuelo(X, Y) :- padre(X, Z), padre(Z, Y).
