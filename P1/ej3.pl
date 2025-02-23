%%% BASE DE DATOS DEL EJERCICIO 2

familia( persona(antonio, foix, fecha(7, febrero, 1950), trabajo(renfe, 1200)),
         persona(maria, lopez, fecha(17, enero, 1952), trabajo(sus_labores, 0)),
         [ persona(patricia, foix, fecha(10, junio, 1970), trabajo(estudiante, 0)),
           persona(juan, foix, fecha(30, mayo, 1972), trabajo(estudiante,0)) ] ).

familia( persona(manuel, monterde, fecha(15, marzo, 1934), trabajo(profesor, 2000)),
         persona(pilar, gonzalez, fecha(9, julio, 1940), trabajo(maestra, 1900)),
         [ persona(manolo, monterde, fecha(10, febrero, 1964), trabajo(arquitecto, 5000)),
           persona(javier, monterde, fecha(24, noviembre, 1968), trabajo(estudiante, 0)) ] ).

familia( persona(jose, benitez, fecha(3, septiembre, 1958), trabajo(profesor, 2000)),
         persona(aurora, carvajal, fecha(29, agosto, 1972), trabajo(maestra, 1900)),
         [ persona(jorge, benitez, fecha(6, noviembre, 1997), trabajo(desocupado, 0))] ).

familia( persona(jacinto, gil, fecha(7, junio, 1958), trabajo(minero, 1850)),
         persona(guillermina, diaz, fecha(12, enero, 1957), trabajo(sus_labores, 0)),
         [ persona(carla, gil, fecha(1, agosto, 1958), trabajo(oficinista, 1500)),
           persona(amalia, gil, fecha(6, abril, 1962), trabajo(deliniante, 1900)), 
           persona(irene, gil, fecha(3, mayo, 1970), trabajo(estudiante, 0)) ] ).

familia( persona(ismael, ortega, fecha(7, junio, 1966), trabajo(carpintero, 2350)),
         persona(salvadora, diaz, fecha(12, enero, 1968), trabajo(sus_labores, 0)),
         [] ).

familia( persona(pedro, ramirez, fecha(7, junio, 1966), trabajo(en_paro,0)),
         persona(teresa, fuentes, fecha(12, enero, 1968), trabajo(administrativa, 1250)),
         [] ).

%%% PREDICADOS PARA INTERACTUAR CON LA BASE DE DATOS
padre(P) :-
    familia(P, _, _).

madre(P) :-
    familia(_, P, _).

hijo(P) :-
    familia(_, _, Hijos),
    member(P, Hijos).

existe(P) :-
    padre(P).

existe(P) :-
    madre(P).

existe(P) :-
    hijo(P).


f_nacimiento(persona(_, _, Fecha, _), Fecha).


salario(persona(_, _, _, trabajo(_, S)), S).

% Predicado auxiliar para obtener el nombre de una persona
nombre_de_persona(persona(N, _, _, _), N).

%%% CONSULTAS DE EJEMPLO

% a) Nombres de todas las personas
% ?- existe(P), nombre_de_persona(P, Nombre).

% b) Hijos nacidos después de 1980
% ?- hijo(P), f_nacimiento(P, fecha(_, _, Año)), Año > 1980, nombre_de_persona(P, Nombre).

% c) Mujeres empleadas (se consideran las madres)
% ?- madre(P), salario(P, S), S > 0, nombre_de_persona(P, Nombre).

% d) Personas desempleadas (salario 0) nacidas antes de 1960
% ?- existe(P), salario(P, 0), f_nacimiento(P, fecha(_, _, Año)), Año < 1960, nombre_de_persona(P, Nombre).

% e) Personas nacidas después de 1950 con salario entre 800 y 1300 euros
% ?- existe(P), f_nacimiento(P, fecha(_, _, Año)), Año > 1950,
%    salario(P, Sal), Sal >= 800, Sal =< 1300, nombre_de_persona(P, Nombre).