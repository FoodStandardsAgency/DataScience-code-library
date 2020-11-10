library(ggmap)

# Opens browser for you to select file
fileToLoad <- file.choose(new = TRUE)

# Read in the data
mylocations <- read.csv(fileToLoad, stringsAsFactors = FALSE)

# Set your Google API key, using the Google Geocoding API
register_google(key = 'Your API key')

# Initialize the data frame
geocoded <- data.frame(stringsAsFactors = FALSE)

# Loop through the addresses to get the lat / long data and add to mylocations data frame
for(i in 1:nrow(mylocations)) {
  # Print("Working...")
  result <- geocode(mylocations$columnName[i], output = "latlona", source = "google")
  mylocations$lon[i] <- as.numeric(result[1])
  mylocations$lat[i] <- as.numeric(result[2])
  mylocations$geoAddress[i] <- as.character(result[3])
}

# Write a CSV file of your geocoded data to the working directory
write.csv(mylocations, "geocoded_locations.csv", row.names=FALSE)
