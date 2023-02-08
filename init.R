library("telegram.bot")

# Automatization try ----
# usethis::edit_r_environ("project")
# this should be in .Renviron file bot_token() function
updater <- Updater(token = bot_token("RTelegramBot"))

# Custom keyboard replies
keyStart <- ReplyKeyboardMarkup(
  keyboard = list(
    list(KeyboardButton("\x31\xE2\x83\xA3 Prüfungen")),
    list(KeyboardButton("\x32\xE2\x83\xA3 Sprechstunden")),
    list(KeyboardButton("\x33\xE2\x83\xA3 Thesis"))
  ),
  resize_keyboard = FALSE,
  one_time_keyboard = TRUE
)

keyExams <- ReplyKeyboardMarkup(
  keyboard = list(
    list(
      KeyboardButton("\xF0\x9F\x9A\xA8 Prüfungsanmeldung"),
      KeyboardButton("\xF0\x9F\x98\xB7 Attest/Krankheit"),
      KeyboardButton("\xF0\x9F\x95\x93 Ort/Zeit Klausur")
      ),
    list(
      KeyboardButton("\xF0\x9F\x94\x84 Wiederholungsprüfung"),
      KeyboardButton("\xF0\x9F\x9A\x8F Präsenzprüfung"),
      KeyboardButton("\xF0\x9F\x8C\x8F Online-Prüfung")
      ),
    list(
      KeyboardButton("\xF0\x9F\x93\x9D Hausarbeit"),
      KeyboardButton("\xF0\x9F\x93\x90 Vorleistung"),
      KeyboardButton("/start \xF0\x9F\x94\x83")
      )
  )
)

keyBack <- ReplyKeyboardMarkup(
  keyboard = list(
    list(KeyboardButton("/start \xF0\x9F\x94\x83"))
  )
)

# Custom Dictionaries as Strings
wordsSimone <- c("Simone", "Simone Abendschön")
wordsPhil <- c("Philipp", "Philipp Kleer")
wordsTim <- c("Tim", "Tim Schmidt")
wordsPatricia <- c("Patricia", "Patricia Kamper")
wordsMical <- c("Mical", "Mical Gerezgiher")
wordsAngelika <- c("Angelika", "Angelika Wicke", "Sekretariat", "Sekretärin")
wordsOffice <- c("Sprechstunde", "Sprechzeiten", "Beratung")
wordsThesis <- c(
  "Thesis", "Abschlussarbeit", "Bachelorarbeit",
  "Masterarbeit", "Bachelorthesis", "Bachelor-Thesis",
  "Masterthesis", "Master-Thesis", "WHA", "wissenschaftliche Hausarbeit",
  "Staatsexamen"
)
wordsOnline <- c("Online-Test", "Online-Prüfung", "Open-Book-Test")
wordsAnmeldung <- c("Prüfungsanmeldung", "Anmeldung", "flexnow")
wordsIll <- c(
  "Attest", "Krankheit", "krank", "Prüfungsunfähigkeit", 
  "prüfungsunfähig"
)
wordsFail <- c(
  "Wiederholungsprüfung", "Ausgleichklausur", 
  "Ausgleichsklausur", "durchgefallen", "nicht bestanden"
)
wordsWritten <- c("Hausarbeit", "Seminararbeit", "Ausarbeitung")
wordsPlace <- c(
  "Prüfungsort", "Prüfungsraum", "Prüfungszeit",
  "Klausurzeit", "Klausurort", "MAP-Ort", "MAP-Zeit", 
  "MAP Ort", "MAP Zeit"
)
wordsPresence <- c("Präsenzprüfung", "Präsenzklausur")
wordsExam <- c(
  "Prüfung", "MAP", "Prüfungsregularien", "Prüfungsregeln", 
  "Prüfungsablauf", "Allgemeines zur Prüfung"   
)
wordsTeam <- c(
  "Note", "Notenbescheinigung", "Leistungsnachweis", 
  "Einsicht", "Klausureinsicht"
)


