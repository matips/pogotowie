:- module(pogotowie,[wykonaj/0]).

:- dynamic([xpozytywne/2, xnegatywne/2]).

procedura(nagly_stan_zagrozenia_zycia) :-
	problem_to(zatrzymanie_krazenia);
	problem_to(krwiak);
	problem_to(zawal);
	problem_to(tetniak_aorty).

procedura(stan_powazny) :-
	podlega(ppm); 
	problem_to(wstrzasienie_mozgu);
	problem_to(niedroznosc_jelit).

procedura(stan_powazny) :-
	problem_to(hipoglikemia),
	pozytywne(jest, nieprzytomny).
	
procedura(karetka_P) :-
	problem_to(hipoglikemia),
	negatywne(jest, nieprzytomny).
		
procedura(karetka_P) :-
	problem_to(ostre_zapalenie_wyrostka);
	problem_to(k2).

procedura(brak_karetki) :-
	not(chory(zagrozenie_zycia)).
	
procedura(policja) :-
	zdarzenie_to(wypadek_samochodowy). 

procedura(stan_powazny) :-
	chory(nieprzytomny).
	
zdarzenie_to(wypadek_samochodowy) :-
	pozytywne(czy, wypadek_samochodowy).

zdarzenie_to(zachorowanie) :-
	pozytywne(czy, zachorowanie).

zdarzenie_to(pogorszenie) :-
	pozytywne(czy, pogorszenie).


zdarzenie_to(niemedyczne) :-
	negatywne(czy, wypadek_samochodowy),
	negatywne(czy, zachorowanie),
	negatywne(czy, pogorszenie),
	negatywne(czy, pogorszenie).

chory(doznal_urazu) :-
	zdarzenie_to(wypadek_samochodowy);
	pozytywne(doznal, urazu). 
	
chory(nieprzytomny) :-
	negatywne(reaguje, na_probe_kontaktu),
	negatywne(reaguje, na_bodzce_dotykowe).

chory(zagrozenie_zycia) :-
	chory(nieprzytomy),
	pozytywne(odczuwa, nietypowe_dolegliwosci).

chory(krawienie_podpajeczynowkowe) :-
	pozytywne(odczuwa, bol_glowy),
	pozytywne(odczuwa, najsilniejszy_bol_glowy_w_zyciu).

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
	negatywne(ma, zaburzenia_swiadomosci), 
	negatywne(ma, zaburzenia_motoryczne). 
	
problem_to(krwiak) :-
	pozytywne(odczuwa, bol_glowy), 
	pozytywne(doznal, urazu), 
	pozytywne(odczuwa, ostry_bol), 
	pozytywne(ma, zaburzenia_swiadomosci), 
	pozytywne(ma, zaburzenia_motoryczne). 

problem_to(zawal) :-
	negatywne(doznal, urazu), 
	pozytywne(odczuwa, bol_klatki), 
	pozytywne(odczuwa, bol_promieniujacy),
	pozytywne(odczuwa, dusznosci).
	
	
problem_to(nadcisienie_tetnicze) :-
	negatywne(doznal, urazu), 
	pozytywne(odczuwa, bol_glowy). 
	
problem_to(zapalenie_zatok) :-
	negatywne(doznal, urazu), 
	pozytywne(odczuwa, bol_glowy).
	
problem_to(migrena) :-
	negatywne(doznal, urazu), 
	pozytywne(odczuwa, bol_glowy).
	
problem_to(zapalenie_opon) :-
	negatywne(doznal, urazu), 
	pozytywne(bol_glowy). 
	
problem_to(hipoglikemia) :-
	pozytywne(ma, cukrzyce),
	pozytywne(odczuwa, oslabienie),
	pozytywne(odczuwa, nudnosci),
	pozytywne(odczuwa, dreszcze),
	pozytywne(ma, wilgotna_blada_skore).
	
problem_to(ostre_zapalenie_wyrostka) :-
	pozytywne(odczuwa, bol_brzucha),
	pozytywne(odczuwa, ostry_bol),
	pozytywne(czuje_bol_umiejscowiony, po_prawej_stronie),
	pozytywne(czuje_bol_trwajacy_przez, kilka_godzin),
	pozytywne(ma, goraczke).

problem_to(tetniak_aorty) :-
	pozytywne(odczuwa, bol_brzucha),
	pozytywne(odczuwa, ostry_bol),
	pozytywne(czuje_bol_umiejscowiony, w_okolicy_krzyzowej),
	pozytywne(ma, ponad_50_lat).
	
problem_to(niedroznosc_jelit) :-
	pozytywne(odczuwa, bol_brzucha),
	pozytywne(ma, wymioty),
	pozytywne(ma_wymioty, o_zolto_zielonej_tresci).
	
problem_to(niezdiagnozowane_dolegliwosci_zoladkowe) :-
	pozytywne(odczuwa, bol_brzucha),
	not(problem_to(ostre_zapalenie_wyrostka)),
	not(problem_to(tetniak_aorty)),
	not(problem_to(niedroznosc_jelit)),
	negatywne(doznal, urazu).

% ogolne kryteria po wieku pacjenta	
problem_to(zawal) :-
	problem_to(niezdiagnozowane_dolegliwosci_zoladkowe),
	(pozytywne(jest, mezczyzna_po_35_roku_zycia);
	pozytywne(jest, kobieta_po_12_roku_zycia)),
	pozytywne(odczuwa, bol_klatki).

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






















