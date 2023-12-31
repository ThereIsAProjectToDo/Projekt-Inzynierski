--
-- PostgreSQL database dump
--

-- Dumped from database version 16.1
-- Dumped by pg_dump version 16.1

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: autorzy; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.autorzy (
    autor_id integer NOT NULL,
    imie character varying(255) NOT NULL,
    nazwisko character varying(255) NOT NULL
);


ALTER TABLE public.autorzy OWNER TO postgres;

--
-- Name: autorzy_autor_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.autorzy_autor_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.autorzy_autor_id_seq OWNER TO postgres;

--
-- Name: autorzy_autor_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.autorzy_autor_id_seq OWNED BY public.autorzy.autor_id;


--
-- Name: klienci; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.klienci (
    klient_id integer NOT NULL,
    konto_id integer,
    imie character varying(50) NOT NULL,
    nazwisko character varying(50),
    telefon integer,
    adres character varying(255)
);


ALTER TABLE public.klienci OWNER TO postgres;

--
-- Name: klienci_klient_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.klienci_klient_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.klienci_klient_id_seq OWNER TO postgres;

--
-- Name: klienci_klient_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.klienci_klient_id_seq OWNED BY public.klienci.klient_id;


--
-- Name: konta; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.konta (
    konto_id integer NOT NULL,
    email character varying(255),
    haslo character varying(255),
    data_utworzenia timestamp(0) without time zone NOT NULL,
    status_konta character varying(50)
);


ALTER TABLE public.konta OWNER TO postgres;

--
-- Name: konta_konto_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.konta_konto_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.konta_konto_id_seq OWNER TO postgres;

--
-- Name: konta_konto_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.konta_konto_id_seq OWNED BY public.konta.konto_id;


