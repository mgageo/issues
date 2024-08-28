# <!-- coding: utf-8 -->
#
# issue avec mapsf, n'arrive pas avec overlap = FALSE
#
# auteur : Marc Gauthier
# licence: Creative Commons Paternité - Pas d'Utilisation Commerciale - Partage des Conditions Initiales à l'Identique 2.0 France
# ===============================================================
#
#
# source("geo/scripts/issue_mapsf4.R")
# remotes::install_github("riatelab/mapsf", ref = "dev")
library(sf)
library(mapsf)
library(tidyverse)
  dsn <- "https://raw.githubusercontent.com/mgageo/issues/ee547796e3a99c966c2d0890f4807bf40f14f598/shape_stops_POSB-POSD-alsac-LYH.geojson"
  nc1 <- st_read(dsn) %>%
    st_transform(2154) %>%
    glimpse()
  shape.sf <- nc1 %>%
    filter(st_geometry_type(geometry) != "POINT") %>%
    glimpse()
  points.sf <- st_sf(st_cast(st_geometry(shape.sf), "POINT"))

  mf_init(shape.sf, expandBB = c(0.3, 0.3, 0.3, 0.3))
  mf_map(x = shape.sf, col = "green", lwd = 3, add = TRUE)
  mf_annotation(points.sf[1, ], txt = "Départ", col_txt = "blue", col_arrow = "blue")
  mf_title("r1268247 : 0061-A-1510-3801", inner = TRUE)
  w <- par("din")[1]
  h <- par("din")[2]
  dir <- tempdir()
  dsn <- sprintf("%s/issue_mapsf4.pdf", dir)
  print(sprintf("dsn: %s", dsn))
  dev.copy(pdf, dsn, width = w, height = h)
  dev.off()
  dsn <- sprintf("%s/issue_mapsf4.png", dir)
  print(sprintf("dsn: %s", dsn))
  dev.copy(png, dsn)
  dev.off()
