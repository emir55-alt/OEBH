# 🇦🇹 ÖBH Dienstgrade – Hierarchievisualisierung

Visualisierung der **Dienstgrade des Österreichischen Bundesheeres** als interaktive Baumstruktur mit **D3.js**.

---

## 📌 Funktionen
- Interaktive Baumdarstellung (auf- und zuklappbare Knoten)
- Steuerungsbuttons:
  - **Alle öffnen**
  - **Alle schließen**
  - **Ansicht zurücksetzen**
  - **Export als SVG**
  - **Export als PNG**

---

## 🚀 Installation & Startanleitung

### 1. Repository herunterladen
```bash
git clone https://github.com/<dein-benutzername>/oebh-hierarchie.git
cd oebh-hierarchie
2. Datenbank einrichten
Schritt A – Benutzer anlegen
Führe in der Datei create_User_script.sql nur die erste Zeile aus (legt den Datenbankbenutzer an).

Schritt B – Datenbank erstellen
Erstelle eine neue, leere Datenbank.

Schritt C – Benutzerrechte vergeben
Führe die zweite Zeile aus der Datei innerhalb deiner neu erstellten Datenbank aus (verleiht dem Benutzer die nötigen Rechte).

Schritt D – Tabellen & Daten anlegen
Führe das komplette Skript create_DB_script.sql aus.
Damit werden Tabellen, Inhalte und Strukturen erzeugt.

🖥️ 3. Server starten
Öffne ein Terminal im Projektordner.

Dependencies installieren (falls benötigt)
bash
Code kopieren
npm install
Server starten
bash
Code kopieren
node server.js
Der Server läuft anschließend unter z. B.:
http://localhost:3000
(oder dem Port, der in server.js definiert ist)

🌐 4. Frontend starten (index.html)
Die Datei index.html wird nicht automatisch vom Server ausgeliefert.
Es gibt zwei Möglichkeiten:

Möglichkeit A – Direkt im Browser öffnen
Doppelklick auf index.html

oder im Browser: Datei → Datei öffnen → index.html auswählen

Möglichkeit B – Über einen Static File Server
(z. B. Live Server oder ein beliebiger lokaler Webserver)

📤 Exportfunktionen
Format	Beschreibung	Dateiname
SVG	Vektorgrafik (ideal für Bearbeitung & Druck)	dienstgrade_baum.svg
PNG	Rastergrafik (ideal für Präsentationen)	dienstgrade_baum.png

Alle Exportfunktionen funktionieren direkt im Browser über die UI-Buttons.

🛠️ Technologien
D3.js v7

HTML5, CSS, JavaScript

Node.js (für server.js)

SQL (für Datenbank)

📄 Lizenz
MIT License – frei nutzbar unter Nennung der Quelle.
