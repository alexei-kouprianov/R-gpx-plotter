# Capture the command-line arguments;
args <- commandArgs(trailingOnly = TRUE)

# Check filename;
if(!(grepl("^\\.\\.\\/data\\/.*\\.gpx$", perl = TRUE, args[1]))){
    stop("Required filename format is : ../data/filename.gpx")
    flush.console()
}

# Assign the arguments to variables;
gpxfilename_full <- args[1]  # First argument: filename with path (character)
zoom <- as.integer(args[2])  # Second argument: 1 to 2 digit number (integer)
maptype <- args[3]           # Third argument: map type (character)

# Load Google Maps API key with .env file
# 1) Try environment variable
googleMapsAPIKey <- Sys.getenv("GOOGLE_MAPS_API_KEY", unset = "")

# 2) Try loading from a .env file if available and dotenv is installed
if(nchar(googleMapsAPIKey) == 0 && file.exists("../.env")){
    if(requireNamespace("dotenv", quietly = TRUE)){
        try({
            dotenv::load_dot_env("../.env", override = TRUE)
        }, silent = TRUE)
        googleMapsAPIKey <- Sys.getenv("GOOGLE_MAPS_API_KEY", unset = "")
    }
}

# 3) Stop if still missing
if(nchar(googleMapsAPIKey) == 0){
    stop(paste0(
        "Google Maps API key not found. Set env var GOOGLE_MAPS_API_KEY, ",
        "or add it to ../.env (GOOGLE_MAPS_API_KEY=...)"
    ))
    flush.console()
}

# Check if zoom is specified;
if(is.na(zoom)){
    stop("Required zoom format is a one or two digit integer, e. g. 3 or 17")
    flush.console()
}

# Assign "hybrid" to maptype in case map type is missing;
if(is.na(maptype)){
    maptype <- "hybrid"
}

# Check map type spelling;
if(!(maptype %in% c("satellite", "roadmap", "hybrid"))){
    stop("Supported map types : satellite, roadmap, hybrid (defaults to hybrid when empty)")
}

# Control printout of variables;
cat("GPX Filename:", gpxfilename_full, "\n")
flush.console()
cat("Zoom level:", zoom, "\n")
flush.console()
cat("Map type:", maptype, "\n")
flush.console()
cat("Google API key: [loaded]\n")
flush.console()

# Getting filename root part;
gpxfilename_root <- gsub(".*\\/|\\.gpx", "", perl = TRUE, gpxfilename_full)

# Running the scripts;
source("GPX.libraries.r")
source("GPX.get_map.r")
source("GPX.plot_map.r")
