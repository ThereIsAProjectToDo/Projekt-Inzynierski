CREATE TABLE konta(
    konto_id SERIAL PRIMARY KEY,
    email VARCHAR(255) NOT NULL,
    haslo VARCHAR(255) NOT NULL,
    data_utworzenia TIMESTAMP(0) DEFAULT CURRENT_TIMESTAMP,
    status_konta VARCHAR(50)
);
CREATE TABLE klienci(
    klient_id SERIAL PRIMARY KEY,
    konto_id INTEGER REFERENCES konta(konto_id) ON DELETE CASCADE,
    imie VARCHAR(50) NOT NULL,
    nazwisko VARCHAR(50),
    telefon INTEGER,
    adres VARCHAR(255)
);
CREATE TABLE autorzy(
    autor_id SERIAL PRIMARY KEY,
    imie VARCHAR(255) NOT NULL,
    nazwisko VARCHAR(255) NOT NULL
);
CREATE TABLE ksiazki(
    ksiazka_id SERIAL PRIMARY KEY,
    autor_id INTEGER REFERENCES autorzy(autor_id) ON DELETE CASCADE,
    tytul VARCHAR(255) NOT NULL,
    opis TEXT,
    price MONEY NOT NULL,
    kategoria VARCHAR(50),
    rok_wydania INTEGER,
    zdjecie varchar(255)
);
CREATE TABLE zamowienia(
    zamowienie_id SERIAL PRIMARY KEY,
    klient_id INTEGER REFERENCES klienci(klient_id) ON DELETE CASCADE,
    data_zamowienia TIMESTAMP NOT NULL,
    cena MONEY NOT NULL
);
CREATE TABLE zamowienia_przedmioty(
    ksiazka_id INTEGER REFERENCES ksiazki(ksiazka_id) ON DELETE CASCADE,
    zamowienie_id_id INTEGER REFERENCES zamowienia(zamowienie_id) ON DELETE CASCADE,
    ilosc INTEGER NOT NULL,
    cena MONEY NOT NULL
);
CREATE TABLE opinie(
    opinia_id SERIAL PRIMARY KEY,
    klient_id INTEGER REFERENCES klienci(klient_id) ON DELETE CASCADE,
    ksiazka_id INTEGER REFERENCES ksiazka(ksiazka_id) ON DELETE CASCADE,
    ocena INTEGER NOT NULL,
    ocena_tekst TEXT,
    data_dodania TIMESTAMP(0) DEFAULT CURRENT_TIMESTAMP
)
CREATE TABLE koszyk(
    element_id SERIAL PRIMARY KEY,
    ksiazka_id INTEGER REFERENCES ksiazki(ksiazka_id) ON DELETE CASCADE,
    klient_id INTEGER REFERENCES klienci(klient_id) ON DELETE CASCADE,
    ilosc INTEGER NOT NULL,
    data_dodania TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
)


RECORDS
INSERT INTO opinie (klient_id, ksiazka_id, ocena, ocena_tekst) VALUES
  (5, 4,4,'Interesująca historia, polecam!'),
  (2, 12, 5, 'Nie mogłem oderwać się od tej książki, świetne czytanie.'),
  (3, 7, 3, 'Przeciętna lektura, mogłaby być lepsza.'),
  (4, 15, 2, 'Słaba książka, nie polecam.'),
  (5, 2, 4, 'Dobry thriller, trzyma w napięciu.'),
  (6, 18, 5, 'Jeden z moich ulubionych autorów, świetna książka.'),
  (7, 10, 3, 'Ciekawa fabuła, ale nieco zbyt skomplikowana.'),
  (8, 1, 4, 'Klasyczna lektura, zawsze warto przeczytać.'),
  (9, 14, 5, 'Wciągająca opowieść, nie mogę się doczekać kolejnej części.'),
  (10, 3, 2, 'Raczej przeciętna, nie przypadła mi do gustu.'),
  (3, 6, 4, 'Intrygująca fabuła, polecam fanom kryminałów.'),
  (32, 3,3, 'Średnia książka, bez większych emocji.'),
  (31, 11, 5, 'Fantastyczna podróż w świat wyobraźni.'),
  (34, 17, 4, 'Solidna lektura, dobrze spędzony czas.'),
  (35, 9, 2, 'Niestety, nie przypadła mi do gustu.'),
  (36, 4, 3, 'Nieco chaotyczna, ale z ciekawym zakończeniem.'),
  (37, 16, 5, 'Genialna książka, polecam każdemu miłośnikowi literatury.'),
  (38, 13, 4, 'Warto przeczytać, choć nie zachwyciła mnie specjalnie.'),
  (39, 20, 3, 'Średnie czytadło, można znaleźć lepsze.'),
  (31, 19, 2, 'Zawiodłem się na tej książce, nie polecam.'),
  (1, 10, 4, 'Wciągająca opowieść, świetne postacie.'),
  (2, 14, 5, 'Niebanalna historia, polecam dla odmiany.'),
  (3, 8, 3, 'Przyjemne czytanie, choć momentami przewidywalne.'),
  (4, 1, 2, 'Słaba książka, nie warta uwagi.'),
  (5, 12, 4, 'Ciekawy thriller, trzyma w napięciu do końca.'),
  (6, 6, 5, 'Klasyka gatunku, zdecydowanie warta przeczytania.'),
  (7, 4, 3, 'Intrygująca fabuła, ale zbyt wolne tempo.'),
  (8, 19, 4, 'Świetna lektura, polecam każdemu miłośnikowi literatury.'),
  (9, 17, 5, 'Zachwycająca opowieść, nie mogę się doczekać kolejnej części.'),
  (32, 5, 2, 'Raczej przeciętna, bez większych emocji.'),
  (31, 11, 4, 'Fascynująca podróż w świat wyobraźni.'),
  (32, 3, 3, 'Przyzwoita książka, ale bez większych rewelacji.'),
  (33, 16, 5, 'Wciągająca historia, świetne zakończenie.'),
  (34, 2, 4, 'Solidna lektura, dobrze spędzony czas.'),
  (35, 15, 2, 'Niestety, nie przypadła mi do gustu.'),
  (36, 7, 3, 'Nieco przewidywalna, ale z interesującymi momentami.'),
  (37, 9, 5, 'Doskonała książka, trzyma w napięciu do samego końca.'),
  (38, 13, 4, 'Warto przeczytać, choć brakuje jej głębokości.'),
  (39, 20, 3, 'Średnie czytadło, można znaleźć lepsze.'),
  (31, 18, 2, 'Rozczarowująca lektura, nie polecam.');
