% Definir la relación aplanar(Lista, Aplanada), donde Lista es en general una lista de listas, tan compleja en su 
% anidamiento como queramos imaginar, y Aplanada es la lista que resulta de reorganizar los elementos contenidos en 
% las listas anidadas en un único nivel, i.e. una lista plana. Por ejemplo

aplanar([X|Resto], [X|Res_Resto]) :-  atomic(X), aplanar(Resto, Res_Resto).
aplanar([X|Resto], Resultado) :- not(atomic(X)), aplanar(X, Res_X), aplanar(Resto, Res_Resto), append(Res_X, Res_Resto, Resultado).