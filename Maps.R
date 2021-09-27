#Creating Maps in R
#CODE BY JATIN DHALL
#Using leaflet library

#Loading the library
library(leaflet)

map1 <- leaflet() #Empty map

map2 <- leaflet() %>% addTiles() #Allows us to zoom in and shows the world map

#Adding markers
map3 <- leaflet() %>% addTiles() %>%
        addMarkers(lng = -73.9851, lat = 40.7389)

#To add a Caption
map4 <- leaflet() %>% addTiles() %>%
  addMarkers(lng = -73.9851, lat = 40.7389, popup = 'Times Square')

#We can create maps with different Tiles
map5 <- leaflet() %>% addProviderTiles("Stamen.Watercolor") %>%
  addMarkers(lng = 2.2945, lat = 48.8584, popup = "Eiffel Tower")

#CREATING MAPS FROM A DATA FRAME
#Using the quakes dataset for Earthquakes
head(quakes)

#The output of the code below, is very cluttered
map6 <- leaflet(quakes) %>% addTiles() %>%
  addCircleMarkers(lng = quakes$long, lat = quakes$lat)

#We can improve the clarity by grouping the markers into clusters
map7 <- leaflet(quakes) %>% addTiles() %>%
  addMarkers(clusterOptions = markerClusterOptions())

#To highlight an area
map8 <- leaflet() %>% addTiles() %>%
  addMarkers(lng = 86.92, lat = 27.99, popup = "Mount Everest") %>%
  addRectangles(86.9,27.95,87,28.05)

#To save and display the map as an html file
saveWidget(map8, file="map8.html", selfcontained = F)
display_html(paste("<iframe src=' ", 'map8.html', " ' width='100%' height='300'","/>"))

#To add Polygons with matrix
tri <- matrix(c(86.87, 27.95, 86.97, 27.95, 86.92, 28.05), ncol = 2, byrow = TRUE)
map10 <- leaflet() %>% addTiles() %>% addMarkers(lng = 86.92, lat = 27.99,
                                                 popup = "Mount Everest") %>% addPolygons(lng = tri[, 1],
                                                                                          lat = tri[, 2])
#Polygons with sp object
library(sp)
#This example uses the library rgdal to read a geojson file 
#with the countries' borders information and convert it to 
#a sp object
library(rgdal)
countries <- readOGR("/resources/data/countries.txt", "OGRGeoJSON")
map11 <- leaflet(countries) %>% addTiles() %>% addPolygons(weight = 1)

#Color Numeric
energy <- read.csv("/resources/data/energy.csv")
#merge the energy data frame with countries
countries <- sp::merge(countries, energy[, c(1, 3)], by = "geounit", all.x = T)
color <- colorNumeric("YlOrRd", energy$Value)
map12 <- leaflet(countries) %>% addTiles() %>% addPolygons(stroke = FALSE, 
                                                           fillColor = ~color(Value),
                                                           fillOpacity = 1) %>% addLegend("topright",
                                                                                          pal = color,
                                                                                          values = countries@data$Value,
                                                                                          title = "kWh per capita",
                                                                                          opacity = 1)
#Color Factor
color <- colorFactor("Set1", countries$continent)
map13 <- leaflet(countries) %>% addTiles() %>% addPolygons(stroke = F,
                                                           fillColor = ~color(continent),
                                                           fillOpacity = 1) %>% addLegend("bottomleft",
                                                                                          pal = color,
                                                                                          values = ~continent,
                                                                                          opacity = 1,
                                                                                          title = "Continent")