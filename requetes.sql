-- 1

SELECT time AS "Horaires à l'arrêt Madelaine (Lundi)"
FROM Horaire
JOIN Attribuer ON Horaire.id = Attribuer.horaire_id
JOIN Station ON Attribuer.station_id = Station.id
WHERE Station.name = 'Madelaine'
ORDER BY time;
 
SELECT time AS "Horaires à l'arrêt République (Lundi) "
FROM Horaire
JOIN Attribuer ON Horaire.id = Attribuer.horaire_id
JOIN Station ON Attribuer.station_id = Station.id
WHERE Station.name = 'République'
ORDER BY time;

-- 2

-- Désactiver le mode ONLY_FULL_GROUP_BY
SET sql_mode=(SELECT REPLACE(@@sql_mode,'ONLY_FULL_GROUP_BY',''));

-- Afficher le parcours complet de la ligne 2 Direction Kersec
SELECT Station.name AS "Parcours de la ligne 2 Direction Kersec"
FROM Station
JOIN Desservir ON Station.id = Desservir.station_id
JOIN Ligne ON Desservir.ligne_id = Ligne.id
WHERE Ligne.name = 'Ligne 2 P+R Ouest - Kersec'
ORDER BY Desservir.ligne_id, Desservir.station_id;

-- 3
-- Table pour gérer les redirections d'arrêts temporairement non desservis vers l'arrêt le plus proche
CREATE TABLE IF NOT EXISTS Redirection (
    id INT AUTO_INCREMENT PRIMARY KEY,
    station_id INT NOT NULL,
    station_proche_id INT NOT NULL,
    FOREIGN KEY (station_id) REFERENCES Station(id),
    FOREIGN KEY (station_proche_id) REFERENCES Station(id)
);

-- 4 
SELECT
    CASE
        WHEN EXISTS (SELECT * FROM Redirection WHERE station_id = (SELECT id FROM Station WHERE name = 'Petit Tohannic')) THEN 'Arrêt temporairement non desservi.'
        ELSE Horaire.time
    END AS Horaire
FROM
    Horaire
JOIN
    Attribuer ON Horaire.id = Attribuer.horaire_id
JOIN
    Station ON Attribuer.station_id = Station.id
WHERE
    Station.name = 'Petit Tohannic';
	
-- 5

-- Insérer une redirection pour l'arrêt Petit Tohannic vers l'arrêt Delestraint
INSERT INTO Redirection (station_id, station_proche_id) VALUES (
    (SELECT id FROM Station WHERE name = 'Petit Tohannic'),
    (SELECT id FROM Station WHERE name = 'Delestraint')
);

SELECT DISTINCT
    CASE
        WHEN EXISTS (SELECT * FROM Redirection WHERE station_id = (SELECT id FROM Station WHERE name = 'Petit Tohannic')) THEN CONCAT('Arrêt temporairement non desservi, veuillez vous reporter à l\'arrêt ', (SELECT name FROM Station WHERE id = (SELECT station_proche_id FROM Redirection WHERE station_id = (SELECT id FROM Station WHERE name = 'Petit Tohannic'))))
        ELSE Horaire.time
    END AS "Horaires à l'arrêt Petit Tohannic (Lundi)"
FROM
    Horaire
JOIN
    Attribuer ON Horaire.id = Attribuer.horaire_id
JOIN
    Station ON Attribuer.station_id = Station.id
WHERE
    Station.name = 'Petit Tohannic';
	
-- 6

-- Ajout de la nouvelle ligne opposée
INSERT INTO Ligne (name) VALUES ('Ligne 2 Kersec - P+R Ouest');
SET @ligne_opposee = LAST_INSERT_ID();

-- Associer la ligne opposé avec le lundi
INSERT INTO Circuler (ligne_id, jour_id) VALUES (@ligne_opposee, 6);

-- 
INSERT INTO Desservir (station_id, ligne_id) VALUES (20, @ligne_opposee);
INSERT INTO Planifier (horaire_id, jour_id) VALUES (68, 6);
INSERT INTO Attribuer (horaire_id, station_id) VALUES (68, 20);

INSERT INTO Desservir (station_id, ligne_id) VALUES (21, @ligne_opposee);
INSERT INTO Planifier (horaire_id, jour_id) VALUES (63, 6);
INSERT INTO Attribuer (horaire_id, station_id) VALUES (63, 21);

INSERT INTO Desservir (station_id, ligne_id) VALUES (22, @ligne_opposee);
INSERT INTO Planifier (horaire_id, jour_id) VALUES (58, 6);
INSERT INTO Attribuer (horaire_id, station_id) VALUES (58, 22);

INSERT INTO Desservir (station_id, ligne_id) VALUES (23, @ligne_opposee);
INSERT INTO Planifier (horaire_id, jour_id) VALUES (53, 6);
INSERT INTO Attribuer (horaire_id, station_id) VALUES (53, 23);

INSERT INTO Desservir (station_id, ligne_id) VALUES (24, @ligne_opposee);
INSERT INTO Planifier (horaire_id, jour_id) VALUES (34, 6);
INSERT INTO Attribuer (horaire_id, station_id) VALUES (34, 24);

INSERT INTO Desservir (station_id, ligne_id) VALUES (25, @ligne_opposee);
INSERT INTO Planifier (horaire_id, jour_id) VALUES (43, 6);
INSERT INTO Attribuer (horaire_id, station_id) VALUES (43, 25);

INSERT INTO Desservir (station_id, ligne_id) VALUES (26, @ligne_opposee);
INSERT INTO Planifier (horaire_id, jour_id) VALUES (38, 6);
INSERT INTO Attribuer (horaire_id, station_id) VALUES (38, 26);

INSERT INTO Desservir (station_id, ligne_id) VALUES (27, @ligne_opposee);
INSERT INTO Planifier (horaire_id, jour_id) VALUES (33, 6);
INSERT INTO Attribuer (horaire_id, station_id) VALUES (33, 27);