SpeedUp=T1/T2

tiempoejecucion(Goal, T) :-
    statistics(runtime, [Start|_]),
    Goal,
    statistics(runtime, [End|_]),
    T is End - Start.


% Longitud2(L, N) :- N es la longitud de la lista L.
longitud2(L, N) : - longitud2(L, 0, N).

% longitud2(L, A, N) :- N es la longitud de la lista L, A es un parametro de acumulacion que se utiliza para contar la longitud de la lista.
longitud2([], A, A).
longitud2([X|X2], A, N) :- NewA is A + 1, longitud2(X2, NewA, N).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% PSEUDOCODIGO DE LO DE ANTES %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function longitud (L:Lista) : integer
var : A : integer
begin 
    A := 0
    while L != [] do
        begin
            A := A + 1
            L := Tail(L)
        end
        longitud := A
    end
end