###################################################################
#                                                                 #
# Author: B. Philipp Kleer                                        #
# Credits: https://github.com/ebeneditos/telegram.bot             #
#                                                                 #
###################################################################

# > Libraries ----
library("tidyverse")

# > Creating function ----
check_keyword <- function(keyword) {
  if (!is.character(keyword)) {
    print("Keyword muss String sein!")
  } else {
    tbl <-
      list.files(
        path = "./keys/",
        pattern = "*.csv"
      ) %>% 
      map_df(
        ~read_csv(
          paste0("./keys/", .),
          col_types = cols(.default = "c")
        )
      )
    
    found <- c()
    
    for (j in 1:dim(tbl)[2]) {
      for (i in 1:dim(tbl)[1]) {
        if (is.na(tbl[[j]][i])) {
          next
        } else if (str_detect(tbl[[j]][i], regex(keyword, ignore_case = TRUE))) {
          found <- c(
            found,
            colnames(tbl[j])
          )
        } else {
          next
        }
      }
    }
    
    # dismissing double entries
    found <- str_unique(found)
    
    # remove 'words'
    found <- str_replace(
      found, 
      "words", 
      ""
    )
    
    found <- str_to_lower(found)
    
    str_sub(found, -1, -1) <- paste0(str_sub(found, -1, -1),".csv"); test
    
    
    print(
      paste0(
        "Your keyword was found in the following keywords-list(s) at least once: ", 
        str_c(found, collapse = ", ")
      )
    )
  }
}
  
# > Check keyword ----
# just put a word as argument in the function (e.g. "Prüfung")
# returns, in which lists the keyword is present
# the function returns also lists that combined the word
# (like in "Wiederholungsprüfung")
check_keyword("Prüfung")
