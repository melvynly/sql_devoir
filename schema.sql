
USE kiceo_db;

-- Supprimer les tables si elles existent
DROP TABLE IF EXISTS Attribuer;
DROP TABLE IF EXISTS Planifier;
DROP TABLE IF EXISTS Circuler;
DROP TABLE IF EXISTS Desservir;
DROP TABLE IF EXISTS Horaire;
DROP TABLE IF EXISTS Jour;
DROP TABLE IF EXISTS Ligne;
DROP TABLE IF EXISTS Station;

-- Table 'Station' pour représenter les arrêts de bus
CREATE TABLE IF NOT EXISTS Station (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL
);

-- Table 'Ligne' pour représenter une ligne de bus
CREATE TABLE IF NOT EXISTS Ligne (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL
);

-- Table 'Jour' pour représenter les jours de la semaine
CREATE TABLE IF NOT EXISTS Jour (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL
);

-- Table 'Horaire' pour représenter les horaires des bus
CREATE TABLE IF NOT EXISTS Horaire (
    id INT AUTO_INCREMENT PRIMARY KEY,
    time TIME NOT NULL
);

-- Association 'Desservir' entre 'Station' et 'Ligne'
-- Une Station peut être desservie par plusieurs lignes (N) et une ligne dessert plusieurs stations (N)
CREATE TABLE IF NOT EXISTS Desservir (
    station_id INT,
    ligne_id INT,
    PRIMARY KEY (station_id, ligne_id),
    FOREIGN KEY (station_id) REFERENCES Station(id),
    FOREIGN KEY (ligne_id) REFERENCES Ligne(id)
);

-- Association 'Circuler' entre 'Ligne' et 'Jour'
-- Une Ligne circule à plusieurs jours (N) mais ici on considère un seul jour (1), le lundi
CREATE TABLE IF NOT EXISTS Circuler (
    ligne_id INT,
    jour_id INT,
    PRIMARY KEY (ligne_id, jour_id),
    FOREIGN KEY (ligne_id) REFERENCES Ligne(id),
    FOREIGN KEY (jour_id) REFERENCES Jour(id)
);

-- Association 'Planifier' entre 'Horaire' et 'Jour'
-- Un jour peut avoir plusieurs horaires (N) et un horaire correspond à un seul jour (1)
CREATE TABLE IF NOT EXISTS Planifier (
    horaire_id INT,
    jour_id INT,
    PRIMARY KEY (horaire_id, jour_id),
    FOREIGN KEY (horaire_id) REFERENCES Horaire(id),
    FOREIGN KEY (jour_id) REFERENCES Jour(id)
);

-- Association 'Attribuer' entre 'Horaire' et 'Station'
-- Une Station a plusieurs horaires (N) et un horaire est attribué à une seule station (1)
CREATE TABLE IF NOT EXISTS Attribuer (
    horaire_id INT,
    station_id INT,
    PRIMARY KEY (horaire_id, station_id),
    FOREIGN KEY (horaire_id) REFERENCES Horaire(id),
    FOREIGN KEY (station_id) REFERENCES Station(id)
);
