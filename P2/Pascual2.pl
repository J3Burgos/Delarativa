%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%                          LISTAS                                   %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Ejercicio 4. 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% sus(X,Y,L1,L2),
%%% Sustituir el elemento X por Y en la lista L1, para dar L2.
sus(_,_,[],[]).	
sus(X,Y,[Z|T],[Y|S]):-X=Z,sus(X,Y,T,S).	
sus(X,Y,[Z|T],[Z|S]):-X\=Z,sus(X,Y,T,S).

%%% sus2(X,Y,L1,L2),
%%% Idem. usando el corte
sus2(_,_,[],[]).	
sus2(X,Y,[X|T],[Y|S]):-!,sus2(X,Y,T,S).	
sus2(X,Y,[Z|T],[Z|S]):-sus2(X,Y,T,S).

%%% sus3(X,Y,L1,L2),
%%% El comportamiento de sus3 difiere de sus y sus2
%%% para "?- sus(X,b,[a,b,c,a,b,c],L).". El comportamiento
%%% es identico cuando los argumentos estan instanciados.
sus3(_,_,[],[]).	
sus3(X,Y,[Z|T],[Y|S]):-X==Z,sus3(X,Y,T,S).	
sus3(X,Y,[Z|T],[Z|S]):-X\==Z,sus3(X,Y,T,S).

