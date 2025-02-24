% Definir un predicado sus(X,Y,L1,L2) que sea capaz de sustituir un elemento X por otro Y en la lista L1, para dar L2. 
% L1 es la lista Inicial
% L2 es la lista con los cambios
% X es el elemento a cambiar
% Y es el elemento que reemplaza a X

% caso base
sus(_,_,[],[]).

% caso general
sus(X,Y,[E1|L1],[E2|L2]) :- E1 = X, E2 = Y, sus(X,Y,L1,L2).
sus(X,Y,[E1|L1],[E1|L2]) :- E1 \= X, sus(X,Y,L1,L2).

% reemplar(X,Y,[H1|L],[Y|R]) :-  member(X,[H1]),!,reemplar(X,Y,L,R).

% reemplar(X,Y,[H1|L],[H1|R]) :-  reemplar(X,Y,L,R).