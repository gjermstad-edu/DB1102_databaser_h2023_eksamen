-- Oppretter en database som heter brettspill
CREATE DATABASE brettspill;
USE brettspill;

-- Oppretter en tabell som heter brettspill
CREATE TABLE brettspill (
  brettspill_id INT PRIMARY KEY,
  navn VARCHAR(100) NOT NULL,
  type VARCHAR(50),
  antall_spillere INT,
  spilletid INT,
  aldersgrense INT,
  bilde VARCHAR(200)
);

-- Oppretter en tabell som heter spiller
CREATE TABLE spiller (
  spiller_id INT PRIMARY KEY,
  navn VARCHAR(100) NOT NULL,
  kallenavn VARCHAR(50) UNIQUE,
  epost VARCHAR(100) UNIQUE
);

-- Oppretter en tabell som heter spillkveld
CREATE TABLE spillkveld (
  spillkveld_id INT PRIMARY KEY,
  dato DATE NOT NULL,
  sted VARCHAR(100) NOT NULL
);

-- Oppretter en tabell som heter deltakelse
CREATE TABLE deltakelse (
  spiller_id INT NOT NULL,
  spillkveld_id INT NOT NULL,
  PRIMARY KEY (spiller_id, spillkveld_id),
  FOREIGN KEY (spiller_id) REFERENCES spiller(spiller_id),
  FOREIGN KEY (spillkveld_id) REFERENCES spillkveld(spillkveld_id)
);

-- Oppretter en tabell som heter spillrunde
CREATE TABLE spillrunde (
  spillrunde_id INT PRIMARY KEY,
  brettspill_id INT NOT NULL,
  spillkveld_id INT NOT NULL,
  FOREIGN KEY (brettspill_id) REFERENCES brettspill(brettspill_id),
  FOREIGN KEY (spillkveld_id) REFERENCES spillkveld(spillkveld_id)
);

-- Oppretter en tabell som heter resultat
CREATE TABLE resultat (
  spiller_id INT NOT NULL,
  spillrunde_id INT NOT NULL,
  poeng INT,
  plassering INT,
  PRIMARY KEY (spiller_id, spillrunde_id),
  FOREIGN KEY (spiller_id) REFERENCES spiller(spiller_id),
  FOREIGN KEY (spillrunde_id) REFERENCES spillrunde(spillrunde_id)
);

-- Fyller tabellen brettspill med rader
INSERT INTO brettspill (brettspill_id, navn, type, antall_spillere, spilletid, aldersgrense, bilde) VALUES
(1, 'Monopol', 'Strategi', 2, 120, 8, 'monopol.jpg'),
(2, 'Trivial Pursuit', 'Trivia', 2, 90, 12, 'trivial_pursuit.jpg'),
(3, 'Uno', 'Kort', 2, 30, 7, 'uno.jpg'),
(4, 'Yahtzee', 'Terning', 2, 20, 6, 'yahtzee.jpg'),
(5, 'Cluedo', 'Krim', 3, 60, 10, 'cluedo.jpg');

-- Fyller tabellen spiller med rader
INSERT INTO spiller (spiller_id, navn, kallenavn, epost) VALUES
(1, 'Pelle Parafin', 'Pelle', 'pelle@parafin.no'),
(2, 'Ragna Rekkverk', 'Ragna', 'ragna@rekkverk.no'),
(3, 'Leon Latex', 'Leon', 'leon@latex.no'),
(4, 'Frida Frosk', 'Frida', 'frida@frosk.no'),
(5, 'Billy Betong', 'Billy', 'billy@betong.no');

-- Fyller tabellen spillkveld med rader
INSERT INTO spillkveld (spillkveld_id, dato, sted) VALUES
(1, '2023-11-01', 'Pelle og Ragna sin leilighet'),
(2, '2023-11-08', 'Leon sin hytte'),
(3, '2023-11-15', 'Frida sin leilighet'),
(4, '2023-11-22', 'Billy sin leilighet'),
(5, '2023-11-29', 'Pelle og Ragna sin leilighet');

-- Fyller tabellen deltakelse med rader
INSERT INTO deltakelse (spiller_id, spillkveld_id) VALUES
(1, 1), (2, 1), (3, 1), (4, 1), (5, 1), -- Alle deltok på første spillkveld
(1, 2), (2, 2), (3, 2), (4, 2), -- Pelle, Ragna, Leon og Frida deltok på andre spillkveld
(1, 3), (2, 3), (4, 3), (5, 3), -- Pelle, Ragna, Frida og Billy deltok på tredje spillkveld
(2, 4), (3, 4), (4, 4), (5, 4), -- Ragna, Leon, Frida og Billy deltok på fjerde spillkveld
(1, 5), (2, 5), (3, 5), (4, 5), (5, 5); -- Alle deltok på femte spillkveld

