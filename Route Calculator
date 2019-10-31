# This code calculates a route (or 'tour') between a number of locations

library(reshape2)
library(TSP)
library(ggmap)

register_google(key = "Your key for Google Distrance Matrix API")

options(stringsAsFactors = F)
locations<-read.csv2("cities.csv")

# Specify number of locations in tour (useful if just visiting the first n locations in a long list) - change as required

nodes<-1:5   
locations[nodes,]

# Create your distance matrix

distanceMat<-matrix(NA, nrow=length(nodes), ncol = length(nodes))
for(i in 1:length(nodes)) {
  for(j in 1:length(nodes)) {
    if (i==j) distanceMat[i,j] <- 0   
    else distanceMat[i,j] <- mapdist(paste(locations$yourColumnName[nodes[i]],", UK", sep=""),
                                     paste(locations$yourColumnName[nodes[j]], ", UK", sep=""),
                                     mode = 'driving', output = 'simple')$km 
  }
}
colnames(distanceMat)<-locations$yourColumnName[nodes] 
rownames(distanceMat)<-locations$yourColumnName[nodes] 
distanceMat

# Reformat distance matrix into a list with "from" and "to" column headings

dat<-melt(distanceMat)
colnames(dat)<-c("from","to","km")

# Solve the TSP, to get the shortest route between nodes specified above (using nearest neighbour)

UK_dm<-ATSP(distanceMat)
tour <- solve_TSP(UK_dm, method = "nn")

# Show the stops involved in the shortest route

labels(tour)

# Find length of your tour in km

attr(tour, "tour_length")
