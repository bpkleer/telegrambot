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
    list(KeyboardButton("\xF0\x9F\x85\xB0 \xF0\x9F\x95\x93 Ort/Zeit Prüfung")),
    list(KeyboardButton("\xF0\x9F\x85\xB1 \xF0\x9F\x9A\x8F Prüfungsregularien")),
    list(KeyboardButton("/start"))
  )
)

keyBack <- ReplyKeyboardMarkup(
  keyboard = list(
    list(KeyboardButton("/start"))
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
      "\xF0\x9F\x85\xB0 \xF0\x9F\x95\x93 Wann und wo findet die Prüfung statt?\n\n",
      "\xF0\x9F\x85\xB1 \xF0\x9F\x9A\x8F Wie läuft die Prüfung ab? Welche Regularien gibt es?",
      " (Krankheit, Wiederholungsprüfung, Vorleistung)",
      "\n\n\xF0\x9F\x94\x83 Mit /start kommst du wieder an den Anfang zurück!"
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
  } else if  (text == "A" | text == "a" | text == "\xF0\x9F\x85\xB0" | text == "\xF0\x9F\x85\xB0 \xF0\x9F\x95\x93 Ort/Zeit Prüfung") {
    text_caps <- paste0(
      "Alles rund um die Prüfungstermine \xF0\x9F\x95\x93 (Ort, Uhrzeit, etc.)",
      " findest du",
      " [hier](https://ilias.uni-giessen.de/goto.php?target=wiki_wpage_16931_261601&client_id=JLUG).",
      "\n\n\xF0\x9F\x94\x83 Mit /start kommst du wieder an den Anfang zurück!"
    )
    
    bot$sendMessage(
      chat_id = update$message$chat_id,
      text = text_caps,
      parse_mode = "Markdown",
      reply_markup = keyBack
    )
  } else if  (text == "B" | text == "b" | text == "\xF0\x9F\x85\xB1" | text == "\xF0\x9F\x85\xB1 \xF0\x9F\x9A\x8F Prüfungsregularien") {
    text_caps <- paste0(
      "Alles rund um \xF0\x9F\x9A\x8F Prüfungen findest du in unserem",
      " \xF0\x9F\x93\x9D [Wiki](https://ilias.uni-giessen.de/goto.php?target=wiki_wpage_16910_261601&client_id=JLUG).\n\n",
      "Sollte sich deine Frage \xE2\x9D\x93 nicht klären, schreib eine \xF0\x9F\x93\xA9 E-Mail an",
      " team-abendschoen@sowi.uni-giessen.de!",
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
