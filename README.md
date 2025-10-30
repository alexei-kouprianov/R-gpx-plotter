# R-gpx-plotter: A simple tool to add points to a static Google map

## Preamble

The scripts were originally designed to help mapping [my iNaturalist observations](https://www.inaturalist.org/people/alexei_kouprianov). My DSLR camera lacks a buil-in GPS module and the external GPS module I used was broken (and failed all too often when it was still alive). I record points with GPX-tracker app on my iPhone, then send the resulting GPX file to my e-mail and use it with the these scripts to produce a map of observations, which can be used to manually set the point coordinates when uploading observations to iNaturalist platform.

It is recommended to run the scripts from the `scripts` folder. Your GPX files should be in the `data` folder, and the output maps will be saved in the `plots` folder.

The script requires a Google Maps API key. Create a `.env` file in the root of the project and add your key there as `GOOGLE_MAPS_API_KEY=YOUR_API_KEY`. An example file `.env.example` is provided.

The repository is provided with two real-life examples of GPX files (Göttingen and Zadar) and three plots (set in different map types) resulting from the Zadar excursion.

## Installation

Before running the scripts, you need to install the required R packages and their system dependencies.

### System Dependencies

On macOS, you can use Homebrew to install the required libraries:

```bash
brew install pkg-config gdal proj
```

### R Packages

Open R and run the following command to install the necessary packages:

```R
install.packages(c("sf", "ggmap", "ggplot2", "shadowtext", "dotenv"))
```



## Usage

    Rscript GPX.main.r ../data/filename.gpx zoom maptype

- `zoom` (mandatory) : one- or two-digit integer, the greater the value, the bigger is the magnification; recommended value for a small excursion is 15; watch the textual output to the console: if the script reports dropping some data points, then the zoom (magnification) is too big, consider diminishing zoom or splitting the GPX data file into smaller parts.

- `maptype` (optional): supported map types : `satellite`, `roadmap`, `hybrid` (defaults to `hybrid` when no map type is provided).

## Examples

Here are a few examples of how to run the script. Remember to run these commands from the `scripts` directory.

### Example 1: Roadmap plot

To generate a roadmap plot for the Zadar GPX file with a zoom level of 13:

```bash
Rscript GPX.main.r ../data/2024-10-12.Zadar.gpx 13 roadmap
```

This will create a file named `2024-10-12.Zadar.13.roadmap.png` in the `plots` directory.

### Example 2: Hybrid plot

To generate a hybrid plot for the same GPX file with a zoom level of 16:

```bash
Rscript GPX.main.r ../data/2024-10-12.Zadar.gpx 16 hybrid
```

This will create a file named `2024-10-12.Zadar.16.hybrid.png` in the `plots` directory.

Here is an example of the output map:

![Zadar, hybrid](plots/2024-10-12.Zadar.hybrid.png)
