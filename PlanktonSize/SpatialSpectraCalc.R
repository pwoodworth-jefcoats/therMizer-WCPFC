# The purpose of this script is to derive aspects of the phytoplankton size 
# spectrum from satellite remotely sensed data.  These will then be used to 
# force a therMizer model.

# Set up the workspace
library(tidyverse)
library(tidync)
library(here)

# Load the functions that are used here
source(here("PlanktonSize", "SpectraCalc.R"))

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

chl <- tidync(here("PlanktonSize", "chl_regrid.nc")) |>
  # hyper_filter(AX008 = AX008 < 200) |>
  hyper_tibble("CHL_REGRID")

sst <- tidync(here("PlanktonSize", "sst_regrid.nc")) |>
  # hyper_filter(AX008 = AX008 < 200) |>
  hyper_tibble("SST_REGRID")

# Because these grids aren't exactly equal due to rounding, moving the math over
# to pyFerret, and then will work with the resulting spectrum details here.
# ...sigh...