-- Fyller tabellen spillrunde med rader
INSERT INTO spillrunde (spillrunde_id, brettspill_id, spillkveld_id) VALUES
(1, 1, 1), -- Spilte Monopol på første spillkveld
(2, 2, 1), -- Spilte Trivial Pursuit på første spillkveld
(3, 3, 2), -- Spilte Uno på andre spillkveld
(4, 4, 2), -- Spilte Yahtzee på andre spillkveld
(5, 5, 3), -- Spilte Cluedo på tredje spillkveld
(6, 1, 3), -- Spilte Monopol på tredje spillkveld
(7, 2, 4), -- Spilte Trivial Pursuit på fjerde spillkveld
(8, 3, 4), -- Spilte Uno på fjerde spillkveld
(9, 4, 5), -- Spilte Yahtzee på femte spillkveld
(10, 5, 5); -- Spilte Cluedo på femte spillkveld

-- Fyller tabellen resultat med rader
INSERT INTO resultat (spiller_id, spillrunde_id, poeng, plassering) VALUES
(1, 1, 2000, 1), -- Pelle vant Monopol på første spillkveld
(2, 1, 1500, 2), -- Ragna kom på andre plass i Monopol på første spillkveld
(3, 1, 1000, 3), -- Leon kom på tredje plass i Monopol på første spillkveld
(4, 1, 500, 4), -- Frida kom på fjerde plass i Monopol på første spillkveld
(5, 1, 0, 5), -- Billy kom på sisteplass i Monopol på første spillkveld
(2, 2, 20, 1), -- Ragna vant Trivial Pursuit på første spillkveld
(4, 2, 15, 2), -- Frida kom på andre plass i Trivial Pursuit på første spillkveld
(1, 2, 10, 3), -- Pelle kom på tredje plass i Trivial Pursuit på første spillkveld
(5, 2, 5, 4), -- Billy kom på fjerde plass i Trivial Pursuit på første spillkveld
(3, 2, 0, 5), -- Leon kom på sisteplass i Trivial Pursuit på første spillkveld
(3, 3, 500, 1), -- Leon vant Uno på andre spillkveld
(4, 3, 400, 2), -- Frida kom på andre plass i Uno på andre spillkveld
(1, 3, 300, 3), -- Pelle kom på tredje plass i Uno på andre spillkveld
(2, 3, 200, 4), -- Ragna kom på fjerde plass i Uno på andre spillkveld
(4, 4, 300, 1), -- Frida vant Yahtzee på andre spillkveld
(2, 4, 250, 2), -- Ragna kom på andre plass i Yahtzee på andre spillkveld
(3, 4, 200, 3), -- Leon kom på tredje plass i Yahtzee på andre spillkveld
(1, 4, 150, 4), -- Pelle kom på fjerde plass i Yahtzee på andre spillkveld
(5, 5, 6, 1), -- Billy vant Cluedo på tredje spillkveld
(4, 5, 5, 2), -- Frida kom på andre plass i Cluedo på tredje spillkveld
(1, 5, 4, 3), -- Pelle kom på tredje plass i Cluedo på tredje spillkveld
(2, 5, 3, 4), -- Ragna kom på fjerde plass i Cluedo på tredje spillkveld
(3, 5, 2, 5), -- Leon kom på sisteplass i Cluedo på tredje spillkveld
(1, 6, 2500, 1), -- Pelle vant Monopol på tredje spillkveld
(5, 6, 2000, 2), -- Billy kom på andre plass i Monopol på tredje spillkveld
(2, 6, 1500, 3), -- Ragna kom på tredje plass i Monopol på tredje spillkveld
(4, 6, 1000, 4), -- Frida kom på fjerde plass i Monopol på tredje spillkveld
(2, 7, 25, 1), -- Ragna vant Trivial Pursuit på fjerde spillkveld
(3, 7, 20, 2), -- Leon kom på andre plass i Trivial Pursuit på fjerde spillkveld
(5, 7, 15, 3), -- Billy kom på tredje plass i Trivial Pursuit på fjerde spillkveld
(4, 7, 10, 4), -- Frida kom på fjerde plass i Trivial Pursuit på fjerde spillkveld
(4, 8, 600, 1), -- Frida vant Uno på fjerde spillkveld
(5, 8, 500, 2), -- Billy kom på andre plass i Uno på fjerde spillkveld
(3, 8, 400, 3), -- Leon kom på tredje plass i Uno på fjerde spillkveld
(2, 8, 300, 4), -- Ragna kom på fjerde plass i Uno på fjerde spillkveld
(4, 9, 350, 1), -- Frida vant Yahtzee på femte spillkveld
(1, 9, 300, 2), -- Pelle kom på andre plass i Yahtzee på femte spillkveld
(2, 9, 250, 3), -- Ragna kom på tredje plass i Yahtzee på femte spillkveld
(3, 9, 200, 4), -- Leon kom på fjerde plass i Yahtzee på femte spillkveld
(5, 9, 150, 5), -- Billy kom på sisteplass i Yahtzee på femte spillkveld
(1, 10, 7, 1), -- Pelle vant Cluedo på femte spillkveld
(3, 10, 6, 2), -- Leon kom på andre plass i Cluedo på femte spillkveld
(4, 10, 5, 3), -- Frida kom på tredje plass i Cluedo på femte spillkveld
(5, 10, 4, 4), -- Billy kom på fjerde plass i Cluedo på femte spillkveld
(2, 10, 3, 5); -- Ragna kom på sisteplass i Cluedo på femte spillkveld
