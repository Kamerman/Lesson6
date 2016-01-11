## Brinkman
## Willem Kamerman & Luc van Zandbrink
## 11/01/2016
## Exercise 6, intro to vector

## Install packages
library(sp)
library(rgdal)
library(rgeos)
library(latticeExtra)
library(maptools)

## source functions
# -

getwd()
setwd("/media/user/FREECOM/Studie/2015-2016-P3-GRS-33806/git/geoScripting/Lesson6/")


# download Netherlands Places
download.file(url = 'http://www.mapcruzin.com/download-shapefile/netherlands-places-shape.zip', destfile = 'data/netherlands-places-shape.zip', method = 'auto')
# download Netherlands Railways
download.file(url = 'http://www.mapcruzin.com/download-shapefile/netherlands-railways-shape.zip', destfile = 'data/netherlands-railways-shape.zip', method = 'auto')
# Unpack the zip archives
unzip('netherlands-places-shape.zip', exdir = 'data/Places/')
unzip('netherlands-railways-shape.zip', exdir = 'data/Railways/')

places <- readOGR(dsn=path.expand("data/Places"), layer="places")
railway <- readOGR(dsn=path.expand("data/Railways"), layer="railways")
industrial <- subset(railway, type == "tram")


# file.exists('/media/user/FREECOM/Studie/2015-2016-P3-GRS-33806/git/geoScripting/Lesson6/data/railways.shp')
# file.exists('/media/user/FREECOM/Studie/2015-2016-P3-GRS-33806/git/geoScripting/Lesson6/data/places.shp')


buffer <- gBuffer(industrial, width=0.02, byid = T)
placesbuffer <- gIntersection(places, buffer, byid=T)
city <- data.frame(placesbuffer)
x <- city$x
y <- city$y
city2 <- data.frame(places)
city3 <- city2[city2$coords.x1==x,]
city4 <- city3[city3$coords.x2==y,]
city4
paste(city4$name,"is the city with a" , city4$population,"population.")

plot(buffer, main=city4$name)
plot(placesbuffer, add=T)
plot(industrial, add=T)

## city= Utrecht, population= 100000