--
-- Name: koszyk; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.koszyk (
    ksiazka_id integer,
    klient_id integer,
    ilosc integer NOT NULL,
    element_id integer NOT NULL,
    data_dodania timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public.koszyk OWNER TO postgres;

--
-- Name: koszyk_element_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.koszyk_element_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.koszyk_element_id_seq OWNER TO postgres;

--
-- Name: koszyk_element_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.koszyk_element_id_seq OWNED BY public.koszyk.element_id;


--
-- Name: ksiazki; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.ksiazki (
    ksiazka_id integer NOT NULL,
    autor_id integer,
    tytul character varying(255) NOT NULL,
    opis text,
    price money NOT NULL,
    kategoria character varying(50),
    rok_wydania integer,
    zdjecie character varying(255)
);


ALTER TABLE public.ksiazki OWNER TO postgres;

--
-- Name: ksiazki_ksiazka_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.ksiazki_ksiazka_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.ksiazki_ksiazka_id_seq OWNER TO postgres;

--
-- Name: ksiazki_ksiazka_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.ksiazki_ksiazka_id_seq OWNED BY public.ksiazki.ksiazka_id;


--
-- Name: opinie; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.opinie (
    opinia_id integer NOT NULL,
    klient_id integer,
    ksiazka_id integer,
    ocena integer NOT NULL,
    ocena_tekst text,
    data_dodania timestamp(0) without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.opinie OWNER TO postgres;

--
-- Name: opinie_opinia_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.opinie_opinia_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.opinie_opinia_id_seq OWNER TO postgres;

--
-- Name: opinie_opinia_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.opinie_opinia_id_seq OWNED BY public.opinie.opinia_id;


--
-- Name: zamowienia; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.zamowienia (
    zamowienie_id integer NOT NULL,
    klient_id integer,
    data_zamowienia timestamp without time zone NOT NULL,
    cena money NOT NULL
);


ALTER TABLE public.zamowienia OWNER TO postgres;

--
-- Name: zamowienia_przedmioty; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.zamowienia_przedmioty (
    ksiazka_id integer,
    zamowienie_id integer,
    ilosc integer NOT NULL,
    cena money NOT NULL
);


ALTER TABLE public.zamowienia_przedmioty OWNER TO postgres;

--
-- Name: zamowienia_zamowienie_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.zamowienia_zamowienie_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.zamowienia_zamowienie_id_seq OWNER TO postgres;

--
-- Name: zamowienia_zamowienie_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.zamowienia_zamowienie_id_seq OWNED BY public.zamowienia.zamowienie_id;


--
-- Name: autorzy autor_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.autorzy ALTER COLUMN autor_id SET DEFAULT nextval('public.autorzy_autor_id_seq'::regclass);


--
-- Name: klienci klient_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.klienci ALTER COLUMN klient_id SET DEFAULT nextval('public.klienci_klient_id_seq'::regclass);


--
-- Name: konta konto_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.konta ALTER COLUMN konto_id SET DEFAULT nextval('public.konta_konto_id_seq'::regclass);


--
-- Name: koszyk element_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.koszyk ALTER COLUMN element_id SET DEFAULT nextval('public.koszyk_element_id_seq'::regclass);


--
-- Name: ksiazki ksiazka_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ksiazki ALTER COLUMN ksiazka_id SET DEFAULT nextval('public.ksiazki_ksiazka_id_seq'::regclass);


--
-- Name: opinie opinia_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.opinie ALTER COLUMN opinia_id SET DEFAULT nextval('public.opinie_opinia_id_seq'::regclass);


--
-- Name: zamowienia zamowienie_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.zamowienia ALTER COLUMN zamowienie_id SET DEFAULT nextval('public.zamowienia_zamowienie_id_seq'::regclass);


--
-- Data for Name: autorzy; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.autorzy (autor_id, imie, nazwisko) FROM stdin;
1	Anna	Kowalska
2	Piotr	Nowak
3	Magdalena	Jankowska
4	Krzysztof	Wójcik
5	Karolina	Michalska
6	Marcin	Lis
7	Monika	Szymańska
8	Tomasz	Kaczmarek
9	Aleksandra	Grabowska
10	Adam	Olszewski
11	Jan	Kowalski
12	Anna	Nowak
13	Piotr	Wiśniewski
14	Katarzyna	Dąbrowska
15	Marek	Lewandowski
16	Agnieszka	Wójcik
17	Michał	Kamiński
18	Magdalena	Kowal
19	Grzegorz	Zieliński
20	Ewa	Szymańska
21	Wojciech	Kozłowski
22	Karolina	Jankowska
23	Tomasz	Wojciechowski
24	Monika	Kwiatkowska
25	Adam	Kaczmarek
26	Natalia	Mazur
27	Krzysztof	Krawczyk
28	Patrycja	Piotrowska
29	Marcin	Grabowski
30	Klaudia	Nowakowska
31	Jakub	Pawlak
32	Joanna	Michalska
33	Mariusz	Zając
34	Aleksandra	Król
35	Rafał	Pająk
36	Kinga	Walczak
37	Bartłomiej	Rutkowski
38	Kamila	Górka
39	Dawid	Olszewski
\.


--
-- Data for Name: klienci; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.klienci (klient_id, konto_id, imie, nazwisko, telefon, adres) FROM stdin;
2	2	Piotr	Nowak	987654321	ul. Testowa 2, 11-111 Kraków
3	3	Magdalena	Jankowska	\N	ul. Inna 3, 22-222 Wrocław
4	4	Krzysztof	Wójcik	555666777	ul. Prosta 4, 33-333 Gdańsk
5	5	Karolina	Michalska	\N	ul. Przypadkowa 5, 44-444 Poznań
6	6	Marcin	Lis	111222333	ul. Losowa 6, 55-555 Łódź
7	7	Monika	Szymańska	999888777	ul. Tamta 7, 66-666 Lublin
8	8	Tomasz	Kaczmarek	\N	ul. Jakaś 8, 77-777 Szczecin
9	9	Aleksandra	Grabowska	444333222	ul. Dowolna 9, 88-888 Katowice
10	10	Adam	Olszewski	777666555	ul. Nieznana 10, 99-999 Białystok
11	11	Jan	Kowalski	123456789	ul. Kwiatowa 1, 00-001 Warszawa
12	12	Anna	Nowak	987654321	ul. Leśna 2, 11-111 Kraków
13	13	Adam	Malinowski	555666777	ul. Słoneczna 3, 22-222 Wrocław
14	14	Ewa	Wójcik	111222333	ul. Główna 4, 33-333 Poznań
15	15	Paweł	Wiśniewski	999888777	ul. Morska 5, 44-444 Gdańsk
16	16	Karolina	Kaczmarek	333444555	ul. Polna 6, 55-555 Łódź
17	17	Michał	Adamczyk	777888999	ul. Boczna 7, 66-666 Katowice
18	18	Natalia	Jankowska	222333444	ul. Podgórna 8, 77-777 Lublin
19	19	Wojciech	Kwiatkowski	888777666	ul. Łąkowa 9, 88-888 Szczecin
20	20	Agnieszka	Czajka	444555666	ul. Rzeczna 10, 99-999 Bydgoszcz
21	21	Kamil	Borkowski	666777888	ul. Nadrzeczna 11, 12-345 Białystok
22	22	Monika	Malicka	111222333	ul. Urocza 12, 23-456 Lublin
23	23	Robert	Nowacki	555666777	ul. Olsztyńska 13, 34-567 Kraków
24	24	Natalia	Pawlak	999888777	ul. Łączna 14, 45-678 Warszawa
25	25	Tomasz	Adamski	333444555	ul. Słodka 15, 56-789 Gdańsk
26	26	Ewa	Nowicka	777888999	ul. Długa 16, 67-890 Poznań
27	27	Marek	Marczak	222333444	ul. Wąska 17, 78-901 Wrocław
28	28	Marta	Wilk	888777666	ul. Krótka 18, 89-012 Katowice
29	29	Piotr	Grabowski	444555666	ul. Równa 19, 90-123 Łódź
35	\N	123	123123	\N	\N
36	\N	123	123	\N	\N
37	\N	123	123	\N	\N
1	1	Anna	Kowalska	123456789	ul. Przykładowa 1, 00-000 Warszawa
\.


--
-- Data for Name: konta; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.konta (konto_id, email, haslo, data_utworzenia, status_konta) FROM stdin;
2	piotr@example.com	silneHaslo567	2023-11-20 22:57:18	Aktywne
3	magda@example.com	tajneHaslo890	2023-11-20 22:57:18	Zablokowane
4	krzysztof@example.com	bezpieczneHaslo123	2023-11-20 22:57:18	Aktywne
5	karolina@example.com	inneHaslo456	2023-11-20 22:57:18	Aktywne
6	marcin@example.com	haslo12345	2023-11-20 22:57:18	Zablokowane
7	monika@example.com	tajne123	2023-11-20 22:57:18	Aktywne
8	tomasz@example.com	silneHaslo789	2023-11-20 22:57:18	Aktywne
9	aleksandra@example.com	noweHaslo012	2023-11-20 22:57:18	Aktywne
10	adam@example.com	bezpieczne123	2023-11-20 22:57:18	Aktywne
11	jan@kowalski.com	haslo123	2023-01-01 12:00:00	Aktywne
12	anna@nowak.com	mojeHaslo	2023-01-02 14:30:00	Aktywne
13	adam@malinowski.pl	trudneHaslo123	2023-01-03 15:45:00	Nieaktywne
14	ewa@wojcik.net	prosteHaslo	2023-01-04 10:20:00	Aktywne
15	pawel@wisniewski.org	szyfrowaneHaslo	2023-01-05 09:15:00	Aktywne
16	karolina@kaczmarek.info	bezpieczneHaslo	2023-01-06 18:30:00	Aktywne
17	michal@adamczyk.edu	tajneHaslo321	2023-01-07 16:40:00	Aktywne
18	natalia@jankowska.biz	mojeHaslo123	2023-01-08 11:05:00	Aktywne
19	wojciech@kwiatkowski.tv	hasloBez123	2023-01-09 13:25:00	Aktywne
20	agnieszka@czajka.co	noweHaslo456	2023-01-10 17:10:00	Nieaktywne
21	kamil@borkowski.eu	tajemniczeHaslo	2023-01-11 08:55:00	Aktywne
22	monika@malicka.name	haslo321	2023-01-12 19:20:00	Aktywne
23	robert@nowacki.space	proste123	2023-01-13 14:15:00	Aktywne
24	natalia@pawlak.store	trudneHaslo	2023-01-14 10:30:00	Nieaktywne
25	tomasz@adamski.gallery	bezpieczne123	2023-01-15 16:00:00	Aktywne
26	ewa@nowicka.cafe	noweHaslo789	2023-01-16 12:45:00	Aktywne
27	marek@marczak.bar	hasloBezpieczne	2023-01-17 18:50:00	Aktywne
28	marta@wilk.pl	mojeNoweHaslo	2023-01-18 11:35:00	Aktywne
29	piotr@grabowski.restaurant	trudneHaslo987	2023-01-19 15:55:00	Aktywne
35	asdasd@asdasd	123	2023-12-27 17:15:08	aktywne
36	asd@das	123	2023-12-27 17:15:13	aktywne
37	asd@das	123	2023-12-27 17:18:47	aktywne
1	anna@example.com	haslo123	2023-11-20 22:57:18	Aktywne
\.


--
-- Data for Name: koszyk; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.koszyk (ksiazka_id, klient_id, ilosc, element_id, data_dodania) FROM stdin;
\.


--
-- Data for Name: ksiazki; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.ksiazki (ksiazka_id, autor_id, tytul, opis, price, kategoria, rok_wydania, zdjecie) FROM stdin;
1	1	Pan Tadeusz	Epopeja narodowa	29,99 zł	Epos	1834	1.jpg
2	2	Dziady	Dramat romantyczny	24,50 zł	Dramat	1823	2.jpg
3	3	Lalka	Obraz społeczeństwa warszawskiego	34,99 zł	Realizm	1890	3.jpg
4	1	Quo Vadis	Powieść historyczna	19,99 zł	Historyczna	1895	4.jpg
5	4	Krzyżacy	Powieść historyczna	27,50 zł	Historyczna	1900	5.jpg
6	5	Wesele	Dramat	22,99 zł	Dramat	1901	6.jpg
7	2	Balladyna	Tragedia	18,75 zł	Tragedia	1839	7.jpg
8	3	Ferdydurke	Powiastka groteskowa	31,50 zł	Groteska	1937	8.jpg
9	4	Solaris	Science fiction	26,99 zł	Science fiction	1961	9.jpg
10	5	Pan Wołodyjowski	Powieść historyczna	28,50 zł	Historyczna	1945	10.jpg
11	1	Ogniem i mieczem	Powieść historyczna	32,25 zł	Historyczna	1884	11.jpg
12	2	Makbet	Tragedia	23,99 zł	Tragedia	1606	12.jpg
13	3	Proces	Powiastka groteskowa	29,50 zł	Groteska	1925	13.jpg
14	4	1984	Dystopia	21,75 zł	Dystopia	1949	14.jpg
15	5	Władca Pierścieni	Fantasy	37,99 zł	Fantasy	1954	15.jpg
16	1	Dżuma	Powieść obyczajowa	24,50 zł	Obyczajowa	1947	16.jpg
17	2	Złodziejka książek	Dramat wojenny	19,99 zł	Wojenny	2005	17.jpg
18	3	Poczekalnia do Piekieł	Fantasy	28,75 zł	Fantasy	1997	18.jpg
19	4	Sklepik z marzeniami	Fantasy	22,99 zł	Fantasy	1993	19.jpg
20	5	Harry Potter i Kamień Filozoficzny	Fantasy	30,50 zł	Fantasy	1997	20.jpg
21	1	Podniebna Odyseja	Niesamowita podróż kosmicznego statku w nieznane zakątki galaktyki.	29,99 zł	Science Fiction	2022	20.jpg
22	2	Tajemniczy Labirynt	Grupa przyjaciół próbuje przejść przez zawiły labirynt pełen niebezpieczeństw.	19,99 zł	Przygodowa	2021	21.jpg
23	3	Skarby Piratów	Poszukiwania ukrytego skarbu na wyspie pełnej zagadek i pułapek.	24,99 zł	Przygodowa	2020	22.jpg
24	4	Szepty Nocy	Thriller o tajemniczych morderstwach w małym miasteczku.	34,99 zł	Thriller	2019	23.jpg
25	5	Kwiaty dla Elizy	Romans o zakazanej miłości w czasach wiktoriańskich.	27,99 zł	Romans	2018	24.jpg
26	1	Podniebna Odyseja	Niesamowita podróż kosmicznego statku w nieznane zakątki galaktyki.	29,99 zł	Science Fiction	2022	25.jpg
27	2	Tajemniczy Labirynt	Grupa przyjaciół próbuje przejść przez zawiły labirynt pełen niebezpieczeństw.	19,99 zł	Przygodowa	2021	26.jpg
28	3	Skarby Piratów	Poszukiwania ukrytego skarbu na wyspie pełnej zagadek i pułapek.	24,99 zł	Przygodowa	2020	27.jpg
29	4	Szepty Nocy	Thriller o tajemniczych morderstwach w małym miasteczku.	34,99 zł	Thriller	2019	28.jpg
30	5	Kwiaty dla Elizy	Romans o zakazanej miłości w czasach wiktoriańskich.	27,99 zł	Romans	2018	29.jpg
31	1	Podniebna Odyseja	Niesamowita podróż kosmicznego statku w nieznane zakątki galaktyki.	29,99 zł	Science Fiction	2022	30.jpg
32	2	Tajemniczy Labirynt	Grupa przyjaciół próbuje przejść przez zawiły labirynt pełen niebezpieczeństw.	19,99 zł	Przygodowa	2021	31.jpg
33	3	Skarby Piratów	Poszukiwania ukrytego skarbu na wyspie pełnej zagadek i pułapek.	24,99 zł	Przygodowa	2020	32.jpg
34	4	Szepty Nocy	Thriller o tajemniczych morderstwach w małym miasteczku.	34,99 zł	Thriller	2019	33.jpg
35	5	Kwiaty dla Elizy	Romans o zakazanej miłości w czasach wiktoriańskich.	27,99 zł	Romans	2018	34.jpg
36	1	Podniebna Odyseja	Niesamowita podróż kosmicznego statku w nieznane zakątki galaktyki.	29,99 zł	Science Fiction	2022	35.jpg
37	2	Tajemniczy Labirynt	Grupa przyjaciół próbuje przejść przez zawiły labirynt pełen niebezpieczeństw.	19,99 zł	Przygodowa	2021	36.jpg
38	3	Skarby Piratów	Poszukiwania ukrytego skarbu na wyspie pełnej zagadek i pułapek.	24,99 zł	Przygodowa	2020	37.jpg
39	4	Szepty Nocy	Thriller o tajemniczych morderstwach w małym miasteczku.	34,99 zł	Thriller	2019	38.jpg
40	5	Kwiaty dla Elizy	Romans o zakazanej miłości w czasach wiktoriańskich.	27,99 zł	Romans	2018	39.jpg
41	1	Niezwykła Przygoda	Wspaniała książka opowiadająca o niezwykłej podróży.	24,99 zł	Przygodowa	2022	40.jpg
42	3	Intrygująca Zagadka	Thriller, który wciągnie cię od pierwszej strony.	29,99 zł	Thriller	2021	41.jpg
43	2	Miłość i Tęsknota	Romans pełen emocji i wzruszających chwil.	19,99 zł	Romans	2020	42.jpg
44	4	Świat Magii	Fantastyczna opowieść o magicznym świecie pełnym tajemnic.	34,99 zł	Fantasy	2019	43.jpg
45	5	Mroczne Korytarze	Kryminalna historia o ściganiu przestępców.	22,99 zł	Kryminał	2018	44.jpg
46	6	Słodki Czas	Urocza powieść obyczajowa o życiu w małym miasteczku.	26,99 zł	Obyczajowa	2017	45.jpg
47	7	Bitwa o Galaktykę	Science fiction z epicką bitwą o przetrwanie galaktyki.	39,99 zł	Science Fiction	2016	46.jpg
48	8	Zaklęty Zamek	Opowieść o zameku pełnym tajemnic i czarów.	31,99 zł	Fantasy	2015	47.jpg
49	9	Przeznaczenie	Historia miłosna przeplatająca losy bohaterów na przestrzeni lat.	28,99 zł	Romans	2014	48.jpg
50	10	Innowacyjne Odkrycie	Naukowa podróż w poszukiwaniu nowych odkryć.	36,99 zł	Naukowa	2013	49.jpg
51	1	Tajemnice Przeszłości	Intrygujący thriller o rozwiązaniu zagadki sprzed lat.	32,99 zł	Thriller	2012	50.jpg
52	3	Czas Wielkich Decyzji	Historia o wyborach, które zmieniły bieg historii.	25,99 zł	Historyczna	2011	51.jpg
53	2	Szepty Lasu	Opowieść fantasy o magicznym lesie i jego tajemnicach.	27,99 zł	Fantasy	2010	52.jpg
54	4	Bezlitosny Świat	Kryminalny thriller o walce o sprawiedliwość w brutalnym świecie.	30,99 zł	Kryminał	2009	53.jpg
55	5	Wojenna Saga	Epicka opowieść o losach bohaterów w czasie wojny.	35,99 zł	Historyczna	2008	54.jpg
56	6	Niebezpieczne Ucieczki	Przygoda pełna niebezpieczeństw i ekscytujących chwil.	23,99 zł	Przygodowa	2007	55.jpg
57	7	Roztańczony Świat	Romans o miłości, marzeniach i tańcu.	26,99 zł	Romans	2006	56.jpg
58	8	Klątwa Złotego Idola	Przygoda w dżungli z tajemniczym złotym idolem.	38,99 zł	Przygodowa	2005	57.jpg
59	9	Nieśmiertelny Czas	Science fiction o czasie, podróżach i nieśmiertelności.	33,99 zł	Science Fiction	2004	58.jpg
60	10	Wędrówka Bohatera	Fantasy o podróży bohatera w świecie pełnym magii.	29,99 zł	Fantasy	2003	59.jpg
61	1	Labirynt Tajemnic	Thriller z intrygującą historią w labiryncie tajemnic.	26,99 zł	Thriller	2022	60.jpg
62	3	Bunt Robotów	Science fiction o buncie sztucznej inteligencji w przyszłości.	32,99 zł	Science Fiction	2021	61.jpg
63	2	Magiczny Portal	Fantasy o odkryciu magicznego portalu prowadzącego do innego świata.	21,99 zł	Fantasy	2020	62.jpg
64	4	Szeptem Przez Czas	Romans o miłości, która przetrwała próbę czasu.	28,99 zł	Romans	2019	63.jpg
65	5	Podwodna Wyprawa	Przygoda w głębinach oceanu pełna niebezpieczeństw.	34,99 zł	Przygodowa	2018	64.jpg
66	6	Zakazane Zaklęcia	Fantasy o zakazanych zaklęciach i ich konsekwencjach.	23,99 zł	Fantasy	2017	65.jpg
67	7	Śladem Złota	Kryminalna historia o poszukiwaniu ukrytego skarbu.	27,99 zł	Kryminał	2016	66.jpg
68	8	Rzeka Czasu	Science fiction o podróży w czasie i zmianie losu.	39,99 zł	Science Fiction	2015	67.jpg
69	9	Bramy Przyszłości	Fantasy o bramach prowadzących do nieznanych światów.	31,99 zł	Fantasy	2014	68.jpg
70	10	Miłość w Wielkim Mieście	Romans o zawiłych relacjach w wielkim mieście.	26,99 zł	Romans	2013	69.jpg
71	1	Ostatni Bastion	Fantasy o obronie ostatniego bastionu przed siłami ciemności.	32,99 zł	Fantasy	2012	70.jpg
72	3	Ucieczka z Więzienia	Thriller o zuchwałej ucieczce z najcięższego więzienia.	25,99 zł	Thriller	2011	71.jpg
73	2	Miłość w Chmurach	Romans o miłości kwitnącej w nieoczekiwanych miejscach.	27,99 zł	Romans	2010	72.jpg
74	4	Tajemniczy Ogród	Przygodowa opowieść o odkryciu tajemniczego ogrodu.	30,99 zł	Przygodowa	2009	73.jpg
75	5	Śladem Dinozaurów	Naukowa ekspedycja w poszukiwaniu śladów prehistorycznych zwierząt.	35,99 zł	Naukowa	2008	74.jpg
76	6	Pamiętnik Czasów Wojny	Historyczna opowieść o życiu podczas wojny.	23,99 zł	Historyczna	2007	75.jpg
77	7	Szepty Nocy	Kryminalna intryga w miasteczku, gdzie nic nie jest takie, jak się wydaje.	26,99 zł	Kryminał	2006	76.jpg
78	8	Mroczne Ulice	Thriller o mrocznych ulicach pełnych sekretów.	38,99 zł	Thriller	2005	77.jpg
79	9	W krainie Marzeń	Fantasy o magicznej krainie, gdzie marzenia się spełniają.	33,99 zł	Fantasy	2004	78.jpg
80	10	Szlak Przeznaczenia	Przygodowa opowieść o podróży szlakiem nieznanego przeznaczenia.	29,99 zł	Przygodowa	2003	79.jpg
81	1	Wędrowiec Czasu	Science fiction o podróży w czasie i odkryciach naukowych.	29,99 zł	Science Fiction	2022	80.jpg
82	2	Niezwykłe Marzenia	Romans o spełnianiu marzeń i miłości, która pokonuje przeciwności.	19,99 zł	Romans	2021	81.jpg
83	3	Ostatni Bohater	Fantasy o ostatnim bohaterze, który musi pokonać ciemne siły.	24,99 zł	Fantasy	2020	82.jpg
84	4	Złota Kraina	Przygodowa opowieść o poszukiwaniu skarbu w tajemniczej krainie.	34,99 zł	Przygodowa	2019	83.jpg
85	5	Kwiaty na Opak	Obyczajowa powieść o zawiłych relacjach międzyludzkich.	27,99 zł	Obyczajowa	2018	84.jpg
86	6	Gwiezdne Wojny	Science fiction o galaktycznej wojnie między dobrem a złem.	39,99 zł	Science Fiction	2017	85.jpg
87	7	Zaklęty Las	Fantasy o zaklętym lesie pełnym magii i tajemnic.	31,99 zł	Fantasy	2016	86.jpg
88	8	Miłość na Fali	Romans osadzony w świecie radia i dźwięków.	26,99 zł	Romans	2015	87.jpg
89	9	Tajemnicza Przestrzeń	Science fiction o tajemniczych zjawiskach w kosmosie.	36,99 zł	Science Fiction	2014	88.jpg
90	10	W Cieniu Piramidy	Przygodowa opowieść o odkrywaniu tajemnic starożytnego Egiptu.	28,99 zł	Przygodowa	2013	89.jpg
91	11	Szeptem Przeszłości	Romans o miłości z przeszłością, która powraca.	32,99 zł	Romans	2012	90.jpg
92	12	Labirynt Skarbów	Przygodowa opowieść o poszukiwaniu ukrytego skarbu w labiryncie.	25,99 zł	Przygodowa	2011	91.jpg
93	13	Krew i Honor	Kryminalny thriller o zdradzie, mściwości i niespodziewanych sojuszach.	27,99 zł	Kryminał	2010	92.jpg
94	14	Niewidzialna Ręka	Thriller o spisku i tajnych organizacjach wpływu.	30,99 zł	Thriller	2009	93.jpg
95	15	Nocne Spotkania	Romans o miłości rozkwitającej w nocnym świetle miasta.	35,99 zł	Romans	2008	94.jpg
96	16	Mroczne Tajemnice	Thriller o mrocznych tajemnicach i zaginięciach.	23,99 zł	Thriller	2007	95.jpg
97	17	Ucieczka z Wyspy	Przygodowa historia o uwięzionych na tajemniczej wyspie.	26,99 zł	Przygodowa	2006	96.jpg
98	18	Światła Miasta	Obyczajowa powieść o życiu w wielkim mieście i jego wyzwaniach.	38,99 zł	Obyczajowa	2005	97.jpg
99	19	Gwiezdna Opera	Science fiction o operze kosmicznej i miłości międzygwiezdnej.	33,99 zł	Science Fiction	2004	98.jpg
100	20	Cienie Zmierzchu	Fantasy o walkach między światłem a ciemnością.	29,99 zł	Fantasy	2003	99.jpg
101	21	Labirynt Marzeń	Przygodowa opowieść o podróży przez labirynt marzeń.	32,99 zł	Przygodowa	2002	100.jpg
102	22	Rok Przemian	Obyczajowa powieść o roku, który zmienił życie bohaterów.	25,99 zł	Obyczajowa	2001	101.jpg
103	23	Bunt Maszyn	Science fiction o buncie maszyn i zagrożeniu dla ludzkości.	27,99 zł	Science Fiction	2000	102.jpg
104	24	Ścieżki Miłości	Romans o rozstaniach i ponownym odnalezieniu drogi do siebie.	30,99 zł	Romans	1999	103.jpg
105	25	Szepty Nocy	Kryminalna intryga w tajemniczym miasteczku, gdzie każdy kryje coś przed światem.	35,99 zł	Kryminał	1998	104.jpg
106	26	Mroczne Labirynty	Thriller o mrocznych labiryntach psychiki ludzkiej.	23,99 zł	Thriller	1997	105.jpg
107	27	Ostatni Smok	Fantasy o ostatnim smoku na świecie i jego niezwykłych przygodach.	26,99 zł	Fantasy	1996	106.jpg
108	28	Róża Czerwona	Romans o miłości, która zakwitła w czasach wielkich przemian społecznych.	38,99 zł	Romans	1995	107.jpg
109	29	Przełomowe Odkrycie	Science fiction o przełomowym odkryciu, które zmieniło losy ludzkości.	33,99 zł	Science Fiction	1994	108.jpg
110	30	Wieża Maga	Fantasy o niezwykłych przygodach młodego maga w świecie magii.	29,99 zł	Fantasy	1993	109.jpg
111	1	Labirynt Tajemnic	Thriller z intrygującą historią w labiryncie tajemnic.	26,99 zł	Thriller	2022	110.jpg
112	3	Bunt Robotów	Science fiction o buncie sztucznej inteligencji w przyszłości.	32,99 zł	Science Fiction	2021	111.jpg
113	2	Magiczny Portal	Fantasy o odkryciu magicznego portalu prowadzącego do innego świata.	21,99 zł	Fantasy	2020	112.jpg
114	4	Szeptem Przez Czas	Romans o miłości, która przetrwała próbę czasu.	28,99 zł	Romans	2019	113.jpg
115	5	Podwodna Wyprawa	Przygoda w głębinach oceanu pełna niebezpieczeństw.	34,99 zł	Przygodowa	2018	114.jpg
116	6	Zakazane Zaklęcia	Fantasy o zakazanych zaklęciach i ich konsekwencjach.	23,99 zł	Fantasy	2017	115.jpg
\.


--
-- Data for Name: opinie; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.opinie (opinia_id, klient_id, ksiazka_id, ocena, ocena_tekst, data_dodania) FROM stdin;
1	1	5	4	Interesująca historia, polecam!	2023-12-28 21:06:33
2	2	12	5	Nie mogłem oderwać się od tej książki, świetne czytanie.	2023-12-28 21:06:33
3	3	7	3	Przeciętna lektura, mogłaby być lepsza.	2023-12-28 21:06:33
4	4	15	2	Słaba książka, nie polecam.	2023-12-28 21:06:33
5	5	2	4	Dobry thriller, trzyma w napięciu.	2023-12-28 21:06:33
6	6	18	5	Jeden z moich ulubionych autorów, świetna książka.	2023-12-28 21:06:33
7	7	10	3	Ciekawa fabuła, ale nieco zbyt skomplikowana.	2023-12-28 21:06:33
8	8	1	4	Klasyczna lektura, zawsze warto przeczytać.	2023-12-28 21:06:33
9	9	14	5	Wciągająca opowieść, nie mogę się doczekać kolejnej części.	2023-12-28 21:06:33
10	10	3	2	Raczej przeciętna, nie przypadła mi do gustu.	2023-12-28 21:06:33
11	11	6	4	Intrygująca fabuła, polecam fanom kryminałów.	2023-12-28 21:06:33
12	12	8	3	Średnia książka, bez większych emocji.	2023-12-28 21:06:33
13	13	11	5	Fantastyczna podróż w świat wyobraźni.	2023-12-28 21:06:33
14	14	17	4	Solidna lektura, dobrze spędzony czas.	2023-12-28 21:06:33
15	15	9	2	Niestety, nie przypadła mi do gustu.	2023-12-28 21:06:33
16	16	4	3	Nieco chaotyczna, ale z ciekawym zakończeniem.	2023-12-28 21:06:33
17	17	16	5	Genialna książka, polecam każdemu miłośnikowi literatury.	2023-12-28 21:06:33
18	18	13	4	Warto przeczytać, choć nie zachwyciła mnie specjalnie.	2023-12-28 21:06:33
19	19	20	3	Średnie czytadło, można znaleźć lepsze.	2023-12-28 21:06:33
20	20	19	2	Zawiodłem się na tej książce, nie polecam.	2023-12-28 21:06:33
21	1	10	4	Wciągająca opowieść, świetne postacie.	2023-12-28 21:06:33
22	2	14	5	Niebanalna historia, polecam dla odmiany.	2023-12-28 21:06:33
23	3	8	3	Przyjemne czytanie, choć momentami przewidywalne.	2023-12-28 21:06:33
24	4	1	2	Słaba książka, nie warta uwagi.	2023-12-28 21:06:33
25	5	12	4	Ciekawy thriller, trzyma w napięciu do końca.	2023-12-28 21:06:33
26	6	6	5	Klasyka gatunku, zdecydowanie warta przeczytania.	2023-12-28 21:06:33
27	7	4	3	Intrygująca fabuła, ale zbyt wolne tempo.	2023-12-28 21:06:33
28	8	19	4	Świetna lektura, polecam każdemu miłośnikowi literatury.	2023-12-28 21:06:33
29	9	17	5	Zachwycająca opowieść, nie mogę się doczekać kolejnej części.	2023-12-28 21:06:33
30	10	5	2	Raczej przeciętna, bez większych emocji.	2023-12-28 21:06:33
31	11	11	4	Fascynująca podróż w świat wyobraźni.	2023-12-28 21:06:33
32	12	3	3	Przyzwoita książka, ale bez większych rewelacji.	2023-12-28 21:06:33
33	13	16	5	Wciągająca historia, świetne zakończenie.	2023-12-28 21:06:33
34	14	2	4	Solidna lektura, dobrze spędzony czas.	2023-12-28 21:06:33
35	15	15	2	Niestety, nie przypadła mi do gustu.	2023-12-28 21:06:33
36	16	7	3	Nieco przewidywalna, ale z interesującymi momentami.	2023-12-28 21:06:33
37	17	9	5	Doskonała książka, trzyma w napięciu do samego końca.	2023-12-28 21:06:33
38	18	13	4	Warto przeczytać, choć brakuje jej głębokości.	2023-12-28 21:06:33
39	19	20	3	Średnie czytadło, można znaleźć lepsze.	2023-12-28 21:06:33
40	20	18	2	Rozczarowująca lektura, nie polecam.	2023-12-28 21:06:33
41	1	4	4	Dodaje komentarz testowy	2023-12-28 21:06:33
42	1	4	5	Kolejny komentarz	2023-12-28 21:06:33
43	1	4	5	Komentarz	2023-12-28 21:08:22
44	1	4	2	komentarz 1	2023-12-28 21:08:29
45	1	4	5	123123	2023-12-30 12:06:45
46	1	4	5	asdasd	2023-12-30 13:22:27
47	1	4	3	asfasf	2023-12-30 13:23:37
48	1	4	3	asdasd	2023-12-30 13:23:50
49	1	4	3	asdasd	2023-12-30 13:24:49
50	1	4	3	44424	2023-12-30 13:24:59
51	1	4	5	 ererytyert	2023-12-30 13:26:00
52	1	4	2	afsfasfas	2023-12-30 13:31:12
53	1	4	3	asdasdasd	2023-12-30 13:33:19
54	1	4	4	asd	2023-12-30 13:57:51
55	1	4	4	asdas	2023-12-30 13:58:00
56	1	4	5	3	2023-12-30 14:34:00
57	1	1	2	Dobra to łagodniejszy komentarz	2023-12-30 19:27:58
\.


--
-- Data for Name: zamowienia; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.zamowienia (zamowienie_id, klient_id, data_zamowienia, cena) FROM stdin;
1	1	2023-12-30 17:53:18.672619	120,98 zł
2	1	2023-12-30 19:35:46.882038	44,49 zł
3	1	2023-12-30 19:55:48.510814	64,98 zł
4	1	2023-12-30 19:57:32.734317	81,24 zł
5	1	2023-12-30 21:22:55.706787	83,99 zł
6	1	2023-12-30 21:38:53.599973	277,46 zł
7	1	2023-12-31 12:41:43.229607	24,50 zł
\.


--
-- Data for Name: zamowienia_przedmioty; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.zamowienia_przedmioty (ksiazka_id, zamowienie_id, ilosc, cena) FROM stdin;
1	1	29	34,99 zł
1	1	30	31,50 zł
1	1	31	24,50 zł
1	1	32	29,99 zł
1	2	33	24,50 zł
1	2	34	19,99 zł
1	3	35	29,99 zł
1	3	36	34,99 zł
3	4	37	34,99 zł
7	4	38	18,75 zł
5	4	39	27,50 zł
2	5	40	24,50 zł
2	5	41	24,50 zł
3	5	42	34,99 zł
3	6	43	34,99 zł
5	6	44	27,50 zł
2	7	45	24,50 zł
\.


--
-- Name: autorzy_autor_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.autorzy_autor_id_seq', 39, true);


--
-- Name: klienci_klient_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.klienci_klient_id_seq', 29, true);


--
-- Name: konta_konto_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.konta_konto_id_seq', 37, true);


--
-- Name: koszyk_element_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.koszyk_element_id_seq', 45, true);


--
-- Name: ksiazki_ksiazka_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.ksiazki_ksiazka_id_seq', 116, true);


--
-- Name: opinie_opinia_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.opinie_opinia_id_seq', 57, true);


--
-- Name: zamowienia_zamowienie_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.zamowienia_zamowienie_id_seq', 7, true);


--
-- Name: autorzy autorzy_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.autorzy
    ADD CONSTRAINT autorzy_pkey PRIMARY KEY (autor_id);


--
-- Name: klienci klienci_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.klienci
    ADD CONSTRAINT klienci_pkey PRIMARY KEY (klient_id);


--
-- Name: konta konta_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.konta
    ADD CONSTRAINT konta_pkey PRIMARY KEY (konto_id);


--
-- Name: koszyk koszyk_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.koszyk
    ADD CONSTRAINT koszyk_pkey PRIMARY KEY (element_id);


--
-- Name: ksiazki ksiazki_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ksiazki
    ADD CONSTRAINT ksiazki_pkey PRIMARY KEY (ksiazka_id);


--
-- Name: opinie opinie_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.opinie
    ADD CONSTRAINT opinie_pkey PRIMARY KEY (opinia_id);


--
-- Name: zamowienia zamowienia_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.zamowienia
    ADD CONSTRAINT zamowienia_pkey PRIMARY KEY (zamowienie_id);


--
-- Name: klienci klienci_konto_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.klienci
    ADD CONSTRAINT klienci_konto_id_fkey FOREIGN KEY (konto_id) REFERENCES public.konta(konto_id) ON DELETE CASCADE;


--
-- Name: koszyk koszyk_klient_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.koszyk
    ADD CONSTRAINT koszyk_klient_id_fkey FOREIGN KEY (klient_id) REFERENCES public.klienci(klient_id) ON DELETE CASCADE;


--
-- Name: koszyk koszyk_ksiazka_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.koszyk
    ADD CONSTRAINT koszyk_ksiazka_id_fkey FOREIGN KEY (ksiazka_id) REFERENCES public.ksiazki(ksiazka_id) ON DELETE CASCADE;


--
-- Name: ksiazki ksiazki_autor_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ksiazki
    ADD CONSTRAINT ksiazki_autor_id_fkey FOREIGN KEY (autor_id) REFERENCES public.autorzy(autor_id) ON DELETE CASCADE;


--
-- Name: opinie opinie_klient_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.opinie
    ADD CONSTRAINT opinie_klient_id_fkey FOREIGN KEY (klient_id) REFERENCES public.klienci(klient_id) ON DELETE CASCADE;


--
-- Name: opinie opinie_ksiazka_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.opinie
    ADD CONSTRAINT opinie_ksiazka_id_fkey FOREIGN KEY (ksiazka_id) REFERENCES public.ksiazki(ksiazka_id) ON DELETE CASCADE;


--
-- Name: zamowienia zamowienia_klient_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.zamowienia
    ADD CONSTRAINT zamowienia_klient_id_fkey FOREIGN KEY (klient_id) REFERENCES public.klienci(klient_id) ON DELETE CASCADE;


--
-- Name: zamowienia_przedmioty zamowienia_przedmioty_ksiazka_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.zamowienia_przedmioty
    ADD CONSTRAINT zamowienia_przedmioty_ksiazka_id_fkey FOREIGN KEY (ksiazka_id) REFERENCES public.ksiazki(ksiazka_id) ON DELETE CASCADE;


--
-- Name: zamowienia_przedmioty zamowienia_przedmioty_zamowienie_id_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.zamowienia_przedmioty
    ADD CONSTRAINT zamowienia_przedmioty_zamowienie_id_id_fkey FOREIGN KEY (zamowienie_id) REFERENCES public.zamowienia(zamowienie_id) ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--

