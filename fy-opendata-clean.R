
# BRINGING TOGETHER THE CODES AND LABELS FOR THE WAVE 1-5 COMBINED FOOD AND YOU DATA

library(tidyverse)
library(readxl)
library(httr)

# import data

dataurl <- "https://fsa-catalogue2.s3.eu-west-2.amazonaws.com/Food+and+You+Waves+1-5+Data.csv"

foodandyou <- read_csv(dataurl)

# url of user guide

codebookurl <- "https://fsa-catalogue2.s3.eu-west-2.amazonaws.com/Food+and+You+Waves+1-5+Data+User+Guide.xlsx"
GET(codebookurl, write_disk(tf <- tempfile(fileext = ".xlsx")))

# read in the values tab

codebook <- read_excel(tf, sheet = "Values") %>%
  fill(Variable) %>%
  rename(Value = Vlue,
         Valuelabel = Label)

# which variables need to be recoded

recodevars <- codebook %>% select(Variable) %>% unique() %>% pull(Variable)

# define function to join values to labels

cbjoin <- function(whichvar){
  codebook %>%
    filter(Variable == whichvar) %>%
    right_join(foodandyou, by = c("Value" = whichvar)) %>%
    rename(!!sym(whichvar) := Valuelabel) %>%
    select(!!sym(whichvar))
}

# run over desired variables and bind together

recoded <- map(recodevars, cbjoin) %>% bind_cols() %>% mutate_all(., ~as.factor(.))

# select variables that were not recoded

fyvars <- names(foodandyou)
nrvars <- fyvars[!fyvars %in% recodevars]

foodandyou2 <- foodandyou %>%
  select(eval(nrvars)) %>%
  bind_cols(recoded)
