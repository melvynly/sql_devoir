# sql_devoir

Table des matières


Utiliser les scripts SQL


Dictionnaire des données : 

1. Station
   - id : INT, AUTO_INCREMENT, PRIMARY KEY. Identifiant unique pour chaque station.
   - name : VARCHAR(255), NOT NULL. Le nom de la station.

2. Ligne
   - id : INT, AUTO_INCREMENT, PRIMARY KEY. Identifiant unique pour chaque ligne de bus.
   - name : VARCHAR(255), NOT NULL. Le nom de la ligne de bus.

3. Jour
   - id : INT, AUTO_INCREMENT, PRIMARY KEY. Identifiant unique pour chaque jour de la semaine.
   - name : VARCHAR(255), NOT NULL. Le nom du jour.

4. Horaire
   - id : INT, AUTO_INCREMENT, PRIMARY KEY. Identifiant unique pour chaque entrée d'horaire.
   - time : TIME, NOT NULL. L'heure de l'horaire du bus.

5. Desservir (Association entre Station et Ligne)
   - station_id : INT, FOREIGN KEY REFERENCES Station(id). L'identifiant de la station.
   - ligne_id : INT, FOREIGN KEY REFERENCES Ligne(id). L'identifiant de la ligne de bus.
   - Clé PRIMAIRE composée (station_id, ligne_id). Représente une relation n/n entre stations et lignes de bus.

6. Circuler (Association entre Ligne et Jour)
   - ligne_id : INT, FOREIGN KEY REFERENCES Ligne(id). L'identifiant de la ligne de bus.
   - jour_id : INT, FOREIGN KEY REFERENCES Jour(id). L'identifiant du jour.
   - Clé PRIMAIRE composée (ligne_id, jour_id). Représente une relation n/n avec un focus sur un seul jour (par exemple, le lundi) pour simplification.

7. Planifier (Association entre Horaire et Jour)
   - horaire_id : INT, FOREIGN KEY REFERENCES Horaire(id). L'identifiant de l'horaire.
   - jour_id : INT, FOREIGN KEY REFERENCES Jour(id). L'identifiant du jour.
   - Clé PRIMAIRE composée (horaire_id, jour_id). Représente une relation n/n entre horaires et jours.

8. Attribuer (Association entre Horaire et Station)
   - horaire_id : INT, FOREIGN KEY REFERENCES Horaire(id). L'identifiant de l'horaire.
   - station_id : INT, FOREIGN KEY REFERENCES Station(id). L'identifiant de la station.
   - Clé PRIMAIRE composée (horaire_id, station_id). Représente une relation n/n où un horaire est attribué à une seule station mais une station peut avoir plusieurs horaires.


Le modèle conceptuel des données (MCD)
![MCD](https://github.com/melvynly/sql_devoir/assets/32169498/61b7281e-6c89-40bf-a773-5103b9771875)
