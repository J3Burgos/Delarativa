%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%                        PROLOG PURO                                %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% biblia2.p
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% HECHOS
	hombre(teraj).
	hombre(abraham).
	hombre(najor).
	hombre(haran).
	hombre(lot).
	hombre(batuel).
	hombre(ismael).
	hombre(laban).
	hombre(isaac).
	hombre(esau).
	hombre(jacob).
		
	mujer(sara).
	mujer(melca).
	mujer(jesca).
	mujer(agar).
	mujer(rebeca).
		
	esclava(agar).
		
	padre(teraj, abraham).
	padre(teraj, najor).
	padre(teraj, haran).
	padre(teraj, sara).
	padre(haran, lot).
	padre(haran, melca).
	padre(haran, jesca).
	padre(najor, batuel).
	padre(batuel, rebeca).
	padre(batuel, laban).
	padre(abraham,ismael).		
	padre(abraham, isaac).
	padre(isaac, esau).
	padre(isaac, jacob).
		
	madre(agar, ismael).
	madre(sara, isaac).
	madre(melca, batuel).
	madre(rebeca, esau).
	madre(rebeca, jacob).
		
	casado(abraham, sara).
	casado(najor, melca).
	casado(isaac, rebeca).
		
% REGLAS
	casados(X, Y) :- (casado(X, Y); casado(Y,X)).
	ascendiente_directo(X, Y) :- (padre(X, Y); madre(X, Y)).
	abuelo(X, Z) :- padre(X, Y), ascendiente_directo(Y, Z).
	abuela(X, Z) :- madre(X, Y), ascendiente_directo(Y, Z).
	
	nieto(X, Y) :- hombre(X), (abuelo(Y, X); abuela(Y, X)).
	nieta(X, Y) :- mujer(X), (abuelo(Y, X); abuela(Y, X)).
	ascendiente(X, Z) :- ascendiente_directo(X, Z).
	ascendiente(X, Z) :- ascendiente_directo(X, Y), ascendiente(Y, Z).
	
	hijo(X,Y) :- hombre(X), ascendiente_directo(Y,X).
	hija(X,Y) :- mujer(X), ascendiente_directo(Y,X).
	
	hermano(X,Y) :- hombre(X), ascendiente_directo(Z,X), 
				ascendiente_directo(Z,Y), X \== Y.
	hermana(X,Y) :- mujer(X), ascendiente_directo(Z,X), 
				ascendiente_directo(Z,Y), X \== Y.
	
	hermanos(X, Y) :- (hermano(X, Y); hermana(X, Y)).
	
	descendiente_directo(X, Y) :- (hijo(X,Y); hija(X,Y)).
	descendiente(X, Z) :- descendiente_directo(X, Z).
	descendiente(X, Z) :- descendiente_directo(X, Y), descendiente(Y, Z).
	
	tio_carnal(X, Y) :- hombre(X), hermano(X, Z), ascendiente_directo(Z, Y), X \== Y.
	tia_carnal(X, Y) :- mujer(X), hermana(X, Z), ascendiente_directo(Z, Y), X \== Y.
	tio_no_carnal(X, Y) :- hombre(X), casado(X, Z), hermana(Z, W), 
				ascendiente_directo(W, Y), X \== Y.
	tia_no_carnal(X, Y) :- mujer(X), casado(Z, X), hermano(Z, W), 
				ascendiente_directo(W, Y), X \== Y.
	
	tio(X, Y) :- (tio_carnal(X, Y); tio_no_carnal(X, Y)).
	tia(X, Y) :- (tia_carnal(X, Y); tia_no_carnal(X, Y)).
	
	sobrino(X, Y) :- hombre(X), (tio(Y, X); tia(Y, X)), X \== Y.
	sobrina(X, Y) :- mujer(X), (tio(Y, X); tia(Y, X)), X \== Y.
	
	primo(X, Y) :- hombre(X), ascendiente_directo(Z1, X), 
	               ascendiente_directo(Z2, Y), hermanos(Z1, Z2), X \== Y.
	prima(X, Y) :- mujer(X), ascendiente_directo(Z1, X), 
	               ascendiente_directo(Z2, Y), hermanos(Z1, Z2), X \== Y.
	
	primos(X, Y) :- (primo(X, Y); prima(X, Y)).
	
