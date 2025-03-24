% Rompecabezas de Brandreth. El cuadrado de 45 es 2025. Notad que si partimos el número en dos obtenemos los números 20 
% y 25 cuya suma es, precisamente, 45. Obtener que otros números cuyo cuadrado es un número de cuatro cifras cumplen 
% esta propiedad. Con este fin, definir un predicado numBrandreth (N, C) que devuelva uno de estos números N y su 
% cuadrado C.
% [Ayuda: los números N cuyo cuadrado es de cuatro cifras pueden generarse mediante una llamada al predicado 
% between(32, 99, N)].

numBrandreth(N, C) :-
    between(32, 99, N),        % N cuyo cuadrado tiene 4 cifras
    C is N * N,                % Calculamos el cuadrado
    C >= 1000, C =< 9999,      % Aseguramos que tenga 4 cifras
    D1 is C // 100,            % Primeras dos cifras (división entera)
    D2 is C mod 100,           % Últimas dos cifras (resto)
    N =:= D1 + D2.             % Verificamos la propiedad
