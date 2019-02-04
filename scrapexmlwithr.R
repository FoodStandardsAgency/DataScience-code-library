install.packages("XML")
library(XML)
url <- "http://ratings.food.gov.uk/authorities/xml"
xmldoc <- xmlParse(url)
df <- xmlToDataFrame(getNodeSet(xmldoc, "//FileName")) 
# remove blank rows 
list <- df[complete.cases(df),] 