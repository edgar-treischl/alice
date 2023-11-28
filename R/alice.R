library(copycat)
library(tidyverse)



library(rvest)
#pr_site <- "https://alice-weidel.de/bundestagsreden/"

# read_html reads the website
#pr_html <- read_html(pr_site)

# textraw <- pr_html |> html_elements("p") |>
#   html_text2()
# 
# 
# 
# dates_raw <- str_sub(textraw, start = 1L, end = 10L)
# dates <- dates_raw[1:17]
# dates
# 
# dates <- lubridate::dmy(dates)


#datapasta::vector_paste_vertical(dates)
dates_v <- c("2023-07-07",
              "2023-06-22",
              "2023-02-08",
              "2022-01-26",
              "2022-02-27",
              "2022-03-17",
              "2022-04-07",
              "2022-05-19",
              "2022-06-01",
              "2022-09-07",
              "2021-02-11",
              "2021-04-16",
              "2021-06-24",
              "2021-08-25",
              "2021-09-07",
              "2021-12-07",
              "2021-12-15")

#Topics

topics <- c(
  "Beschluss des Bundesverfassungsgerichts zum Gebäudeenergiegesetz",
  "Regierungserklärung zum EU-Rat",
  "Regierungserklärung zum außergewöhnlichen EU-Rat",
  "Vereinbarte Debatte zur SARS-CoV-2-Impfpflicht",
  "Abgabe einer Regierungserklärung durch den Bundeskanzler zur aktuellen Lage",
  "Impfpficht gegen SARS-CoV-2",
  "Impfpflicht gegen SARS-CoV-2",
  "Regierungserklärung zum Außerordentlichen Europäischen Rat am 30./31. Mai 2022",
  "Bundeskanzler und Bundeskanzleramt, Unabhängiger Kontrollrat",
  "Bundeskanzler und Bundeskanzleramt",
  "Regierungserklärung zur Bewältigung der COVID-19-Pandemie",
  "Bevölkerungsschutzgesetz",
  "Regierungserklärung zum Europäischen Rat",
  "Sondervermögen Aufbauhilfe 2021",
  "Vereinbarte Debatte zur Situation in Deutschland",
  "Impfprävention gegen COVID-19",
  "Regierungserklärung durch den Bundeskanzler")



weidel_data <- tidyr::tibble(datum = dates_v, 
           themen = topics)

weidel_data

#Create one file
library(readr)
library(stringr)



# weidel_test <- read_csv("~/Downloads/txt/17.03.2022.txt", col_names = "Rede")
# 
# weidel_test <- as.vector(weidel_test$Rede)
# 
# 
# weidel_test <- stringr::str_flatten(weidel_test, collapse = " ")
# weidel_test
# 
# df <- data.frame(time = "2022 17 03",
#            rede = weidel_test)
# 
# is.data.frame(df)

#readr::write_csv(df, "reden.csv")
#readr::write_csv(df, "reden.csv", append = TRUE)



all_weidels <- list.files()
real_weidels <- sub('\\.txt$', '', all_weidels) 

for (x in all_weidels) {
  df <- read_csv(x, col_names = "Rede")
  df <- as.vector(df$Rede)
  df <- stringr::str_flatten(df, collapse = " ")
  df <- data.frame(time = x,
                   rede = df)
  readr::write_csv(df, "reden.csv", append = TRUE)
  
}

head(df)

reden <- read_csv("reden.csv", col_names = FALSE)
str(reden)

reden <- reden |> rename(datum = X1,
                rede = X2) 


reden$datum <- sub('\\.txt$', '', reden$datum) 

reden$datum <- lubridate::ymd(reden$datum)




weidel_df <- left_join(weidel_data, reden, by = "datum")
weidel_df



