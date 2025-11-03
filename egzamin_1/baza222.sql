

DROP DATABASE IF EXISTS szkola_pl;
CREATE DATABASE szkola_pl CHARACTER SET utf8mb4 COLLATE utf8mb4_polish_ci;
USE szkola_pl;

-- Tabele
CREATE TABLE klasy (
  id_klasy INT AUTO_INCREMENT PRIMARY KEY,
  nazwa VARCHAR(10) NOT NULL UNIQUE
) ENGINE=InnoDB;

CREATE TABLE uczniowie (
  id_ucznia INT AUTO_INCREMENT PRIMARY KEY,
  imie VARCHAR(50) NOT NULL,
  nazwisko VARCHAR(50) NOT NULL,
  data_urodzenia DATE NULL,
  id_klasy INT NOT NULL,
  CONSTRAINT fk_uczen_klasa FOREIGN KEY (id_klasy) REFERENCES klasy(id_klasy)
    ON UPDATE CASCADE ON DELETE RESTRICT
) ENGINE=InnoDB;

CREATE TABLE przedmioty (
  id_przedmiotu INT AUTO_INCREMENT PRIMARY KEY,
  nazwa VARCHAR(50) NOT NULL UNIQUE
) ENGINE=InnoDB;

CREATE TABLE nauczyciele (
  id_nauczyciela INT AUTO_INCREMENT PRIMARY KEY,
  imie VARCHAR(50) NOT NULL,
  nazwisko VARCHAR(50) NOT NULL
) ENGINE=InnoDB;

-- Zajęcia = powiązanie przedmiotu z klasą i nauczycielem
CREATE TABLE zajecia (
  id_zajec INT AUTO_INCREMENT PRIMARY KEY,
  id_przedmiotu INT NOT NULL,
  id_klasy INT NOT NULL,
  id_nauczyciela INT NOT NULL,
  UNIQUE KEY uk_zajecia (id_przedmiotu, id_klasy),
  CONSTRAINT fk_zaj_przed FOREIGN KEY (id_przedmiotu) REFERENCES przedmioty(id_przedmiotu)
    ON UPDATE CASCADE ON DELETE RESTRICT,
  CONSTRAINT fk_zaj_klasa FOREIGN KEY (id_klasy) REFERENCES klasy(id_klasy)
    ON UPDATE CASCADE ON DELETE RESTRICT,
  CONSTRAINT fk_zaj_nauc FOREIGN KEY (id_nauczyciela) REFERENCES nauczyciele(id_nauczyciela)
    ON UPDATE CASCADE ON DELETE RESTRICT
) ENGINE=InnoDB;

-- Oceny: powiązane z uczniem i z konkretnymi zajęciami (przedmiotem w klasie)
CREATE TABLE oceny (
  id_oceny INT AUTO_INCREMENT PRIMARY KEY,
  id_ucznia INT NOT NULL,
  id_zajec INT NOT NULL,
  ocena DECIMAL(2,1) NOT NULL CHECK (ocena BETWEEN 1.0 AND 6.0),
  data_oceny DATE NOT NULL,
  uwagi VARCHAR(255) NULL,
  CONSTRAINT fk_oc_uczen FOREIGN KEY (id_ucznia) REFERENCES uczniowie(id_ucznia)
    ON UPDATE CASCADE ON DELETE CASCADE,
  CONSTRAINT fk_oc_zaj FOREIGN KEY (id_zajec) REFERENCES zajecia(id_zajec)
    ON UPDATE CASCADE ON DELETE RESTRICT
) ENGINE=InnoDB;

-- Dane przykładowe
INSERT INTO klasy (nazwa) VALUES 
('1A'), ('1B'), ('2A');

INSERT INTO nauczyciele (imie, nazwisko) VALUES
('Monika','Kowalczyk'),
('Piotr','Lewandowski'),
('Agnieszka','Wójcik'),
('Tomasz','Mazur');

INSERT INTO przedmioty (nazwa) VALUES
('Matematyka'),
('Informatyka'),
('Język polski'),
('Język angielski'),
('Historia');

