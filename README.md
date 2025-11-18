# 🇦🇹 ÖBH Dienstgrade – Hierarchievisualisierung

Darstellung der Dienstgrade der **Dienstgrade des Österreichischen Bundesheeres** mit **D3.js**. Zeigt die Rangordnung als Baumstruktur an.
---

## Funktionen
-  Baumdarstellung (aufklappbare Knoten)
-  Steuerungsbuttons:
  - Alle öffnen / Alle schließen
  - Ansicht zurücksetzen
  - Export als **SVG** oder **PNG**
---

## Installation & Setup

1. Repository klonen oder ZIP herunterladen:
   ```bash
   git clone https://github.com/emir55-alt/OEBH.git
   ```
   Führe die Erste Zeile vom script create_User_script.sql aus, danach erstelle eine Datenbank und führe in der Datenbank die zweite Zeile aus. Danach
   musst du den create_DB_script ausführen. Wenn alles passt, dann server.js starten und index.html im Webbrowser starten.

2. Die Datei `index.html` kann direkt über ein Webbrowser geöffnet werden. Z.B.: Live-Server

## Exportfunktionen
| Format | Beschreibung | Dateiname |
|---------|---------------|-----------|
| **SVG** | Vektorgrafik für weitere Bearbeitung oder Druck | `dienstgrade_baum.svg` |
| **PNG** | Rastergrafik für Präsentationen oder Berichte | `dienstgrade_baum.png` |

Beide Varianten funktionieren direkt im Browser über die bereitgestellten Buttons.

---

##  Technologien
- [D3.js v7](https://d3js.org/)
- HTML5, CSS, JavaScript (ohne Frameworks)

---

## Lizenz
MIT License – frei verwendbar unter Nennung der Quelle.