/*	incestuosos(X, Y) :- casados(X, Y), (hermanos(X, Y); primos(X, Y); 
	                 ascendiente_directo(X,Y); descendiente_directo(X,Y);
			 abuelo(X, Y); nieto(X, Y); abuela(X, Y); nieta(X, Y);
			 tio(X, Y); tia(X, Y); sobrino(X, Y); sobrina(X, Y)). */
	incestuosos(X, Y) :- hombre(X), mujer(Y), casado(X, Y), 
			     (hermano(X, Y); primo(X, Y); 
	                      padre(X,Y); hijo(X,Y); abuelo(X, Y); nieto(X, Y); 
			      tio(X, Y);  sobrino(X, Y)).
	

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Ejercicio 7. % 6 puntos
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
/* 1) Una base de datos puede representarse de forma natural en PROLOG  como 
un conjunto de hechos. Por ejemplo, la información sobre una familia puede 
estructurarse como:
familia( persona(antonio, foix, fecha(7, mayo, 1950), trabajo(renfe, 180000)),
	persona(maria, lopez, fecha(17, enero, 1952), trabajo(sus_labores, 0)),
	[ persona(patricia, foix, fecha(10, noviembre, 1970), trabajo(estudiante, 0)),
	  persona(juan, foix, fecha(30, agosto, 1972), trabajo(estudiante,0)) ] ).
Que nos indica que una familia está formada por personas: el padre la madre  y una 
lista de hijos. Cada persona, a su vez, está representada por una estructura de cuatro 
componentes: nombre, apellido, fecha de nacimiento y trabajo que desempeña.
Si representamos la información mediante estructuras, una propiedad agradable de PROLOG 
y su mecanismo de unificación es que podemos recuperar información de la base de datos 
mediante la formulación de objetivos en los que sus componentes no están completamente 
instanciados. Por ejemplo, el objetivo
	?- familia( persona(_, foix, _, _), _, _).
recupera la información sobre la familia Foix, más aun,
	?- familia( _, _, _).
recupera la información sobre todas las familias en la base de datos.
Ampliar la base de datos */
familia( persona(antonio, foix, fecha(7, mayo, 1950), trabajo(renfe, 1800)),
	persona(maria, lopez, fecha(17, enero, 1952), trabajo(sus_labores, 0)),
	[ persona(patricia, foix, fecha(10, noviembre, 1970), trabajo(estudiante, 0)),
	  persona(juan, foix, fecha(30, agosto, 1972), trabajo(estudiante,0)) ] ).
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
	
/* y responder a las siguientes preguntas: */
/* a) encontrar los nombres y apellidos de las madrees casadas que tienen tres o más hijos; */
ej2a(Nombre, Apellido) :- nl, write('madrees casadas que tienen tres o más hijos:'), nl,
   familia( _, persona(Nombre, Apellido, _, _), [ _, _, _ | _ ]).

/* b) encontrar los nombres de las familias que no tienen hijos; */
ej2b(Apellidos_Padre, Apellidos_Madre):- nl, write('Familias que no tienen hijos:'), nl,
   familia( persona(_, Apellidos_Padre, _, _), persona(_, Apellidos_Madre, _, _), []).

/* c) nombres de las familias en las que la madre trabaja pero el padre no. */
ej2c(Apellidos_Padre, Apellidos_Madre):- nl, write('Familias en las que la madre trabaja pero el padre no:'), nl,
   familia( persona(_, Apellidos_Padre, _, trabajo(en_paro, _)), persona(_, Apellidos_Madre, _, trabajo(_, S)), _ ),
   S > 0.



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Ejercicio 8. % 10 puntos
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

/* 2) Utilizar la base de datos de la anterior forma supone que el usuario sea 
conocedor de la estructura interna de la representación. Para paliar esta situación,
definir una serie de procedimientos que facilite la interacción con la base de datos: */

% padre(P) 	P es un hombre casado. Queremos que P se instancie con los datos 
%               de la primera persona de la familia;
padre(P) :- familia( P, _, _).

% madre(P) 	Idem. respecto a la madre;
madre(P) :- familia( _, P, _).
% hijo(P)	Idem. respecto de los hijos;
hijo(P) :- familia( _, _, Hijos), member(P, Hijos).
% existe(P)	P es una persona que está en la base de datos;
existe(P) :- padre(P); madre(P); hijo(P).
% f_nacimiento(P, F)	F es la fecha de nacimiento de la persona P;
f_nacimiento(P, F) :- existe(P), P = persona(_, _, F, _).
% salario(P, S)	S es el salario de la persona P.
salario(P, S) :- existe(P), P = persona(_, _, _, trabajo(_, S)).

/* Una vez definidos los anteriores predicados y relaciones, contestar a las 
siguientes preguntas (formulando los objetivos correspondientes): */

% a) Encontrar los nombres de todas las personas en la base de datos;

ej3a(Nombre, Apellido):- nl, write('Nombres de todas las personas en la base de datos:'), nl,
   existe(persona(Nombre, Apellido, _, _)).

% b) Encontrar los hijos nacidos después de 1980;
ej3b(Nombre, Apellido):- nl, write('Hijos nacidos después de 1980:'), nl,
   hijo(persona(Nombre, Apellido, fecha(_, _, A), _)), A > 1980.

% c) Encontrar todas las esposas empleadas;
ej3c(Nombre, Apellido):- nl, write('Esposas empleadas:'), nl,
   madre(persona(Nombre, Apellido, _, trabajo(_, S))), S > 0.

% d) Encontrar los nombres de las personas desempleadas nacidas antes de 1960;
ej3d(Nombre, Apellido):- nl, write('Personas desempleadas nacidas antes de 1960:'), nl,
   existe(persona(Nombre, Apellido, fecha(_, _, A), trabajo(T, _))), A < 1960, member(T,[desocupado, en_paro]).

% e) Encontrar las personas nacidas después de 1950 cuyo salario esté comprendido 
% entre las 800 y las 1300 euros.
ej3e(Nombre, Apellido):- nl, write('Personas nacidas después de 1950, salario entre las 800 y las 1300 euros:'), nl,
   existe(persona(Nombre, Apellido, fecha(_, _, A), trabajo(_, S))), 
   		 A > 1950, S >= 800, S =< 1300.
% f) otra posibilidad
ej3f(Nombre, Apellido):- nl, write('Personas nacidas después de 1950, salario entre las 800 y las 1300 euros:'), nl,
   salario(persona(Nombre, Apellido, fecha(_, _, A), _), S), 
   		 A > 1950, S >= 800, S =< 1300.