INSERT INTO uczniowie (imie, nazwisko, data_urodzenia, id_klasy) VALUES
('Jan','Kowalski','2009-03-14', 1),
('Anna','Nowak','2009-07-22', 1),
('Piotr','Wiśniewski','2009-11-05', 1),
('Maria','Wójcik','2009-01-18', 1),
('Kacper','Kaczmarek','2009-12-02', 2),
('Zofia','Zielińska','2009-05-27', 2),
('Michał','Szymański','2008-09-09', 2),
('Julia','Dąbrowska','2009-08-30', 2),
('Oliwia','Król','2008-04-11', 3),
('Filip','Wieczorek','2008-06-03', 3),
('Aleksander','Jankowski','2008-10-21', 3),
('Natalia','Piotrowska','2008-12-15', 3);

-- Zajęcia (przypisania: przedmiot + klasa + nauczyciel)
-- 1A
INSERT INTO zajecia (id_przedmiotu, id_klasy, id_nauczyciela) VALUES
((SELECT id_przedmiotu FROM przedmioty WHERE nazwa='Matematyka'), 1, 1),
((SELECT id_przedmiotu FROM przedmioty WHERE nazwa='Informatyka'), 1, 2),
((SELECT id_przedmiotu FROM przedmioty WHERE nazwa='Język polski'), 1, 3),
((SELECT id_przedmiotu FROM przedmioty WHERE nazwa='Język angielski'), 1, 4),
((SELECT id_przedmiotu FROM przedmioty WHERE nazwa='Historia'), 1, 3);
-- 1B
INSERT INTO zajecia (id_przedmiotu, id_klasy, id_nauczyciela) VALUES
((SELECT id_przedmiotu FROM przedmioty WHERE nazwa='Matematyka'), 2, 1),
((SELECT id_przedmiotu FROM przedmioty WHERE nazwa='Informatyka'), 2, 2),
((SELECT id_przedmiotu FROM przedmioty WHERE nazwa='Język polski'), 2, 3),
((SELECT id_przedmiotu FROM przedmioty WHERE nazwa='Język angielski'), 2, 4),
((SELECT id_przedmiotu FROM przedmioty WHERE nazwa='Historia'), 2, 3);
-- 2A
INSERT INTO zajecia (id_przedmiotu, id_klasy, id_nauczyciela) VALUES
((SELECT id_przedmiotu FROM przedmioty WHERE nazwa='Matematyka'), 3, 1),
((SELECT id_przedmiotu FROM przedmioty WHERE nazwa='Informatyka'), 3, 2),
((SELECT id_przedmiotu FROM przedmioty WHERE nazwa='Język polski'), 3, 3),
((SELECT id_przedmiotu FROM przedmioty WHERE nazwa='Język angielski'), 3, 4),
((SELECT id_przedmiotu FROM przedmioty WHERE nazwa='Historia'), 3, 3);

-- Oceny (kilkadziesiąt wpisów, różne przedmioty i klasy)
-- Pomocnicze ID zajec:
-- SELECT id_zajec, p.nazwa, k.nazwa FROM zajecia z JOIN przedmioty p ON z.id_przedmiotu=p.id_przedmiotu JOIN klasy k ON k.id_klasy=z.id_klasy;

