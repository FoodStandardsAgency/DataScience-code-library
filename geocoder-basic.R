library(ggmap)

# Set your Google API key, using the Google Geocoding API
register_google(key = "Your API key")

# Read in your data, such as a list of postcodes or city names
dataframe <- read.csv("filename.csv")

# Calls the Geocoding API and returns long / lat coordinates
geocodes <- geocode(as.character(dataframe$columnName))
