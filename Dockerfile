FROM rocker/tidyverse:latest

## create directories
RUN mkdir -p /telegramBot

## copy files
COPY /telegramBot/install.R /telegramBot/install.R
COPY /telegramBot/init.R /telegramBot/init.R
COPY .Renviron .Renviron

## install R-packages
RUN Rscript /telegramBot/install.R
CMD Rscript /telegramBot/init.R
