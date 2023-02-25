###################################################################
#                                                                 #
# Author: B. Philipp Kleer                                        #
# Credits: https://github.com/ebeneditos/telegram.bot             #
#                                                                 #
###################################################################

# For use of this, see README.MD

# > Loading libraries ----
library("telegram.bot")
library("tidyverse")

# > Custom keyboard replies ----
# with these lists we adjust keyboard responses in telegram
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

# > Custom keywords as Strings ----
# each lists represents a case for an answer, keywords are sorted by the last
# name of the keywords object, e.g. simone.csv for wordsSimone etc. 
# answers to this keywords are also sorted by the last name, e.g., simone.txt
# for cases of wordsSimone
# Sometimes emojis are included by Byte-definition
# Persons
wordsSimone <- read.csv(
  "./keys/simone.csv",
  sep = "\n",
  header = TRUE
  )[[1]]

wordsPhil <- read.csv(
  "./keys/philipp.csv",
  sep = "\n",
  header = TRUE
)[[1]]

wordsTim <- read.csv(
  "./keys/tim.csv",
  sep = "\n",
  header = TRUE
)[[1]]

wordsPatricia <- read.csv(
  "./keys/patricia.csv",
  sep = "\n",
  header = TRUE
)[[1]]

wordsMical <- read.csv(
  "./keys/mical.csv",
  sep = "\n",
  header = TRUE
)[[1]]

wordsAngelika <- read.csv(
  "./keys/angelika.csv",
  sep = "\n",
  header = TRUE
)[[1]]

# Three main categories
wordsExam <- read.csv(
  "./keys/exam.csv",
  sep = "\n",
  header = TRUE
)[[1]]

wordsOffice <- read.csv(
  "./keys/office.csv",
  sep = "\n",
  header = TRUE
)[[1]]

wordsThesis <- read.csv(
  "./keys/thesis.csv",
  sep = "\n",
  header = TRUE
)[[1]]

# Subcategory Exams
wordsOnline <- read.csv(
  "./keys/online.csv",
  sep = "\n",
  header = TRUE
)[[1]]

wordsRegistration <- read.csv(
  "./keys/registration.csv",
  sep = "\n",
  header = TRUE
)[[1]]

wordsIll <- read.csv(
  "./keys/ill.csv",
  sep = "\n",
  header = TRUE
)[[1]]

wordsFail <- read.csv(
  "./keys/fail.csv",
  sep = "\n",
  header = TRUE
)[[1]]

wordsWritten <- read.csv(
  "./keys/written.csv",
  sep = "\n",
  header = TRUE
)[[1]]

wordsPlace <- read.csv(
  "./keys/place.csv",
  sep = "\n",
  header = TRUE
)[[1]]

wordsPresence <- read.csv(
  "./keys/presence.csv",
  sep = "\n",
  header = TRUE
)[[1]]

wordsGrade <- read.csv(
  "./keys/grade.csv",
  sep = "\n",
  header = TRUE
)[[1]]

wordsPreexam <- read.csv(
  "./keys/preexam.csv",
  sep = "\n",
  header = TRUE
)[[1]]

# Additional 
wordsTut <- read.csv(
  "./keys/tut.csv",
  sep = "\n",
  header = TRUE
)[[1]]

wordsTeaching <- read.csv(
  "./keys/teaching.csv",
  sep = "\n",
  header = TRUE
)[[1]]

# > Starting Updater ----
# usethis::edit_r_environ("project")
# this should be in .Renviron file bot_token() function
updater <- Updater(token = bot_token("RTelegramBot"))

# > Functions ----
start <- function(bot, update){
  bot$sendMessage(
    chat_id = update$message$chat_id,
    text = sprintf(
      paste0(
        readLines(
          "./texts/start.txt",
          encoding = "UTF-8"
        ),
        collapse = "\n"
      ),
      update$message$from$first_name
    ),
    reply_markup = keyStart
  )
}