-- Oceny klasa 1A (uczniowie 1-4)
INSERT INTO oceny (id_ucznia, id_zajec, ocena, data_oceny, uwagi) VALUES
(1, (SELECT id_zajec FROM zajecia z JOIN przedmioty p ON z.id_przedmiotu=p.id_przedmiotu WHERE z.id_klasy=1 AND p.nazwa='Matematyka'), 4.0, '2025-09-01', 'Sprawdzian 1'),
(1, (SELECT id_zajec FROM zajecia z JOIN przedmioty p ON z.id_przedmiotu=p.id_przedmiotu WHERE z.id_klasy=1 AND p.nazwa='Informatyka'), 5.0, '2025-09-03', 'Projekt HTML'),
(1, (SELECT id_zajec FROM zajecia z JOIN przedmioty p ON z.id_przedmiotu=p.id_przedmiotu WHERE z.id_klasy=1 AND p.nazwa='Język polski'), 3.5, '2025-09-05', 'Kartkówka'),
(2, (SELECT id_zajec FROM zajecia z JOIN przedmioty p ON z.id_przedmiotu=p.id_przedmiotu WHERE z.id_klasy=1 AND p.nazwa='Matematyka'), 5.0, '2025-09-01', NULL),
(2, (SELECT id_zajec FROM zajecia z JOIN przedmioty p ON z.id_przedmiotu=p.id_przedmiotu WHERE z.id_klasy=1 AND p.nazwa='Informatyka'), 4.5, '2025-09-03', 'Aktywność'),
(3, (SELECT id_zajec FROM zajecia z JOIN przedmioty p ON z.id_przedmiotu=p.id_przedmiotu WHERE z.id_klasy=1 AND p.nazwa='Matematyka'), 2.5, '2025-09-01', NULL),
(3, (SELECT id_zajec FROM zajecia z JOIN przedmioty p ON z.id_przedmiotu=p.id_przedmiotu WHERE z.id_klasy=1 AND p.nazwa='Historia'), 4.0, '2025-09-04', 'Prezentacja'),
(4, (SELECT id_zajec FROM zajecia z JOIN przedmioty p ON z.id_przedmiotu=p.id_przedmiotu WHERE z.id_klasy=1 AND p.nazwa='Język angielski'), 5.0, '2025-09-02', 'Słówka'),
(4, (SELECT id_zajec FROM zajecia z JOIN przedmioty p ON z.id_przedmiotu=p.id_przedmiotu WHERE z.id_klasy=1 AND p.nazwa='Historia'), 3.0, '2025-09-06', NULL);

-- Oceny klasa 1B (uczniowie 5-8)
INSERT INTO oceny (id_ucznia, id_zajec, ocena, data_oceny, uwagi) VALUES
(5, (SELECT id_zajec FROM zajecia z JOIN przedmioty p ON z.id_przedmiotu=p.id_przedmiotu WHERE z.id_klasy=2 AND p.nazwa='Matematyka'), 3.0, '2025-09-01', NULL),
(5, (SELECT id_zajec FROM zajecia z JOIN przedmioty p ON z.id_przedmiotu=p.id_przedmiotu WHERE z.id_klasy=2 AND p.nazwa='Informatyka'), 5.0, '2025-09-03', 'Skrypt Bash'),
(6, (SELECT id_zajec FROM zajecia z JOIN przedmioty p ON z.id_przedmiotu=p.id_przedmiotu WHERE z.id_klasy=2 AND p.nazwa='Język polski'), 4.0, '2025-09-05', NULL),
(6, (SELECT id_zajec FROM zajecia z JOIN przedmioty p ON z.id_przedmiotu=p.id_przedmiotu WHERE z.id_klasy=2 AND p.nazwa='Język angielski'), 4.5, '2025-09-02', NULL),
(7, (SELECT id_zajec FROM zajecia z JOIN przedmioty p ON z.id_przedmiotu=p.id_przedmiotu WHERE z.id_klasy=2 AND p.nazwa='Matematyka'), 2.0, '2025-09-01', 'Poprawa wymagana'),
(7, (SELECT id_zajec FROM zajecia z JOIN przedmioty p ON z.id_przedmiotu=p.id_przedmiotu WHERE z.id_klasy=2 AND p.nazwa='Historia'), 3.5, '2025-09-04', NULL),
(8, (SELECT id_zajec FROM zajecia z JOIN przedmioty p ON z.id_przedmiotu=p.id_przedmiotu WHERE z.id_klasy=2 AND p.nazwa='Informatyka'), 5.0, '2025-09-03', 'Bardzo dobra praca');

