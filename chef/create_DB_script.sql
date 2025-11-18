CREATE TABLE IF NOT EXISTS dienstgradgruppen (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    sortierung INTEGER NOT NULL,
    beschreibung TEXT
);

CREATE TABLE IF NOT EXISTS dienstgrade (
    id SERIAL PRIMARY KEY,
    dienstgradgruppe_id INTEGER REFERENCES dienstgradgruppen(id),
    name VARCHAR(100) NOT NULL,
    abkuerzung VARCHAR(20),
    sortierung INTEGER NOT NULL,
    nato_rang VARCHAR(10),
    beschreibung TEXT,
    erstellt_am TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS funktionen (
    id SERIAL PRIMARY KEY,
    dienstgrad_id INTEGER REFERENCES dienstgrade(id),
    funktion TEXT NOT NULL
);

-- Daten einfügen - Dienstgradgruppen
INSERT INTO dienstgradgruppen (name, sortierung, beschreibung) VALUES
('Generale', 1, 'Höchste Führungsebene des Bundesheeres'),
('Stabsoffiziere', 2, 'Bataillons- und Brigadekommandanten'),
('Hauptleute', 3, 'Kompanie- und Zugführung'),
('Subalternoffiziere', 4, 'Zugs- und Gruppenführung'),
('Unteroffiziere', 5, 'Führung auf Gruppen- und Zugsebene'),
('Chargen', 6, 'Mannschaft mit Führungsfunktion'),
('Mannschaften', 7, 'Personen ohne Chargengrad');

-- Dienstgrade - Generale
INSERT INTO dienstgrade (dienstgradgruppe_id, name, abkuerzung, sortierung, nato_rang) VALUES
(1, 'General', 'Gen', 1, 'OF-9'),
(1, 'Generalleutnant', 'GenLt', 2, 'OF-8'),
(1, 'Generalmajor', 'GenMaj', 3, 'OF-7'),
(1, 'Brigadier', 'Bgdr', 4, 'OF-6');

-- Dienstgrade - Stabsoffiziere
INSERT INTO dienstgrade (dienstgradgruppe_id, name, abkuerzung, sortierung, nato_rang) VALUES
(2, 'Oberst', 'Obst', 5, 'OF-5'),
(2, 'Oberstleutnant', 'Obstlt', 6, 'OF-4'),
(2, 'Major', 'Mjr', 7, 'OF-3');

-- Dienstgrade - Hauptleute
INSERT INTO dienstgrade (dienstgradgruppe_id, name, abkuerzung, sortierung, nato_rang) VALUES
(3, 'Hauptmann', 'Hptm', 8, 'OF-2');

-- Dienstgrade - Subalternoffiziere
INSERT INTO dienstgrade (dienstgradgruppe_id, name, abkuerzung, sortierung, nato_rang) VALUES
(4, 'Oberleutnant', 'Oblt', 9, 'OF-1'),
(4, 'Leutnant', 'Lt', 10, 'OF-1'),
(4, 'Fähnrich', 'Fhr', 11, 'OF(D)');

-- Dienstgrade - Unteroffiziere
INSERT INTO dienstgrade (dienstgradgruppe_id, name, abkuerzung, sortierung, nato_rang) VALUES
(5, 'Vizeleutnant', 'Vzlt', 12, 'OR-9'),
(5, 'Offiziersstellvertreter', 'Ofstv', 13, 'OR-8'),
(5, 'Stabswachtmeister', 'StWm', 14, 'OR-8'),
(5, 'Oberwachtmeister', 'OWm', 15, 'OR-7'),
(5, 'Wachtmeister', 'Wm', 16, 'OR-6');

-- Dienstgrade - Chargen
INSERT INTO dienstgrade (dienstgradgruppe_id, name, abkuerzung, sortierung, nato_rang) VALUES
(6, 'Stabskorporal', 'StKpl', 17, 'OR-5'),
(6, 'Korporal', 'Kpl', 18, 'OR-4'),
(6, 'Zugsführer', 'Zgf', 19, 'OR-3'),
(6, 'Gefreiter', 'Gfr', 20, 'OR-2');

-- Dienstgrade - Mannschaften
INSERT INTO dienstgrade (dienstgradgruppe_id, name, abkuerzung, sortierung, nato_rang) VALUES
(7, 'Rekrut', 'Rek', 21, 'OR-1');

-- Typische Funktionen
INSERT INTO funktionen (dienstgrad_id, funktion) VALUES
(1, 'Chef des Generalstabes'),
(1, 'Kommandant Streitkräfte'),
(2, 'Stellvertretender Chef des Generalstabes'),
(2, 'Kommandant Streitkräftebasis'),
(3, 'Kommandant der Theresianischen Militärakademie'),
(3, 'Militärkommandant'),
(4, 'Brigadekommandant'),
(4, 'Kommandant einer Schule'),
(5, 'Kommandant eines Regiments'),
(5, 'Verteidigungsattaché'),
(6, 'Kommandant eines Bataillons'),
(7, 'Kommandant eines Bataillons'),
(7, 'Kommandant einer Kompanie'),
(8, 'Kommandant einer Kompanie'),
(8, 'Sachbearbeiter im Stab'),
(9, 'Zugskommandant'),
(10, 'Zugskommandant'),
(11, 'Militärakademiker und Offiziersanwärter'),
(16, 'Gruppenkommandant'),
(17, 'Gruppenkommandant'),
(18, 'Gruppenkommandant'),
(19, 'Gruppenkommandant-Stellvertreter'),
(20, 'Gruppenkommandant-Stellvertreter'),
(21, 'Mannschaft');

-- View erstellen
CREATE OR REPLACE VIEW v_dienstgrade_hierarchie AS
SELECT 
    dg.id,
    dg.name AS dienstgrad,
    dg.abkuerzung,
    dg.nato_rang,
    dgg.name AS dienstgradgruppe,
    dgg.sortierung AS gruppe_sortierung,
    dg.sortierung AS rang_sortierung,
    STRING_AGG(f.funktion, '; ' ORDER BY f.id) AS funktionen
FROM 
    dienstgrade dg
    INNER JOIN dienstgradgruppen dgg ON dg.dienstgradgruppe_id = dgg.id
    LEFT JOIN funktionen f ON dg.id = f.dienstgrad_id
GROUP BY 
    dg.id, dg.name, dg.abkuerzung, dg.nato_rang, 
    dgg.name, dgg.sortierung, dg.sortierung
ORDER BY 
    dg.sortierung;

-- Berechtigungen für bundesheer_user erteilen
GRANT USAGE ON SCHEMA public TO bundesheer_user;
GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA public TO bundesheer_user;
GRANT USAGE, SELECT ON ALL SEQUENCES IN SCHEMA public TO bundesheer_user;

-- View-Berechtigung (kompatibel mit älteren PostgreSQL-Versionen)
GRANT SELECT ON v_dienstgrade_hierarchie TO bundesheer_user;

-- Berechtigungen für zukünftige Objekte
ALTER DEFAULT PRIVILEGES IN SCHEMA public 
    GRANT SELECT, INSERT, UPDATE, DELETE ON TABLES TO bundesheer_user;

ALTER DEFAULT PRIVILEGES IN SCHEMA public 
    GRANT USAGE, SELECT ON SEQUENCES TO bundesheer_user;