%%% sus4(X,Y,L1,L2) No es una implementaci�n correcta del problema
%%% Produce contestaciones que no son una respuesta (como producto de 
%%% haber eliminado el corte de forma directa o indirecta
%%% NO ES POSIBLE LA INVERSIBILIDAD
sus4(_,_,[],[]).	
sus4(X,Y,[Z|T],[Y|S]):-X=Z,sus4(X,Y,T,S).	
sus4(X,Y,[Z|T],[Z|S]):-sus4(X,Y,T,S).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Ejercicio 5. 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
/* Aplanar una lista: Definir la relaci�n aplanar(Lista, Aplanada), 
donde Lista es en general una lista de listas, tan compleja en su 
anidamiento como queramos imaginar, y Aplanada es la lista que resulta 
de reorganizar los elementos contenidos en las listas anidadas en un 
�nico nivel. Por ejemplo:
	?- aplanar([[a, b], [c, [d, e]], f], L).
	L = [a, b, c, d, e, f]                              */
	
aplanar([], []).
% aplanar([X|Resto], Resultado) :-
%	atomic(X), aplanar(Resto, Res_Resto), Resultado = [X|Res_Resto].
% Lo que sigue es preferible a lo anterior :
aplanar([X|Resto], [X|Res_Resto]) :-  atomic(X), aplanar(Resto, Res_Resto).
aplanar([X|Resto], Resultado) :-
	not(atomic(X)), aplanar(X, Res_X), aplanar(Resto, Res_Resto), append(Res_X, Res_Resto, Resultado).
	     

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Ejercicio 6. 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% igualesElem(L1,L2) comprueba que L1 y L2 son listas con iguales elementos 
%%% en cualquier orden.

igualesElem([],[]).
igualesElem([X|Xs],[X|Ys]):- !, igualesElem(Xs,Ys). 
igualesElem([X|Xs],[Y|Ys]):- eliminar(X,Ys,YYs), eliminar(Y,Xs,XXs), igualesElem(XXs,YYs). 

%%% Elimina un elemento X si, en efecto, aparece en la lista.
%%% Elimina el primer elemento que encuentra y corta la computaci�n.
eliminar(_,[],[]).
eliminar(X,[X|Ys],Ys):- !.
eliminar(X,[Y|Ys],[Y|Zs]):- eliminar(X,Ys,Zs).

%%% Hay un predicado est�ndar que realiza la misma funci�n que eliminar: 
%%% select(X, Xs, Ys),  % Select X from Xs, leaving Ys

%%%%%%%%%%
g_ie(L1,L2,T):- T1 is cputime, igualesElem(L1,L2),  T2 is cputime, T is T2-T1.   

g(N,T) :- construir_lista(N,L1), reverse(L1,L2), g_ie(L1, L2, T).



%%%%%%%%%%%%%%%%%%%%%%% PREDICADOS AUXILIARES:

/***************************************
construir_lista(N,L): obtiene una lista L que contenga N caracteres aleatorios elegidos entre las letras min�sculas del alfabeto espa�ol. 

Para crear un programa en Prolog que genere una lista de longitud N con caracteres aleatorios del alfabeto espa�ol, podemos usar la librer�a random para generar n�meros aleatorios y luego convertir esos n�meros a caracteres. Aqu� tienes un ejemplo de c�mo hacerlo:
****************************************/

:- use_module(library(random)).

% Predicado para generar una lista de longitud N con caracteres aleatorios
construir_lista(0, []).
construir_lista(N, [Char|Resto]) :-
    N > 0,
    N1 is N - 1,
    random_between(97, 122, RandomCode), % C�digos ASCII para letras min�sculas del alfabeto espa�ol (97=a, 122=z)
    char_code(Char, RandomCode),
    construir_lista(N1, Resto).


/*****************************
permutar(Xs, Ys): cierto si Ys es una permutaci�n de la lista Xs.

Una soluci�n usando append/3
*****************************/
permutar([],[]).
permutar([X|Xs],P):- permutar(Xs,Ps), append(U,V,Ps), append(U,[X|V],P).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%% igualesElem/2 usando append/3
e310([],[]).
e310([H|T],L):- append(L1,[H|L2],L),
	        append(L1,L2,L3),e310(T,L3).

g_ie310(L1,L2,T):- T1 is cputime, e310(L1,L2),  T2 is cputime, T is T2-T1.   

g2(N,T) :- construir_lista(N,L1), reverse(L1,L2), g_ie310(L1, L2, T).




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%                        ARITMETICA                                 %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Ejercicio 7. 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
/***********************************
Problema: Descomponer un n�mero en la suma de dos pares

Entrada: un natural N

Soluci�n: dos naturales A y B tales que:
A es par,
B es par,
N = A + B
************************************/

descomponer(N,A,B) :-
	between(0,N,A), A mod 2 =:= 0,
	between(0,N,B), B mod 2 =:= 0,
	N =:= A + B.

%% Mejora a "descomponer" porque si conozco A puedo calcular B mediante un c�lculo.
%% Reduzco el indeterminismo de usar between(0,N,B)
descomponer2(N,A,B) :- between(0,N,A), A mod 2 =:= 0, B is N - A, B mod 2 =:= 0.

%% Mejora a "descomponer2" porque solamente un num. par puede descomponerse en pares.
%% Adem�s, al generar los n�meros A entre 0 y NN elimino las soluciones sim�tricas.
descomponer3(N,A,B) :- N mod 2 =:= 0, NN is N // 2,
		       between(0,NN,A), A mod 2 =:= 0, B is N - A, B mod 2 =:= 0.


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Ejercicio 8. 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
/*
8) Rompecabezas de Brandreth.
El cuadrado de 45 es 2025. Notad que si 
partimos el numero en dos obtenemos los
n�meros 20 y 25 cuya suma es, 
precisamente, 45. Obtener que otros n�meros cuyo
cuadrado es un n�mero 
de cuatro cifras cumplen esta propiedad.
(Ayuda: los n�meros N cuyo cuadrado 
es de cuatro cifras pueden generarse mediante
una llamada al predicado  
between(32, 99, N)). */

numBrandreth(N, C) :- between(32, 99, N), C is N * N,
		N1 is C // 100, N2 is C mod 100,
		N is N1 + N2.


/* Numeros de Brandreth cuyo cuadrado tiene seis cifras */
numBrandreth2(N, C) :- between(317, 999, N), C is N * N,
		N1 is C // 1000, N2 is C mod 1000,
		N is N1 + N2.