case <- function(bot, update){
  text <- update$message$text
  
  if ((any(str_detect(text, regex(wordsExam, ignore_case = TRUE))))){
    text_caps <- paste0(
      readLines(
        "./texts/exam.txt",
        encoding = "UTF-8"
      ),
      collapse = "\n"
    )
      
    bot$sendMessage(
      chat_id = update$message$chat_id,
      text = text_caps,
      parse_mode = "Markdown",
      reply_markup = keyExams
    ) 
  } else if ((any(str_detect(text, regex(wordsOffice, ignore_case = TRUE))))) {
    text_caps <- paste0(
      readLines(
        "./texts/office.txt",
        encoding = "UTF-8"
      ),
      collapse = "\n"
    )
    
    bot$sendMessage(
      chat_id = update$message$chat_id,
      text = text_caps,
      parse_mode = "Markdown",
      reply_markup = keyBack
    ) 
  } else if ((any(str_detect(text, regex(wordsThesis, ignore_case =TRUE))))){
    text_caps <- paste0(
      readLines(
        "./texts/thesis.txt",
        encoding = "UTF-8"
      ),
      collapse = "\n"
    )
    
    bot$sendMessage(
      chat_id = update$message$chat_id,
      text = text_caps,
      parse_mode = "Markdown",
      reply_markup = keyBack
    )
  } else if  ((any(str_detect(text, regex(wordsRegistration, ignore_case =TRUE))))) {
    text_caps <- paste0(
      readLines(
        "./texts/registration.txt",
        encoding = "UTF-8"
      ),
      collapse = "\n"
    )
    
    bot$sendMessage(
      chat_id = update$message$chat_id,
      text = text_caps,
      parse_mode = "Markdown",
      reply_markup = keyBack
    )
  } else if  ((any(str_detect(text, regex(wordsIll, ignore_case =TRUE))))) {
    text_caps <- paste0(
      readLines(
        "./texts/ill.txt",
        encoding = "UTF-8"
      ),
      collapse = "\n"
    )
    
    bot$sendMessage(
      chat_id = update$message$chat_id,
      text = text_caps,
      parse_mode = "Markdown",
      reply_markup = keyBack
    )
  } else if  ((any(str_detect(text, regex(wordsPlace, ignore_case =TRUE))))) {
    text_caps <- paste0(
      readLines(
        "./texts/place.txt",
        encoding = "UTF-8"
      ),
      collapse = "\n"
    )
    
    bot$sendMessage(
      chat_id = update$message$chat_id,
      text = text_caps,
      parse_mode = "Markdown",
      reply_markup = keyBack
    )
  } else if  ((any(str_detect(text, regex(wordsFail, ignore_case =TRUE))))) {
    text_caps <- paste0(
      readLines(
        "./texts/fail.txt",
        encoding = "UTF-8"
      ),
      collapse = "\n"
    )
    
    bot$sendMessage(
      chat_id = update$message$chat_id,
      text = text_caps,
      parse_mode = "Markdown",
      reply_markup = keyBack
    )
  } else if  ((any(str_detect(text, regex(wordsPresence, ignore_case =TRUE))))) {
    text_caps <- paste0(
      readLines(
        "./texts/presence.txt",
        encoding = "UTF-8"
      ),
      collapse = "\n"
    )
    
    bot$sendMessage(
      chat_id = update$message$chat_id,
      text = text_caps,
      parse_mode = "Markdown",
      reply_markup = keyBack
    )
  } else if  ((any(str_detect(text, regex(wordsOnline, ignore_case =TRUE))))) {
    text_caps <- paste0(
      readLines(
        "./texts/online.txt",
        encoding = "UTF-8"
      ),
      collapse = "\n"
    )
    
    bot$sendMessage(
      chat_id = update$message$chat_id,
      text = text_caps,
      parse_mode = "Markdown",
      reply_markup = keyBack
    )
  } else if  ((any(str_detect(text, regex(wordsWritten, ignore_case =TRUE))))) {
    text_caps <- paste0(
      readLines(
        "./texts/written.txt",
        encoding = "UTF-8"
      ),
      collapse = "\n"
    )
    
    bot$sendMessage(
      chat_id = update$message$chat_id,
      text = text_caps,
      parse_mode = "Markdown",
      reply_markup = keyBack
    )
  } else if  (any(str_detect(text, regex(wordsPreexam, ignore_case =TRUE)))) {
    text_caps <- paste0(
      readLines(
        "./texts/preexam.txt",
        encoding = "UTF-8"
      ),
      collapse = "\n"
    )
    
    bot$sendMessage(
      chat_id = update$message$chat_id,
      text = text_caps,
      parse_mode = "Markdown",
      reply_markup = keyBack
    )
  } else if  (any(str_detect(text, regex(wordsSimone, ignore_case =TRUE)))) {
    text_caps <- paste0(
      readLines(
        "./texts/simone.txt",
        encoding = "UTF-8"
      ),
      collapse = "\n"
    )
    
    bot$sendMessage(
      chat_id = update$message$chat_id,
      text = text_caps,
      parse_mode = "Markdown",
      reply_markup = keyBack
    )
  } else if  (any(str_detect(text, regex(wordsTim, ignore_case =TRUE)))) {
    text_caps <- paste0(
      readLines(
        "./texts/tim.txt",
        encoding = "UTF-8"
      ),
      collapse = "\n"
    )
    
    bot$sendMessage(
      chat_id = update$message$chat_id,
      text = text_caps,
      parse_mode = "Markdown",
      reply_markup = keyBack
    )
  } else if  (any(str_detect(text, regex(wordsPhil, ignore_case =TRUE)))) {
    text_caps <- paste0(
      readLines(
        "./texts/philipp.txt",
        encoding = "UTF-8"
      ),
      collapse = "\n"
    )
    
    bot$sendMessage(
      chat_id = update$message$chat_id,
      text = text_caps,
      parse_mode = "Markdown",
      reply_markup = keyBack
    )
  }  else if  (any(str_detect(text, regex(wordsPatricia, ignore_case =TRUE)))) {
    text_caps <- paste0(
      readLines(
        "./texts/patricia.txt",
        encoding = "UTF-8"
      ),
      collapse = "\n"
    )
    
    bot$sendMessage(
      chat_id = update$message$chat_id,
      text = text_caps,
      parse_mode = "Markdown",
      reply_markup = keyBack
    )
  } else if  (any(str_detect(text, regex(wordsMical, ignore_case =TRUE)))) {
    text_caps <- paste0(
      readLines(
        "./texts/mical.txt",
        encoding = "UTF-8"
      ),
      collapse = "\n"
    )
    
    bot$sendMessage(
      chat_id = update$message$chat_id,
      text = text_caps,
      parse_mode = "Markdown",
      reply_markup = keyBack
    )
  } else if  (any(str_detect(text, regex(wordsAngelika, ignore_case =TRUE)))) {
    text_caps <- paste0(
      readLines(
        "./texts/angelika.txt",
        encoding = "UTF-8"
      ),
      collapse = "\n"
    )
    
    bot$sendMessage(
      chat_id = update$message$chat_id,
      text = text_caps,
      parse_mode = "Markdown",
      reply_markup = keyBack
    )
  } else if  (any(str_detect(text, regex(wordsGrade, ignore_case =TRUE)))) {
    text_caps <- paste0(
      readLines(
        "./texts/grade.txt",
        encoding = "UTF-8"
      ),
      collapse = "\n"
    )
    
    bot$sendMessage(
      chat_id = update$message$chat_id,
      text = text_caps,
      parse_mode = "Markdown",
      reply_markup = keyBack
    )
  } else if ((any(str_detect(text, regex(wordsTeaching, ignore_case =TRUE))))){
    text_caps <- paste0(
      readLines(
        "./texts/teaching.txt",
        encoding = "UTF-8",
        warn = FALSE
      ),
      collapse = "\n"
    )
    
    bot$sendMessage(
      chat_id = update$message$chat_id,
      text = text_caps,
      parse_mode = "Markdown",
      reply_markup = keyBack
    ) 
  } else if ((any(str_detect(text, regex(wordsTut, ignore_case =TRUE))))){
    text_caps <- paste0(
      readLines(
        "./texts/tut.txt",
        encoding = "UTF-8",
        warn = FALSE
      ),
      collapse = "\n"
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
      " E-Mail mit deinem Anliegen an team-abendschoen@sowi.uni-giessen.de !",
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
      readLines(
        "./texts/unknown.txt",
        encoding = "UTF-8",
        warn = FALSE
      ),
      collapse = "\n"
    ),
    reply_markup = keyBack
  )
}

# > Loading Functions ----
start_handler <- CommandHandler("start", start)
updater <- updater + start_handler
updater <- updater + MessageHandler(case, MessageFilters$text)
updater <- updater + MessageHandler(unknown, MessageFilters$command)

# > Start Bot ----
updater$start_polling()

