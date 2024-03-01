# <!-- coding: utf-8 -->
#
# issue avec mapsf, n'arrive pas avec overlap = FALSE
#
# auteur : Marc Gauthier
# licence: Creative Commons Paternité - Pas d'Utilisation Commerciale - Partage des Conditions Initiales à l'Identique 2.0 France
# ===============================================================
#
#
# source("geo/scripts/issue_mapsf2.R")
library(sf)
library(mapsf)
  dsn <- "https://raw.githubusercontent.com/mgageo/issues/ee547796e3a99c966c2d0890f4807bf40f14f598/shape_stops_POSB-POSD-alsac-LYH.geojson"
  nc1 <- st_read(dsn) %>%
    st_transform(2154) %>%
    glimpse()
  points.sf <- nc1 %>%
    filter(st_geometry_type(geometry) == "POINT") %>%
    mutate(Name = sprintf("%s %s", id, name)) %>%
    glimpse()
  shape.sf <- nc1 %>%
    filter(st_geometry_type(geometry) != "POINT") %>%
    glimpse()
  mf_init(shape.sf, expandBB = c(1500, 1500, 1500, 1500))
  plot(st_geometry(shape.sf), add = FALSE, col = "green", lwd = 3)

  mf_label(x = points.sf,
    var = "Name",
    cex = 0.8,
    col = "black",
    overlap = FALSE,
    lines = TRUE
  )

  df2 <- st_distance(points.sf, shape.sf)
  nc2 <- cbind(points.sf, df2) %>%
    mutate(distance = as.integer(df2)) %>%
    dplyr::select(-df2)
  loins.sf <- nc2 %>%
    filter(distance > 50)
  if (nrow(loins.sf) > 0) {
    plot(st_geometry(loins.sf), col = "red", lwd = 3, pch = 19, add = TRUE)
    mf_label(x = loins.sf,
      var = "Name",
      cex = 0.8,
      overlap = FALSE,
      lines = TRUE
    )
  }