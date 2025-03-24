%Definir un predicado igualesElem(L1,L2) que compruebe que L1 y L2 son listas que contienen los mismos elementos 
%independientemente del orden de aparición.
%[Ayuda: utilizar el predicado length/2]

igualesElem(L1, L2) :-
    sort(L1, S1),
    sort(L2, S2),
    length(S1, Len1),
    length(S2, Len2),
    Len1 =:= Len2,
    S1 == S2.