# Functions
start <- function(bot, update){
  bot$sendMessage(
    chat_id = update$message$chat_id,
    text = sprintf(
      paste0(
        "Hallo %s! \xF0\x9F\x99\x8B Ich bin der \xf0\x9f\xa4\x96 Bot der",
        " Professur für \xF0\x9F\x93\x88 Methoden am Institut für Politikwissenschaft.",
        " Ich habe gerade angefangen zu lernen und du kannst mir",
        " Fragen rund um die Professur stellen.",
        " Ich \xf0\x9f\xa4\x96 kann keine individuellen Fragen beantworten und der Chat", 
        " wird nicht von realen Personen gelesen. Teile",
        " hier keine vertraulichen Informationen wie deine Matrikelnummer,", 
        " JLU-Kennungen oder \xF0\x9F\x94\x90 Passwörter und Noten.", 
        "\nBitte beachte, dass ich \xf0\x9f\xa4\x96 dir nur automatisiert", 
        " antworten kann. Es kann sein, dass meine Antwort dir nicht weiterhilft.", 
        " Dann musst du eine E-Mail an das Team schreiben (team-abendschoen@sowi.uni-giessen.de)",
        " \xF0\x9F\x93\xA9. Um mich \xf0\x9f\xa4\x96 neu zu starten, schreibe",
        " /start \xF0\x9F\x94\x83.\n\nWomit kann ich dir helfen?",
        "\n\n\x31\xE2\x83\xA3 Fragen zu Prüfungen \xF0\x9F\x93\x8A",
        "\n\n\x32\xE2\x83\xA3 Sprechstunden \xF0\x9F\x93\x85",
        "\n\n\x33\xE2\x83\xA3 Thesis-Betreuungen \xF0\x9F\x8E\x93", 
        "\n\nAlternativ schreibe ein paar Stichwörter: z.B. Infos zu Simone Abendschön.",
        " Wenn ich einmal nicht weiter weiß, kannst du deine Anfrage spezifizieren.",
        " Schreibe zum Beispiel 'Prüfungsanmeldung' anstatt 'Anmeldung'."
      ),
      update$message$from$first_name
    ),
    reply_markup = keyStart
  )
}

start_handler <- CommandHandler("start", start)

