% Definimos los planetas y sus órbitas
planeta('Mercurio', []).
planeta('Venus', []).
planeta('Tierra', ['Luna']).
planeta('Marte', ['Fobos', 'Deimos']).
planeta('Júpiter', ['Io', 'Europa', 'Ganimedes', 'Calisto']).
planeta('Saturno', ['Mimas', 'Encélado', 'Tetis', 'Dione', 'Rhea', 'Titán', 'Japeto']).
planeta('Urano', ['Miranda', 'Ariel', 'Umbriel', 'Titania', 'Oberón']).
planeta('Neptuno', ['Tritón', 'Nereida']).

% Iteramos sobre cada planeta y sus órbitas
imprimir_orbitas :-
    planeta(Planeta, Lunas),
    member(Luna, Lunas),
    format('El planeta ~w tiene una luna llamada ~w.~n', [Planeta, Luna]),
    fail.
imprimir_orbitas.
