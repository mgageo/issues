#
# tracé d'un buffer du côté droit d'une ligne
# pb avec une route de bus


test <- function() {
  library(sf)
  library(tidyverse)
  library(ggplot2)
  ligne <- st_linestring(rbind(c(0,0),c(0,10),c(10,10),c(0,10)))
  multi <- st_cast(ligne, "MULTIPOINT")
  points <- st_cast(x = st_sfc(multi), to = "POINT")
  cote <- ligne %>%
    st_buffer(-2, singleSide = TRUE, bOnlyEdges = FALSE) %>%
    st_buffer(0)
  gg <- ggplot() +
    geom_sf(data = cote, fill = "green", alpha = .5) +
    geom_sf(data = ligne, , color = "blue", size = 3)
  print(gg)
}

osm <- function() {
  library(sf)
  library(tidyverse)
  library(ggplot2)
  dsn <- "https://raw.githubusercontent.com/mgageo/issues/main/cote_droit_shape_bug.geojson"
  ligne <- st_read(dsn) %>%
    st_transform(2154) %>%
    glimpse()
  cote <- ligne %>%
    st_buffer(-50, singleSide = TRUE, bOnlyEdges = FALSE) %>%
    st_buffer(0)
  gg <- ggplot() +
    geom_sf(data = cote, fill = "green", alpha = .5) +
    geom_sf(data = ligne, color = "blue", size = 5)
  print(gg)
}
osm()