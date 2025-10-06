# Requires :
# source("GPX.libraries.r")
# source("GPX.get_map.r")

# Prepare the plot;
p <- ggmap(map_collated) +
    geom_point(data = df, aes(x = lon, y = lat), color = "red", size = 3) +
    geom_shadowtext(data = df, aes(x = lon, y = lat, label = time_short), hjust = -0.1, vjust = -0.5, color = "white", bg.colour="black", size = 5, fontface = "bold") +
    labs(title = "GPS Points on Google Maps", x = "Longitude", y = "Latitude")

# Print the final plot to a file;
png(paste0("../plots/", gpxfilename_root, ".", zoom, ".", maptype, ".png"), height = 1000, width = 1000, res = 120, pointsize = 12)
    print(p)
dev.off()