case <- function(bot, update){
  text <- update$message$text
  
  if (text == "1" | text == "1." | text == "\x31\xE2\x83\xA3 Prüfungen" | (any(str_detect(string, regex(wordsExam, ignore_case =TRUE))))){
    text_caps <- paste0(
      "Du möchtest Informationen zu \x31\xE2\x83\xA3 Prüfungen bekommen.\n\n",
      "Welche Information benötigst du?\n\n",
      "\xF0\x9F\x9A\xA8 Wie melde ich mich zur Prüfung an?\n\n",
      "\xF0\x9F\x98\xB7 Was mache ich, wenn ich krank bin?\n\n",
      "\xF0\x9F\x95\x93 Wo findet die Klausur statt?\n\n",
      "\xF0\x9F\x94\x84 Ich bin durchgefallen. Was nun?\n\n",
      "\xF0\x9F\x9A\x8F Alles zu Präsenzprüfungen\n\n",
      "\xF0\x9F\x8C\x8F Alles zu Online-Prüfungen\n\n",
      "\xF0\x9F\x93\x9D Alles zu Hausarbeit, Ausarbeitungen oder Thesis \n\n",
      "\xF0\x9F\x93\x90 Alles zur Vorleistung\n\n",
      "\xF0\x9F\x94\x83 Mit /start kommst du wieder an den Anfang zurück!"
    )
    
    bot$sendMessage(
      chat_id = update$message$chat_id,
      text = text_caps,
      parse_mode = "Markdown",
      reply_markup = keyExams
    ) 
  } else if (text == "2" | text == "2." | text == "\x32\xE2\x83\xA3 Sprechstunden" | (any(str_detect(string, regex(wordsOffice, ignore_case =TRUE))))) {
    text_caps <- paste0(
      "Du möchtest Informationen zur \xF0\x9F\x93\x85 *Sprechstunde* haben.",
      " Hier sind sie:\n\nIm Team Methoden werden *alle* Sprechstunden-Termine",
      " *online* vergeben. Klicke auf den jeweiligen *Namen*, um zur Buchung",
      " einer Sprechstunde bei der gewählten Person zu kommen. Der Link führt",
      " entweder zu *Stud.IP* oder zu *ILIAS*:\n\n",
      "a) [Prof. Dr. Simone Abendschön](https://studip.uni-giessen.de/dispatch.php/consultation/overview?username=g31441)",
      "\n\nb) [Tim Schmidt](https://studip.uni-giessen.de/dispatch.php/consultation/overview?username=g32078)",
      "\n\nc) [Philipp Kleer](https://ilias.uni-giessen.de/ilias/goto.php?target=usr_172921&client_id=JLUG)\n\n",
      "\xF0\x9F\x94\x83 Mit /start kommst du wieder an den Anfang zurück!"
    )
    
    bot$sendMessage(
      chat_id = update$message$chat_id,
      text = text_caps,
      parse_mode = "Markdown",
      reply_markup = keyBack
    ) 
  } else if (text == "3" | text == "3." | text == "\x33\xE2\x83\xA3 Thesis" | (any(str_detect(string, regex(wordsThesis, ignore_case =TRUE))))){
    text_caps <- paste0(
      "Die \xF0\x9F\x8E\x93 *Thesis-Betreuung* (Bachelor/Master) ist grundsätzlich",
      " bei *allen Personen der Professur* möglich, bei Mitarbeiter:innen ohne",
      " Lehre ist die Verfügbarkeit allerdings eingeschränkt. Für Arbeiten im",
      " *Lehramt* (wiss. Hausarbeit sowie Staatsexamen) können *nur*",
      " *Prof. Dr. Simone Abendschön* (simone.abendschoen@sowi.uni-giessen.de)",
      " und *Tim Schmidt* (tim.schmidt@sowi.uni-giessen.de) angefragt werden!",
      "\n\nAm besten schaust du dir vorher auf den persönlichen Seiten der Personen", 
      " an der Professur an, welche Forschungsschwerpunkte diese haben und *welche*",
      " *Person am besten zu deinem geplanten Abschlussprojekt* passt. Wir haben",
      " [*hier*](https://ilias.uni-giessen.de/ilias/goto.php?target=dcl_261967&client_id=JLUG)",
      " eine Auswahl bisheriger Abschlussarbeiten \xF0\x9F\x93\x9A zur Übersicht zusammengestellt.\n\n",
      "Richte dich einfach direkt an die jeweilige Person (per E-Mail oder",
      " buche einen Termin in der \x32\xE2\x83\xA3 Sprechstunde) und stelle deine",
      " Idee vor.\n\nBitte beachten die geltenden Fristen im jeweiligen Studiengang:",
      " [Bachelor](https://www.uni-giessen.de/de/fbz/paemter/gwiss/studiengaenge/bachelor-studiengaenge/sosc)",
      ", [Master](https://www.uni-giessen.de/de/fbz/paemter/gwiss/studiengaenge/MA/ma-demokratie-und-governance)",
      " & [Lehramt](https://lehrkraefteakademie.hessen.de/ausbildung-von-lehrkraeften/erste-staatspruefung/pruefungsstellen/pruefungsstelle-giessen/pruefungsunterlagen)",
      "\n\nDu kannst zum Termin dann auch direkt das [Formular zur Thesis-Anmeldung](https://www.uni-giessen.de/de/fbz/paemter/gwiss/down)",
      " mitbringen.",
      "\n\n\xF0\x9F\x94\x83 Mit /start kommst du wieder an den Anfang zurück!"
    )
    
    bot$sendMessage(
      chat_id = update$message$chat_id,
      text = text_caps,
      parse_mode = "Markdown",
      reply_markup = keyBack
    )
  } else if  (text == "\xF0\x9F\x9A\xA8 Prüfungsanmeldung" | (any(str_detect(string, regex(wordsAnmeldung, ignore_case =TRUE))))) {
    text_caps <- paste0(
      "Für jede Prüfung musst du dich in *flexnow* anmelden. Beachte dazu, die",
      " unterschiedlichen [Anmeldefristen](https://www.uni-giessen.de/de/studium/waehrend/ecampus/flexnow/fristen) nach Studiengang.",
      "\n\n Hier findest du weitere Informationen: [Link ins FAQ](https://ilias.uni-giessen.de/goto.php?target=wiki_wpage_16915_261289&client_id=JLUG)"
    )
    
    bot$sendMessage(
      chat_id = update$message$chat_id,
      text = text_caps,
      parse_mode = "Markdown",
      reply_markup = keyBack
    )
  } else if  (text == "\xF0\x9F\x98\xB7 Attest/Krankheit" | (any(str_detect(string, regex(wordsIll, ignore_case =TRUE))))) {
    text_caps <- paste0(
      "Wenn du am Prüfungstag krank bist, musst du dich mit einem Attest beim",
      "Prüfungsamt krank melden. *E-Mails an uns reichen nicht aus!*",
      "\n\nDie Bescheinigung zur Prüfungsunfähigkeit findest du hier: [Link zum Prüfungsamt](https://www.uni-giessen.de/de/fbz/paemter/gwiss/down)",
      "\n\nWeitere Infos zum Thema Attest/Krankheit findest du in den [FAQs](https://ilias.uni-giessen.de/goto.php?target=wiki_wpage_16922_261289&client_id=JLUG)",
      "\n\n\xF0\x9F\x94\x83 Mit /start kommst du wieder an den Anfang zurück!"
    )
    
    bot$sendMessage(
      chat_id = update$message$chat_id,
      text = text_caps,
      parse_mode = "Markdown",
      reply_markup = keyBack
    )
  } else if  (text == "\xF0\x9F\x95\x93 Ort/Zeit Klausur" | (any(str_detect(string, regex(wordsPlace, ignore_case =TRUE))))) {
    text_caps <- paste0(
      "Alles rund um die Prüfungstermine \xF0\x9F\x95\x93 (Ort, Uhrzeit, etc.)",
      " findest du",
      " [hier](https://ilias.uni-giessen.de/goto.php?target=wiki_wpage_16915_261289&client_id=JLUG).",
      "\n\n\xF0\x9F\x94\x83 Mit /start kommst du wieder an den Anfang zurück!"
    )
    
    bot$sendMessage(
      chat_id = update$message$chat_id,
      text = text_caps,
      parse_mode = "Markdown",
      reply_markup = keyBack
    )
  } else if  (text == "\xF0\x9F\x94\x84 Wiederholungsprüfung" | (any(str_detect(string, regex(wordsFail, ignore_case =TRUE))))) {
    text_caps <- paste0(
      "Wenn du eine Prüfung wiederholen musst, musst du automatisch am nächsten Termin", 
      " teilnehmen. *Beachte*, dass du keine gesonderte Einladung bekommst. Du musst",
      " dich selbstständig über die nächsten Termine informieren!",
      "\n\nPrüfungstermine an unserer Professur findest du immer [hier](https://ilias.uni-giessen.de/goto.php?target=wiki_wpage_16931_261289&client_id=JLUG).",
      "\n\nWeitere Infos zur Prüfungswiederholung findest du im [FAQ](https://ilias.uni-giessen.de/goto.php?target=wiki_wpage_16923_261289&client_id=JLUG).",
      "\n\n\xF0\x9F\x94\x83 Mit /start kommst du wieder an den Anfang zurück!"
    )
    
    bot$sendMessage(
      chat_id = update$message$chat_id,
      text = text_caps,
      parse_mode = "Markdown",
      reply_markup = keyBack
    )
  } else if  (text == "\xF0\x9F\x9A\x8F Präsenzprüfung" | (any(str_detect(string, regex(wordsPresence, ignore_case =TRUE))))) {
    text_caps <- paste0(
      "Du schreibst eine Klausur bei uns und bist unsicher, wann die Prüfung beginnt?",
      "Oder du willst wissen, wie lange die Klausur dauert?",
      "\n\n\xE2\x9E\xA1 Dazu findest du im [FAQ](https://ilias.uni-giessen.de/goto.php?target=wiki_wpage_19185_261289&client_id=JLUG)",
      " der Professur. Sollte sich deine Fragen dort nicht beantworten, schreib",
      " uns eine \xF0\x9F\x93\xA9 E-Mail (team-abendschoen@sowi.uni-giessen.de).",
      "\n\n\xF0\x9F\x94\x83 Mit /start kommst du wieder an den Anfang zurück!"
    )
    
    bot$sendMessage(
      chat_id = update$message$chat_id,
      text = text_caps,
      parse_mode = "Markdown",
      reply_markup = keyBack
    )
  } else if  (text == "\xF0\x9F\x8C\x8F Online-Prüfung" | (any(str_detect(string, regex(wordsOnline, ignore_case =TRUE))))) {
    text_caps <- paste0(
      "Du schreibst eine \xF0\x9F\x8C\x8F Online-Prüfung (z.B. Open-Book-Test) bei uns und bist unsicher,",
      " wie diese abläuft?",
      "Oder du willst wissen, welche Funktionen es im Online-Test gibt?",
      "\n\n\xE2\x9E\xA1 Dazu findest du im [FAQ](https://ilias.uni-giessen.de/goto.php?target=wiki_wpage_19186_261289&client_id=JLUG)",
      " der Professur. Sollte sich deine Fragen dort nicht beantworten, schreib",
      " uns eine \xF0\x9F\x93\xA9 E-Mail (team-abendschoen@sowi.uni-giessen.de).",
      "\n\n\xF0\x9F\x94\x83 Mit /start kommst du wieder an den Anfang zurück!"
    )
    
    bot$sendMessage(
      chat_id = update$message$chat_id,
      text = text_caps,
      parse_mode = "Markdown",
      reply_markup = keyBack
    )
  } else if  (text == "\xF0\x9F\x93\x9D Hausarbeit" | (any(str_detect(string, regex(wordsWritten, ignore_case =TRUE))))) {
    text_caps <- paste0(
      "Du schreibst eine \xF0\x9F\x93\x9D Hausarbeit, Ausarbeit oder Seminararbeit bei uns und bist unsicher,",
      " wie hoch der Seitenumfang ist?",
      "Oder du willst wissen, welche Abgabefristen es gibt?",
      "\n\n\xE2\x9E\xA1 Dazu findest du im [FAQ](https://ilias.uni-giessen.de/goto.php?target=wiki_wpage_19187_261289&client_id=JLUG)",
      " der Professur. Sollte sich deine Fragen dort nicht beantworten, schreib",
      " uns eine \xF0\x9F\x93\xA9 E-Mail (team-abendschoen@sowi.uni-giessen.de).",
      "\n\n\xF0\x9F\x94\x83 Mit /start kommst du wieder an den Anfang zurück!"
    )
    
    bot$sendMessage(
      chat_id = update$message$chat_id,
      text = text_caps,
      parse_mode = "Markdown",
      reply_markup = keyBack
    )
  } else if  (text == "\xF0\x9F\x93\x90 Vorleistung" | text == "Vorleistung") {
    text_caps <- paste0(
      "Du bist gerade in einem Kurs an unserer Professur und musst eine Vorleistung",
      " erbringen?",
      "\n\n\xE2\x9E\xA1 Dazu findest du im [FAQ](https://ilias.uni-giessen.de/goto.php?target=wiki_wpage_19188_261289&client_id=JLUG)",
      " der Professur. Sollte sich deine Fragen dort nicht beantworten, schreib",
      " uns eine \xF0\x9F\x93\xA9 E-Mail (team-abendschoen@sowi.uni-giessen.de).",
      "\n\n\xF0\x9F\x94\x83 Mit /start kommst du wieder an den Anfang zurück!"
    )
    
    bot$sendMessage(
      chat_id = update$message$chat_id,
      text = text_caps,
      parse_mode = "Markdown",
      reply_markup = keyBack
    )
  } else if  (any(str_detect(string, regex(wordsSimone, ignore_case =TRUE)))) {
    text_caps <- paste0(
      "Prof. Dr. Simone Abendschön leitet unser Team und ist die Professorin.",
      "Sie lehrt in allen Studiengängen und betreut auch alle verschiedenen",
      " Abschlussarbeiten. Dazu ist sie Studiengangsverantwortliche für den",
      " BA Social Sciences.",
      "\n\Hier kannst du einen Termin in der [Sprechstunde von Simone Abendschön](https://studip.uni-giessen.de/dispatch.php/consultation/overview?username=g31441)",
      " buchen. Auf der [Website](https://www.uni-giessen.de/de/fbz/fb03/institutefb03/ifp/Lehrende_Team/Professor_innen/abendschoen/index)",
      " findest du weitere \xE2\x84\xB9 Informationen sowie \xF0\x9F\x93\xA8 Kontaktdaten zur Person."
    )
    
    bot$sendMessage(
      chat_id = update$message$chat_id,
      text = text_caps,
      parse_mode = "Markdown",
      reply_markup = keyBack
    )
  } else if  (any(str_detect(string, regex(wordsTim, ignore_case =TRUE)))) {
    text_caps <- paste0(
      "Tim Schmidt ist wissenschaftlicher Mitarbeiter an der Professur",
      " und lehrt in den Studiengängen am Institut. Er betreut sowohl Bachelor-/Masterarbeiten",
      " als auch Staatsexamen (bzw. WHA).",
      "\n\Hier kannst du einen Termin in der [Sprechstunde von Tim Schmidt](https://studip.uni-giessen.de/dispatch.php/consultation/overview?username=g32078)",
      " buchen. Auf der [Website](https://www.uni-giessen.de/de/fbz/fb03/institutefb03/ifp/Lehrende_Team/Mitarbeiter_innen/schmidt)",
      " findest du weitere \xE2\x84\xB9 Informationen sowie \xF0\x9F\x93\xA8 Kontaktdaten zur Person."
    )
    
    bot$sendMessage(
      chat_id = update$message$chat_id,
      text = text_caps,
      parse_mode = "Markdown",
      reply_markup = keyBack
    )
  } else if  (any(str_detect(string, regex(wordsPhil, ignore_case =TRUE)))) {
    text_caps <- paste0(
      "Philipp Kleer ist wissenschaftlicher Mitarbeiter an der Professur",
      " und forscht im Projekt G-EPIC. Auf Anfrage betreut er ebenfalls Bachelor- und Masterarbeiten.",
      "\n\Hier kannst du einen Termin in der [Sprechstunde von Philipp Kleer](https://ilias.uni-giessen.de/ilias/goto.php?target=usr_172921&client_id=JLUG)",
      " buchen. Weitere \xE2\x84\xB9 Informationen sowie \xF0\x9F\x93\xA8 Kontaktdaten zur Person findest du auf der",
      " [JLU-Website](https://www.uni-giessen.de/de/fbz/fb03/institutefb03/ifp/Lehrende_Team/Mitarbeiter_innen/kleer)",
      " oder [hier](https://www.bpkleer.de)."
    )
    
    bot$sendMessage(
      chat_id = update$message$chat_id,
      text = text_caps,
      parse_mode = "Markdown",
      reply_markup = keyBack
    )
  } else if  (any(str_detect(string, regex(wordsPatricia, ignore_case =TRUE)))) {
    text_caps <- paste0(
      "Patricia Kamper ist wissenschaftliche Mitarbeiterin an der Professur",
      " und forscht im Projekt 'Demokratie leben lernen 2.0'.",
      " buchen. Weitere \xE2\x84\xB9 Informationen sowie \xF0\x9F\x93\xA8 Kontaktdaten zur Person findest du auf der",
      " [JLU-Website](https://www.uni-giessen.de/de/fbz/fb03/institutefb03/ifp/Lehrende_Team/Mitarbeiter_innen/kamper)."
    )
    
    bot$sendMessage(
      chat_id = update$message$chat_id,
      text = text_caps,
      parse_mode = "Markdown",
      reply_markup = keyBack
    )
  } else if  (any(str_detect(string, regex(wordsMical, ignore_case =TRUE)))) {
    text_caps <- paste0(
      "Mical Gerezgiher ist wissenschaftliche Mitarbeiterin an der Professur",
      " und forscht im Projekt 'Demokratie leben lernen 2.0'.",
      " buchen. Weitere \xE2\x84\xB9 Informationen sowie \xF0\x9F\x93\xA8 Kontaktdaten zur Person findest du auf der",
      " [JLU-Website](https://www.uni-giessen.de/de/fbz/fb03/institutefb03/ifp/Lehrende_Team/Mitarbeiter_innen/gerezgiher)."
    )
    
    bot$sendMessage(
      chat_id = update$message$chat_id,
      text = text_caps,
      parse_mode = "Markdown",
      reply_markup = keyBack
    )
  } else if  (any(str_detect(string, regex(wordsAngelika, ignore_case =TRUE)))) {
    text_caps <- paste0(
      "Angelika Wicke ist die Sekretärin an der Professur.",
      " Bei allgemeinen Anfragen kannst du dich zuerst an Sie wenden oder eine",
      " E-Mail an die Team-Adresse schicken (team-abendschoen@sowi.uni-giessen.de).",
      " Weitere \xE2\x84\xB9 Informationen sowie \xF0\x9F\x93\xA8 Kontaktdaten zur Person findest du auf der",
      " [JLU-Website](https://www.uni-giessen.de/de/fbz/fb03/institutefb03/ifp/Lehrende_Team/Sekretaerinnen/wicke)."
    )
    
    bot$sendMessage(
      chat_id = update$message$chat_id,
      text = text_caps,
      parse_mode = "Markdown",
      reply_markup = keyBack
    )
  } else if  (any(str_detect(string, regex(wordsTeam, ignore_case =TRUE)))) {
    text_caps <- paste0(
      "Für Notenanfragen, Leistungsnachweise, Prüfungseinsichten bzw. allen Anfragen",
      " rund ums \xF0\x9F\x8E\x93 Prüfen, wende dich bitte per \xF0\x9F\x93\xA9 E-Mail",
      " an team-abendschoen@sowi.uni-giessen.de !",
      "\n\nBeachte, dass nur E-Mails von Uni-Accounts beantworten werden dürfen.",
      " Denke daran, alle wichtigen Infos in die E-Mail zu schreiben: Prüfung,",
      " Semester, Dozent:in und deine Matrikelnummer."
      "\n\nIn der Regel erhältst du innerhalb einer Woche eine Antwort."
    )
    
    bot$sendMessage(
      chat_id = update$message$chat_id,
      text = text_caps,
      parse_mode = "Markdown",
      reply_markup = keyBack
    )
  } else {
    text_caps = paste0(
      "Hierauf habe ich leider noch keine Antwort!\n\n", 
      " versuche ein anderes Stichwort oder Befehl. Alternativ schreibe eine",
      " E-Mail mit deinem Anliegen an team-abendschoen@sowi.uni-giessen.de !"
      "\xF0\x9F\x94\x83 Mit /start kommst du wieder an den Anfang zurück!"
    )
    
    bot$sendMessage(
      chat_id = update$message$chat_id, 
      text = text_caps,
      reply_markup = keyBack
    )
  }
}

unknown <- function(bot, update){
  bot$sendMessage(
    chat_id = update$message$chat_id,
    text = paste0(
      "\xF0\x9F\x98\xAD Entschuldige, aber diesen Befehl habe ich noch nicht",
      " gelernt. \xF0\x9F\x98\xA5"
    ),
    reply_markup = keyBack
  )
}

updater <- updater + start_handler
updater <- updater + MessageHandler(case, MessageFilters$text)
updater <- updater + MessageHandler(unknown, MessageFilters$command)

# Start Bot
updater$start_polling()
