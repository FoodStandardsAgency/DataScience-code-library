import::from(magrittr, "%>%")

# --- LOAD SECRETS ---
sql_details <- jsonlite::read_json("./secrets/secrets.json")[["sql"]]
pgsql <- jsonlite::read_json("./secrets/secrets.json")[["psql"]]

# --- SQL SERVER CONNECTION ---
con <- DBI::dbConnect(
  odbc::odbc(),
  driver = sql_details$driver,
  server = sql_details$server,
  uid = sql_details$uid,
  pwd = sql_details$pwd,
  port = 1433,  
  database = sql_details$database,
  Encrypt = "yes",
  TrustServerCertificate = "no",
  timeout = 90
)

query <- "SELECT * FROM table_name"
res <- dplyr::tbl(con, dbplyr::sql(query)) %>% dplyr::collect()
res <- res[["col_name"]][1]


# --- PSQL CONNECTION ---
con_PG <- DBI::dbConnect(
  RPostgres::Postgres(),
  dbname = "postgres",
  host = pgsql2$host,
  port = 5432,
  user = pgsql2$user,
  password = pgsql2$pwd
)

query_postcode <- "SELECT * from public.geom_table WHERE foo = 'bar'")
polygon_select <- sf::st_read(con_PG, query = query_postcode)
polygon_select <- polygon_select %>%
  dplyr::group_by(groupname) %>%
  dplyr::summarise(geom = sf::st_union(geom)) %>%
  dplyr::ungroup()


# --- UI ---
# Test/placeholder UI container
ui <- shiny::fluidPage( # Application title
  shiny::titlePanel(res),
  shiny::titlePanel(polygon_select$col_name),
)


# --- SERVER ---
# Instantiate server
server <- function(input, output) {

}


# --- RUN ---
# Run the application
shiny::shinyApp(ui = ui, server = server)
