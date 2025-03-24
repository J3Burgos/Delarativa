%%% HECHOS
padre(abraham, isaac).
padre(abraham, ismael).
padre(haran, lot).
padre(haran, melca).
padre(haran, jesca).
padre(teraj, abraham).
padre(teraj, najor).
padre(teraj, haran).
padre(teraj, sarai).
padre(najor, bautel).
padre(isaac, esau).
padre(isaac, jacob).
padre(bautel, rebecca).
padre(bautel, laban).


madre(agar, ismael).
madre(sarai, isaac).
madre(melca, bautel).
madre(rebecca, esau).
madre(rebecca, jacob).

hombre(isaac).
hombre(lot).
hombre(abraham).
hombre(najor).
hombre(haran).
hombre(teraj).
hombre(ismael).
hombre(bautel).
hombre(esau).
hombre(jacob).
hombre(lot).
hombre(laban).

mujer(melca).
mujer(jesca).
mujer(sarai).
mujer(agar).
mujer(rebeca).

esclava(agar).

matrimonio(abraham, sarai).
matrimonio(najor, melca).
matrimonio(isaac, rebeca).
matrimonio(sarai, abraham).
matrimonio(melca, najor).
matrimonio(rebeca, isaac).

%%% REGLAS
% ascendiente  
ascendiente_directo(X, Y) :- (padre(X, Y); madre(X, Y)).
ascendiente(X, Z) :- ascendiente_directo(X, Z).
ascendiente(X, Z) :- ascendiente_directo(X, Y), ascendiente(Y, Z).


% descendiete
descendiente_directo(X, Y) :- (padre(Y, X); madre(Y, X)).
descendiente(X, Z) :- descendiente_directo(X, Z).
descendiente(X, Z) :- descendiente_directo(X, Y), descendiente(Y, Z).


% abuelo/abuela
abuelo(X, Y) :- padre(X, Z), (ascendiente_directo(Z, Y)).
abuela(X, Y) :- madre(X, Z), (ascendiente_directo(Z, Y)).

% hermano/hermana
hermano(X, Y) :- hombre(X), ascendiente_directo(Z, X), ascendiente_directo(Z, Y), X \= Y.
hermana(X, Y) :- mujer(X), ascendiente_directo(Z, X), ascendiente_directo(Z, Y), X \= Y.
hermanos(X, Y) :- hermano(X, Y); hermana(X, Y).

% tio/tia
tio_sangre(X, Y) :- ascendiente_directo(Z ,Y), hermano(X, Z).
tia_sangre(X, Y) :- ascendiente_directo(Z, Y), hermana(X, Z).
tio_politico(X, Y) :- matrimonio(X, Z), hermana(Z, W), ascendiente_directo(W, Y).
tia_politica(X, Y) :- matrimonio(X, Z), hermano(Z, W), ascendiente_directo(W, Y).
tia(X, Y) :- (tia_sangre(X, Y); tia_politica(X, Y)).
tio(X, Y) :- (tio_sangre(X, Y); tio_politico(X, Y)).

% sobrino/sobrina
sobrino(X, Y) :- hombre(X), (tia(Y, X); tio(Y, X)).
sobrina(X, Y) :- mujer(X), (tia(Y, X); tio(Y, X)).

% primo/prima
primo(X, Y) :- hombre(X), ascendiente_directo(Z, X), ascendiente_directo(W, Y), hermanos(Z, W), Z \== W.
prima(X, Y) :- mujer(X), ascendiente_directo(Z, X), ascendiente_directo(W, Y), hermanos(Z, W), Z \== W.
primos(X, Y) :- primo(X, Y); prima(X, Y).

% incesto
incesto(X,Y) :- matrimonio(X, Y), 
                (hermanos(X, Y); primos(X, Y); 
                ascendiente_directo(X, Y); ascendiente_directo(Y, X); 
                abuelo(X, Y); abuela(X, Y); 
                sobrina(X, Y); sobrino(X, Y)).