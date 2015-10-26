:- module(pogotowie,[wykonaj/0]).

:- dynamic([xpozytywne/2, xnegatywne/2]).

procedura(nagly_stan_zagrozenia_zycia) :-
	problem_to(zatrzymanie_krazenia);
	problem_to(krwiak);
	problem_to(zawal).

procedura(stan_powazny) :-
	podlega(ppm); 
	problem_to(wstrzasienie_mozgu).

% procedura(karetka_P).
procedura(brak_karetki) :-
	not(chory(zagrozenie_zycia)).
	
% procedura(consulting).
procedura(policja) -:
	zdarzenie_to(wypadek_samochodowy). 
	
% procerura(straz).

zdarzenie_to(wypadek_samochodowy) :-
	pozytywne(czy, wypadek_samochodowy).

zdarzenie_to(zachrowanie) :-
	pozytywne(czy, zachorowanie).

zdarzenie_to(pogorszenie) :-
	pozytywne(czy, pogorszenie).


zdarzenie_to(niemedyczne) :-
	negatywne(czy, wypadek_samochodowy),
	negatywne(czy, zachorowanie),
	negatywne(czy, pogorszenie),
	negatywne(czy, pogorszenie).

chory(nieprzytomny) :-
	negatywne(reaguje, na_probe_kontaktu),
	negatywne(reaguje, na_bodzce_dotykowe).

chory(zagrozenie_zycia) :-
	chory(nieprzytomy),
	pozytywne(odczuwa, nietypwe_dolegliwosci).


problem_to(zatrzymanie_krazenia) :-
	chory(nieprzytomny),
	negatywne(czy, oddycha).

problem_to(wstrzasienie_mozgu) :-
	pozytywne(odczuwa, bol_glowy), 
	pozytywne(doznal, urazu), 
	negatywne(odczuwa, ostry_bol), 
	pozytywne(odczuwa, nudnosci). 
	
problem_to(k2) :-
	pozytywne(odczuwa, bol_glowy), 
	negatywne(doznal, urazu), 
	negatywne(ma, zabuzenia_swiadomosci), 
	negatywne(ma, zabuzenia_motoryczne). 
	
problem_to(krwiak) :-
	pozytywne(odczuwa, bol_glowy), 
	pozytywne(doznal, urazu), 
	pozytywne(odczuwa, ostry_bol), 
	pozytywne(ma, zabuzenia_swiadomosci), 
	pozytywne(ma, zabuzenia_motoryczne). 

problem_to(zawal) :-
	negatywne(doznal, urazu), 
	pozytywne(odczuwa, bol_klatki), 
	pozytywne(odczuwa, bol_promieniujacy)
	pozytywne(oddczuwa, dusznosci)
	
podlega(ppm) :-
	zdarzenie_to(wypadek_samochodowy).

podlega(ppm) :-
	zdarzenie_to(zachorowanie).

podlega(ppm) :-
	zdarzenie_to(pogorszenie).
	
	
	
	
pozytywne(X, Y) :-
	xpozytywne(X, Y), !.

pozytywne(X, Y) :-
	not(xnegatywne(X, Y)),
	pytaj(X, Y, tak).

negatywne(X, Y) :-
	xnegatywne(X, Y), !.

negatywne(X, Y) :-
	not(xpozytywne(X, Y)),
	pytaj(X, Y, nie).

pytaj(X, Y, tak) :-
	!, write('Czy chory '), write(X), write(" "), write(Y), write(' ? (t/n)\n'), 
	readln([Replay]),
	pamietaj(X, Y, Replay),
	odpowiedz(Replay, tak).


pytaj(X, Y, nie) :-
	!, write('Czy chory '), write(X), write(" "), write(Y), write(' ? (t/n)\n'), 
	readln([Replay]),
	pamietaj(X, Y, Replay),
	odpowiedz(Replay, nie).

odpowiedz(Replay, tak):-
	sub_string(Replay, 0, _, _, 't').

odpowiedz(Replay, nie):-
	sub_string(Replay, 0, _, _, 'n').

pamietaj(X, Y, Replay) :-
	odpowiedz(Replay, tak),
	assertz(xpozytywne(X, Y)).

pamietaj(X, Y, Replay) :-
	odpowiedz(Replay, nie),
	assertz(xnegatywne(X, Y)).

wyczysc_fakty :-
	write('\n\nNacisnij enter aby zakonczyc\n'),
	retractall(xpozytywne(_, _)),
	retractall(xnegatywne(_, _)),
	readln(_).

wykonaj :-
	procedura(X), !,
	write('Nalezy zastosowac procedure: '), write(X), nl,
	wyczysc_fakty.

wykonaj :-
	write('\nNie jestem w stanie odgadnac, '),
	write('jakie zwierze masz na mysli.\n\n'), wyczysc_fakty.






















