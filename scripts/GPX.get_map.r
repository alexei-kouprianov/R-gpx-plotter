# Requirecs:
# source("GPX.libraries.r")

wp <- readOGR(gpxfilename_full, layer = "waypoints")

coords <- coordinates(wp)
time <- wp@data$time
df <- data.frame(
  lon = coords[, 1],  # Longitude
  lat = coords[, 2],  # Latitude
  time = time         # Timestamps
)

df$TS <- strptime(df$time, format="%Y/%m/%d %H:%M:%S") + 2 * 3600
df$time_short <- gsub("(.* )|(:\\d\\d$)", "", as.character(df$TS))

map_center <- c(lon = mean(df$lon), lat = mean(df$lat))

register_google(key = googleMapsAPIKey)

map_collated <- get_map(location = map_center, zoom = zoom, maptype = maptype, source = "google", key = googleMapsAPIKey)
