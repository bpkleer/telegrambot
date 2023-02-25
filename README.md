# Telegram-Bot für Studierendenfragen

## Beta-Phase (v0.2)

## Projektziel
Ziel ist es für Studierende eine einfache Möglichkeit zu entwickeln, so dass diese einfach und schnell gesuchte Informationen erlangen können bzw. an den richtigen Ort weitergeleitet werden. Es können leicht Veränderungen vorgenommen werden.

Zur besseren Bearbeitung sind die Keywords in `.csv`-Dateien gespeichert (Ordner `keys`) und die Antworten zu den Keywords in `.txt`-Dateien (Ordner `texts`). In der `.csv`-Datei ist die erste Zeile zur Identifikation der Datei (für die Keywordsuche, siehe weiter unten). Diese heißt wie das jeweilige R-Objekt. Beim Verändern daran denken, dass die Dateien mit einer leeren Zeile enden müssen. Im Text können emojis entweder direkt (z.B. 😃) oder als Byte eingefügt werden (z.B. `\x31\xE2\x83\xA3`).

Eine Übersicht der *Keywords* zu Textdateien findet sich hier:
| search aim   | keywords |  text |
|:----------|:-------------|:------|
| Simone Abendschön |  `simone.csv` | `simone.txt` |
| Mical Gerezgiher | `mical.csv` | `mical.txt` |
| Patricia Kamper | `patricia.csv` | `patricia.txt` |
| Philipp Kleer | `philipp.csv`   |  `philipp.txt` |
| Tim Schmidt | `tim.csv` | `tim.txt` | 
| Angelika Wicke | `angelika.csv` | `angelika.txt` |
| Alles rund um Prüfungen | `exam.csv` | `exam.txt` |
| Sprechstunden | `office.csv`| `office.txt` |
| Alles zur Thesis | `thesis.csv` | `thesis.txt` |
| Prüfungsanmeldung | `registration.csv` | `registration.txt` |
| Präsenzprüfung | `presence.csv` | `presence.txt` |
| Prüfungsort/-zeit | `place.csv` | `place.txt` |
| Online-Prüfung | `online.csv` | `online.txt` |
| Attest/Krankheit | `ill.csv` | `ill.txt` |
| Prüfungswiederholung | `fail.csv` | `fail.txt` |
| schriftliche Arbeit | `written.csv` | `written.txt` | 
| Rund um Note | `grade.csv` | `grade.txt` |
| Vorleistung | `preexam.csv` | `preexam.txt` |
| Tutorium (Statistik) | `tut.csv` | `tut.txt` |
| Lehrangebot | `teaching.csv` | `teaching.txt` |

## Erstellen neuer Suchbegriffe und Antworten
Dazu muss zuerst eine `.csv`-Datei mit den Keywords im Ordner `keys` abgelegt werden und ein Antwort-Text als `.txt`-Datei im Ordner `texts`.

Vor dem Erstellen der neuen Keywords-Liste bitte mit der Funktion `check_keyword()` (R-Skript `check-keyword.R`) prüfen, ob die neuen Keywords schon in anderen Pools genutzt werden. Es darf keine direkte Überschneidung geben, also nicht in zwei Keyword-Listen das Wort `Philipp` zum Beispiel.

Bei der Erstellung bitte folgende **Namenskonvention** beachten, damit man langfristig nicht durcheinander kommt:
- im R-Skript: `wordsNewtopic`
- `.csv`-Datei im Ordner `keys`: `newtopic.csv`
- `.txt`-Datei im Ordner `texts`: `newtopic.txt`

Zweitens kannst du, wenn die `.csv`- und die `.txt`-Datei erstellt sind, nun den Code-Bereich in `init.R` anpassen. Dazu gehst du zuerst in den Bereich `# > Custom keywords as Strings`. Hier wird die neue Keyword-Sammlung eingefügt werden. Am besten kopierst du einen Block und änderst dann den Objektnamen auf den neuen um, sowie den Dateinamen (der `.csv`-Datei),

Drittens musst du die Funktion `case` im Abschnitt `# > Functions` anpassen. Dazu scrollst du ans Ende der Funktion. Du kopierst den letzten `else if`-Abschnitt und fügst diesen vor dem `else`-Abschnitt ein. In diesem musst du dann nur noch die Objekte und Dateien an die neuen Keywörter anpassen. 

Falls du direkt in Git arbeitest, musst du anschließend noch die Pipe anstoßen, wenn du es über RStudio bzw. den Terminal machst, reicht der Push und die Pipe startet den Bot automatisch neu.a

## Credits (Telegram Bot)
Alle Bearbeitungen beruhen auf den Hinweisen im R Paket [telegram.bot](https://cran.r-project.org/web/packages/telegram.bot/index.html) geschrieben von Ernest Benedito & Chris Stefano. Eine Schnelleinführung gibt es [hier](https://ebeneditos.github.io/telegram.bot/).

## Credits (Docker-Implementierung)
Der Telegram-Bot läuft über einen Docker. Anleitungen dafür finden sich [hier](https://www.r-bloggers.com/2021/05/best-practices-for-r-with-docker/) und [hier](https://www.r-bloggers.com/2019/02/running-your-r-script-in-docker/)