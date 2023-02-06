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

start <- function(bot, update){
  bot$sendMessage(
    chat_id = update$message$chat_id,
    text = sprintf(
      paste0(
        "Hallo %s! \xF0\x9F\x99\x8B Willkommen beim Bot der",
        " Professur für Methoden an der JLU. In diesem Bot kannst",
        " du Fragen rund um die Lehre stellen.",
        " Dieser Bot kann keine individuellen Fragen beantworten und teile",
        " hier keine vertraulichen Informationen wie deine Matrikelnummer,", 
        " JLU-Kennungen oder Passwörter und Noten", 
        "\nBitte beachte, dass der Bot dir automatisiert nur auf die", 
        " eingschränkte Auswahl antworten kann. Wenn der Bot dir nicht",
        " weiterhelfen kann, schreib uns eine E-Mail (team-abendschoen@sowi.uni-giessen.de)",
        " \xF0\x9F\x93\xA9. Um den Bot neu zu starten, schreibe",
        " /start \xF0\x9F\x94\x83.\n\n Womit können wir dir helfen?",
        "\n\n\x31\xE2\x83\xA3 Fragen zu Prüfungen \xF0\x9F\x93\x8A",
        "\n\n\x32\xE2\x83\xA3 Sprechstunden \xF0\x9F\x93\x85",
        "\n\n\x33\xE2\x83\xA3 Thesis-Betreuungen \xF0\x9F\x8E\x93"
      ),
      update$message$from$first_name
    ),
    reply_markup = keyStart
  )
}

start_handler <- CommandHandler("start", start)

case <- function(bot, update){
  text <- update$message$text
  
  if (text == "1" | text == "1." | text == "Prüfung" | text == "Prüfungen" | text == "\x31\xE2\x83\xA3 Prüfungen"){
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
  } else if (text == "2" | text == "2." | text == "Sprechstunde" | text == "\x32\xE2\x83\xA3 Sprechstunden") {
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
  } else if (text == "3" | text == "3." | text == "Thesis" | text == "Abschlussarbeit" | text == "\x33\xE2\x83\xA3 Thesis"){
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
      "\n\n Du kannst zum Termin dann auch direkt das [Formular zur Thesis-Anmeldung](https://www.uni-giessen.de/de/fbz/paemter/gwiss/down)",
      " mitbringen.",
      "\n\n\xF0\x9F\x94\x83 Mit /start kommst du wieder an den Anfang zurück!"
    )
    
    bot$sendMessage(
      chat_id = update$message$chat_id,
      text = text_caps,
      parse_mode = "Markdown",
      reply_markup = keyBack
    )
  } else if  (text == "\xF0\x9F\x9A\xA8 Prüfungsanmeldung" | text == "Prüfungsanmeldung" | text == "Anmeldung") {
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
  } else if  (text == "\xF0\x9F\x98\xB7 Attest/Krankheit" | text == "Attest" | text == "Krankheit") {
    text_caps <- paste0(
      "Wenn du am Prüfungstag krank bist, musst du dich mit einem Attest beim",
      "Prüfungsamt krank melden. *E-Mails an uns reichen nicht aus!*",
      "\n\nDie Bescheinigung zur Prüfungsunfähigkeit findest du hier: [Link zum Prüfungsamt](https://www.uni-giessen.de/de/fbz/paemter/gwiss/down)",
      "\n\nWeitere Infos zum Thema Attest/Krankheit findest du in den [FAQs](https://ilias.uni-giessen.de/goto.php?target=wiki_wpage_16922_261289&client_id=JLUG)"
      "\n\n\xF0\x9F\x94\x83 Mit /start kommst du wieder an den Anfang zurück!"
    )
    
    bot$sendMessage(
      chat_id = update$message$chat_id,
      text = text_caps,
      parse_mode = "Markdown",
      reply_markup = keyBack
    )
  } else if  (text == "\xF0\x9F\x95\x93 Ort/Zeit Klausur" | text == "Ort" | text == "Zeit") {
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
  } else if  (text == "\xF0\x9F\x94\x84 Wiederholungsprüfung" | text == "Durchgefallen" | text == "Wiederholungsprüfung") {
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
  } else if  (text == "\xF0\x9F\x9A\x8F Präsenzprüfung" | text == "Präsenzprüfung" | text == "Präsenz") {
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
  } else if  (text == "\xF0\x9F\x8C\x8F Online-Prüfung" | text == "Onlineprüfung" | text == "Online" | text == "Online-Prüfung") {
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
  } else if  (text == "\xF0\x9F\x93\x9D Hausarbeit" | text == "Hausarbeit" | text == "Ausarbeitung" | text == "Seminararbeit" ) {
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
  } else {
    text_caps = paste0(
      "Hierauf habe ich leider noch keine Antwort!\n\n", 
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
      "\xF0\x9F\x98\xAD Entschuldige, aber diesen Befehl habe ich nicht",
      " verstanden. \xF0\x9F\x98\xA5"
    ),
    reply_markup = keyBack
  )
}

updater <- updater + start_handler
updater <- updater + MessageHandler(case, MessageFilters$text)
updater <- updater + MessageHandler(unknown, MessageFilters$command)

# Start Bot
updater$start_polling()
