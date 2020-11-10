# This code will enable you to calculate the distance in time (seconds) and meters between two locations.
# Locations can be given as place names, postcodes, or lat long coordinates.
# Method of travel can also be changed to walking, transit etc.
# The process might be quite slow if you are working out distances between multiple places.

library(gmapsdistance)

set.api.key("insert your Google Distance Matrix API key here")

# Read in your data, formatted without spaces, e.g. format postcodes as xxxxxx not xxx xxx, and join lat long coordinates with a +

dataframe <- read.csv("filename.csv")

origin <- dataframe$columnname

destination <- dataframe$othercolumnname

results <- gmapsdistance(origin, destination, mode = "driving", shape = "long")
