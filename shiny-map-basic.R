# Produces an interactive map that displays points within boundaries
# Includes a legend with two data types
# Includes pop ups, given here with 6 examples

library(leaflet)
library(shiny)
library(dplyr)
library(rgdal)

dataframe <- read.csv("filename.csv")
boundaries <- readOGR("shapefile name.shp")
boundaries <- spTransform(boundaries, CRS("+init=epsg:4326"))

ui <- fluidPage(
  titlePanel("Title of Map"),
  leafletOutput("mapname", height = 1000, width = 800),
  p()
)

pal <- colorFactor(c("blue", "black"), domain = c("data type one", "data type two"))

server <- function(input, output) {
  output$mapname <- renderLeaflet({
    mapname <- leaflet(dataframe) %>%
      setView(lng = -2.916976, lat = 54.815864, zoom = 6) %>%
      addTiles() %>%
      addLegend("topright", pal = pal, values = ~Type) %>%
      addPolygons(
        data = boundaries,
        stroke = TRUE, fillOpacity = 0,
        smoothFactor = 0.1, color = "black", opacity = 1, weight = 1
      ) %>%
      addCircleMarkers(
        radius = 6,
        color = ~ pal(dataframe$columnnamefordomaintype),
        stroke = FALSE, fillOpacity = 1,
        popup = paste(
          "Name", dataframe$Name, "<br>",
          "ID", dataframe$ID, "<br>",
          "Area", dataframe$area, "<br>",
          "Post Code", dataframe$Postcode, "<br>",
          "Code", dataframe$Code, "<br>",
          "Type", dataframe$Type
        )
      )
  })
  options(shiny.sanitize.errors = FALSE)
}

shinyApp(ui = ui, server = server)
