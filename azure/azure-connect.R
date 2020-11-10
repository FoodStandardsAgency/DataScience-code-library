devtools::install_github("Azure/AzureStor")

library(AzureStor)
library(glue)

account_name <- "account_name"
account_key <- "account_key"

file_endp <- file_endpoint(
  glue("https://{account_name}.file.core.windows.net"),
  key = glue({
    account_key
  })
)

list_storage_containers(file_endp)

# list files and dirs from top level directory
cont <- storage_container(file_endp, "azureshareds1")
list_storage_files(cont)

# list files and dirs from children dirs
cont <- storage_container(file_endp, "azureshareds1/uv_data_extracts")
list_storage_files(cont)

# read file in
con <- storage_download(cont, "unified_view_closed_200928.csv", NULL)

# using readr::read_csv
readr::read_csv(con)

# using base R's utils::read.csv
read.csv(text = rawToChar(rawConnectionValue(con)))
