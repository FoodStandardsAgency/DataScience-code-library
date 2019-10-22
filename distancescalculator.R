library(gmapsdistance) # returns time in seconds and distance in meters for driving between locations
set.api.key("insert your Google Distance Matrix API key here")
dataframe <- read.csv("filename.csv") # read in your data, formatted without spaces, e.g. format postcodes as xxxxxx not xxx xxx, and join lat long coordinates with a +
origin = dataframe$columnname
destination = dataframe$othercolumnname
results = gmapsdistance(origin, destination, mode = "driving", shape = "long") # process might be quite slow if you are working out distances between multiple places