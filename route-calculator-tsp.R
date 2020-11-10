library(tidyverse)
library(TSP)
library(ggmap)
library(geosphere)

ggmap::register_google(key = "Your Google Maps API key here")
producers <- read.csv("Your Filename Here.csv")
CenterOfMap <- geocode("Lancaster, UK")
mymap <- get_map(c(lon = CenterOfMap$lon, lat = CenterOfMap$lat), zoom = 6, maptype = "terrain", source = "google")

n <- nrow(producers)
producers_dist <- matrix(0, n, n)
for (i in 1:n) {
  for (j in 1:n) {
    producers_dist[i, j] <- geosphere::distGeo(
      c(producers$Longitude[i], producers$Latitude[i]),
      c(producers$Longitude[j], producers$Latitude[j])
    )
  }
}

producers_tsp <- TSP(producers_dist, labels = producers$ColumnName)
producers_route <- solve_TSP(producers_tsp, method = "nn")

producers_route <- as.integer(producers_route)
producers_route <- c(producers_route, producers_route[1])

routemap <- ggmap(mymap) +
  geom_path(data = producers[producers_route, ], aes(x = Longitude, y = Latitude)) +
  geom_point(data = producers, aes(x = Longitude, y = Latitude), size = 2, col = "goldenrod3") +
  theme(
    legend.position = "bottom",
    text = element_text(size = 16),
    aspect.ratio = 0.9,
    axis.ticks = element_blank(),
    axis.text = element_blank()
  ) +
  labs(x = "", y = "")
routemap
