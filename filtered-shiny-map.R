# Produces an interactive map that displays points within boundaries 
# Includes a legend with two data types
# Includes pop ups, given here with 6 examples
# Includes ability to filter data to show points within a specified boundary area

library(leaflet)
library(shiny)
library(dplyr)
library(rgdal)

dataframe <- read.csv("filename.csv")
boundaries <- readOGR("shapefile name.shp")
boundaries <- spTransform(boundaries, CRS("+init=epsg:4326"))


ui <- fluidPage(
  titlePanel("Title of Map"),
  selectInput("dropdown", "Select Area", choices = (dataframe$area), multiple = FALSE),
  leafletOutput("mapname", height = 1000, width= 1000)
)

pal <- colorFactor(c("blue", "black"), domain = c("data type one", "data type two"))

server <- function(input, output){
  filtered <- reactive({
    dataframe %>% filter(dataframe$area %in% input$dropdown)
  })
  output$mapname <- renderLeaflet({
    mapname <- leaflet(filtered()) %>%
      setView(lng = -2.916976, lat = 54.815864, zoom = 6) %>%
      addTiles() %>%
      addLegend("topright", pal = pal, values = ~columnnamefortype) %>%
      addPolygons(data = boundaries, 
                  stroke = TRUE, fillOpacity = 0, 
                  smoothFactor = 0.1, color = "black", opacity = 1, weight = 1) %>%
      addCircleMarkers(
        radius = 4,
        color = ~pal(columnnamefortype),
        stroke = FALSE, fillOpacity = 1,
        popup = paste("Name", filtered()[,"Name"],"<br>",
                      "ID", filtered()[,"ID"], "<br>",
                      "Area", filtered()[,"area"], "<br>",
                      "Post Code", filtered()[,"PostCode"], "<br>",
                      "Code", filtered()[,"Code"], "<br>",
                      "Type",filtered()[,"Type"]))
  })
  options(shiny.sanitize.errors = FALSE)
}

shinyApp(ui = ui, server = server)