-- Oceny klasa 2A (uczniowie 9-12)
INSERT INTO oceny (id_ucznia, id_zajec, ocena, data_oceny, uwagi) VALUES
(9, (SELECT id_zajec FROM zajecia z JOIN przedmioty p ON z.id_przedmiotu=p.id_przedmiotu WHERE z.id_klasy=3 AND p.nazwa='Matematyka'), 4.5, '2025-09-01', NULL),
(9, (SELECT id_zajec FROM zajecia z JOIN przedmioty p ON z.id_przedmiotu=p.id_przedmiotu WHERE z.id_klasy=3 AND p.nazwa='Język polski'), 3.0, '2025-09-05', NULL),
(10, (SELECT id_zajec FROM zajecia z JOIN przedmioty p ON z.id_przedmiotu=p.id_przedmiotu WHERE z.id_klasy=3 AND p.nazwa='Informatyka'), 5.0, '2025-09-03', 'SQL'),
(10, (SELECT id_zajec FROM zajecia z JOIN przedmioty p ON z.id_przedmiotu=p.id_przedmiotu WHERE z.id_klasy=3 AND p.nazwa='Język angielski'), 4.0, '2025-09-02', NULL),
(11, (SELECT id_zajec FROM zajecia z JOIN przedmioty p ON z.id_przedmiotu=p.id_przedmiotu WHERE z.id_klasy=3 AND p.nazwa='Historia'), 3.5, '2025-09-04', NULL),
(12, (SELECT id_zajec FROM zajecia z JOIN przedmioty p ON z.id_przedmiotu=p.id_przedmiotu WHERE z.id_klasy=3 AND p.nazwa='Matematyka'), 2.0, '2025-09-01', 'Nieprzygotowanie'),
(12, (SELECT id_zajec FROM zajecia z JOIN przedmioty p ON z.id_przedmiotu=p.id_przedmiotu WHERE z.id_klasy=3 AND p.nazwa='Informatyka'), 4.0, '2025-09-03', 'Projekt CSS');


--  1. Wypisz wszystkich uczniów (imię, nazwisko) posortowanych alfabetycznie po nazwisku.
select imie, nazwisko from uczniowie order by nazwisko ASC;
--  2. Wypisz uczniów z klasy '1A' z datą urodzenia (rosnąco po dacie).
select uczniowie.imie, uczniowie.nazwisko, uczniowie.data_urodzenia from uczniowie 
join klasy on uczniowie.id_klasy = klasy.id_klasy 
where klasy.nazwa = "1A" order by uczniowie.data_urodzenia ASC;

--  3. Policz ilu uczniów jest w każdej klasie (nazwa klasy, liczba uczniów).
select klasy.nazwa as klasa, count(uczniowie.id_ucznia) as liczba_uczniów from klasy 
join uczniowie on uczniowie.id_klasy = klasy.id_klasy
group by klasy.nazwa

--  4. Pokaż listę przedmiotów prowadzonych w klasie '2A' wraz z nauczycielem (przedmiot, nauczyciel).

--  5. Wypisz oceny ucznia 'Jan Kowalski' (przedmiot, ocena, data).

--  6. Dodaj nowego ucznia: „Karolina Malinowska”, urodzona 2009-10-10, do klasy '1B'.
insert into uczniowie (imie, nazwisko, data_urodzenia, id_klasy) VALUES
("Karolina", "Malinowska", "2009-10-10", (select id_klasy from klasy where nazwa = "1B"))

--  7. Dodaj nowy przedmiot „Biologia” oraz zajęcia z Biologii w klasie '1A' prowadzone przez nauczyciela „Agnieszka Wójcik”.
insert into przedmioty (nazwa) values ("Biologia");
insert into zajecia (id_przedmiotu, id_klasy, id_nauczyciela)
values (
    (select id_przedmiotu from przedmioty where nazwa = "Biologia"),
    (select id_klasy from klasy where nazwa = "1A"),
    (select id_nauczyciela from nauczyciele where imie = "Agnieszka" and nazwisko = "Wójcik"))

--  8. Przenieś ucznia „Piotr Wiśniewski” z klasy '1A' do klasy '1B'.
UPDATE uczniowie set id_klasy = (select id_klasy from klasy where nazwa = "1B") where imie = "Piotr" and nazwisko = "Wiśniewski"

--  9. Popraw ocenę z Matematyki dla „Natalia Piotrowska” wystawioną 2025-09-01 na 3.0 (było 2.0).


-- 10. Usuń jedną ocenę „Kacper Kaczmarek” z Informatyki z dnia 2025-09-03.
