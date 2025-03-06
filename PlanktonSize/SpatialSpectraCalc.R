# The purpose of this script is to derive aspects of the phytoplankton size 
# spectrum from satellite remotely sensed data.  These will then be used to 
# force a therMizer model.

# Set up the workspace
library(tidyverse)
library(tidync)
library(here)

# Load grids of spectrum elements
A <- tidync(here("PlanktonSize", "A_regrid.nc")) |>
  hyper_tibble("A")

B <- tidync(here("PlanktonSize", "B_regrid.nc")) |>
  hyper_tibble("B")

mb0 <- tidync(here("PlanktonSize", "mb0_regrid.nc")) |>
  hyper_tibble("MB0")

mb100 <- tidync(here("PlanktonSize", "mb100_regrid.nc")) |>
  hyper_tibble("MB100")

# Spatial average, for input to eventual ResourceSpectrumFromSatelliteData
# Note that cell masses are in picograms C (1e-12)
resource_intercept <- tibble(mean(A$A, na.rm = TRUE)) |>
  rename(intercept = `mean(A$A, na.rm = TRUE)`) 
resource_slope <- tibble(mean(B$B, na.rm = TRUE)) |>
  rename(slope = `mean(B$B, na.rm = TRUE)`) 
resource_min <- tibble(mean(mb0$MB0, na.rm = TRUE) * 1e-12) |>
  rename(plankton_min = `mean(mb0$MB0, na.rm = TRUE) * 1e-12`)
resource_max <- tibble(mean(mb100$MB100, na.rm = TRUE) * 1e-12) |>
  rename(plankton_max = `mean(mb100$MB100, na.rm = TRUE) * 1e-12`)

# Save data into the folder with the plankton function
write_csv(resource_intercept, here("PlanktonFunction", "Resource_Intercept.csv"))
write_csv(resource_slope, here("PlanktonFunction", "Resource_Slope.csv"))
write_csv(resource_min, here("PlanktonFunction", "Resource_Min.csv"))
write_csv(resource_max, here("PlanktonFunction", "Resource_Max.csv"))

# Load the functions that are used here
# source(here("PlanktonSize", "SpectraCalc.R"))
# Access a small amount of sst and chl data
# The commented-out code below extracts from OceanWatch, 
# But these variables are on different grids.  So:
# I've regridded a small subset of data to a common, coarse grid
# And will be using that instead, for now.
# See OceanWatchSubset.jnl for this workflow
# chl_file <- tidync("https://oceanwatch.pifsc.noaa.gov/erddap/griddap/esa-cci-chla-monthly-v6-0")
# chl_sub <- chl_file |> 
#   hyper_filter(longitude = longitude > 180 & longitude < 181, 
#                latitude = latitude > 10 & latitude < 11, 
#                time = index > 327) |>
#   hyper_tibble("chlor_a")
# 
# sst_file <- tidync("https://oceanwatch.pifsc.noaa.gov/erddap/griddap/CRW_sst_v3_1_monthly") 
# sst_sub <- sst_file |>
#   hyper_filter(longitude = longitude > 180 & longitude < 181, 
#                latitude = latitude > 10 & latitude < 11,
#                time = index > 479 & index < 481) |>
#   hyper_tibble("sea_surface_temperature")
# Because these grids aren't exactly equal due to rounding, moving the math over
# to pyFerret, and then will work with the resulting spectrum details here.
# ...sigh...