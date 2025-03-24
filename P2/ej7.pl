%Definir un predicado descomponer(N,A,B) que permita resolver el problema de descomponer un número natural N 
%en la suma de dos pares A y B. Esto es,descomponer(N,A,B) debe tomar como entrada un natural N y devolver dos 
%naturales A y B tales que N = A + B.
%[Ayuda: utilizar el predicado between/3]

descomponer(N, A, B) :-
    between(0, N, A),
    0 is A mod 2, B is N - A.
