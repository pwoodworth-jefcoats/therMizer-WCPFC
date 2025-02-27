# The purpose of this script is to calculate aspects of the plankton size 
# spectra from satellite remotely sensed SST and chl, which can in turn be 
# used to inform a therMizer model for the WCPFC convention (sub)area(s).

# The methodology here follows that from Barnes et al. (2011).
# Barnes C, Irigoien X, Oliveira JAAD, Maxwell D, Jennings S. (2011). Predicting
# marine phytoplankton community size structure from empirical relationships 
# with remotely sensed variables. J. Plankton Res. 33, 13–24. 
# doi: 10.1093/plankt/fbq088

# Write functions to calculate the attributes of the plankton spectrum that we need
MB50 <- function(sst, chl) {
  # MB50 is the cell size (pg C) for 50% of phytoplankton biomass
  # sst is in degrees C
  # chl is in mg per m3
  mb50 <- 10^(sst*-0.043 + log10(chl)*0.929 + 1.340)
}

MB9010 <- function(sst) {
  # MB9010 is  the cell size range (pg C) for the midle 80% of phytoplankton biomass
  # sst is in degrees C
  mb9010 <- 10^(sst*0.015 + 2.689)
}

a <- function(chl) {
  # a is the intercept of the linear relationship of phytoplankton biomass (log10 pg C)
  # as a function of phytoplankton cell mass (log10 pg C)
  # chl is in mg per m3
  A <- log10(chl)*0.585 + 9.704
}

b <- function(chl) {
  # b is the slope of the linear relationship of phytoplankton biomass (log10 pg C)
  # as a function of phytoplankton cell mass (log10 pg C)
  # chl is in mg per m3
  B <- log10(chl)*0.099 - 1.196
}

MB10 <- function(sst, chl) {
  # MB10 is the cell size (pg C) for 10% of phytoplankton biomass
  # MB50 is the cell size (pg C) for 50% of phytoplankton biomass
  # MB9010 is the cell size range (pg C) for the midle 80% of phytoplankton biomass
  # B is the intercept of the linear relationship of phytoplankton biomass (log10 pg C)
  # as a function of phytoplankton cell mass (log10 pg C)
  # sst is in degrees C
  # chl is in mg per m3
  
  mb50 <- 10^(sst*-0.043 + log10(chl)*0.929 + 1.340)
  mb9010 <- 10^(sst*0.015 + 2.689)
  B <- log10(chl)*0.099 - 1.196
  
  mb10 <- mb50 * (((10^((B+1)*log10(mb9010))) + 1) / 2)^(-1/(B+1))
  return(mb10)
}

MB90 <- function(sst, chl) {
  # MB90 is the cell size (pg C) for 90% of phytoplankton biomass
  # MB10 is the cell size (pg C) for 10% of phytoplankton biomass
  # MB50 is the cell size (pg C) for 50% of phytoplankton biomass
  # MB9010 is the (cell size range (pg C) for the midle 80% of phytoplankton biomass
  # B is the intercept of the linear relationship of phytoplankton biomass (log10 pg C)
  # as a function of phytoplankton cell mass (log10 pg C)
  # sst is in degrees C
  # chl is in mg per m3
  
  mb50 <- 10^(sst*-0.043 + log10(chl)*0.929 + 1.340)
  mb9010 <- 10^(sst*0.015 + 2.689)
  B <- log10(chl)*0.099 - 1.196
  mb10 <- mb50 * (((10^((B+1)*log10(mb9010))) + 1) / 2)^(-1/(B+1))
  
  mb90 <- 10^(log10(mb10) + log10(mb9010))
  return(mb90)
}

MB0 <- function(sst, chl) {
  # MB0 is the minimum cell size (pg C) 
  # MB90 is the cell size (pg C) for 90% of phytoplankton biomass
  # MB10 is the cell size (pg C) for 10% of phytoplankton biomass
  # MB50 is the cell size (pg C) for 50% of phytoplankton biomass
  # MB9010 is the cell size range (pg C) for the midle 80% of phytoplankton biomass
  # B is the intercept of the linear relationship of phytoplankton biomass (log10 pg C)
  # as a function of phytoplankton cell mass (log10 pg C)
  # sst is in degrees C
  # chl is in mg per m3
  
  mb50 <- 10^(sst*-0.043 + log10(chl)*0.929 + 1.340)
  mb9010 <- 10^(sst*0.015 + 2.689)
  B <- log10(chl)*0.099 - 1.196
  mb10 <- mb50 * (((10^((B+1)*log10(mb9010))) + 1) / 2)^(-1/(B+1))
  mb90 <- 10^(log10(mb10) + log10(mb9010))
  
  mb0 <- (-1.25*mb50^(B+1) + 1.25*mb10^(B+1) + mb50^(B+1))^(1/(B+1))
  return(mb0)
}

MB100 <- function(sst, chl) {
  # MB1000 is the maximum cell size (pg C)
  # MB0 is the minimum cell size (pg C)
  # MB90 is the cell size (pg C) for 90% of phytoplankton biomass
  # MB10 is the cell size (pg C) for 10% of phytoplankton biomass
  # MB50 is the cell size (pg C) for 50% of phytoplankton biomass
  # MB9010 is the cell size range (pg C) for the midle 80% of phytoplankton biomass
  # B is the intercept of the linear relationship of phytoplankton biomass (log10 pg C)
  # as a function of phytoplankton cell mass (log10 pg C)
  # sst is in degrees C
  # chl is in mg per m3
  
  mb50 <- 10^(sst*-0.043 + log10(chl)*0.929 + 1.340)
  mb9010 <- 10^(sst*0.015 + 2.689)
  B <- log10(chl)*0.099 - 1.196
  mb10 <- mb50 * (((10^((B+1)*log10(mb9010))) + 1) / 2)^(-1/(B+1))
  mb90 <- 10^(log10(mb10) + log10(mb9010))
  mb0 <- (-1.25*mb50^(B+1) + 1.25*mb10^(B+1) + mb50^(B+1))^(1/(B+1))
  
  mb100 <- (1.25*mb90^(B+1) - 1.25*mb50^(B+1) + mb50^(B+1))^(1/(B+1))
  return(mb100)
}

BTOT <- function(sst, chl) {
  # BTOT is the total biomass 
  # MB1000 is the maximum cell size (pg C)
  # MB0 is the minimum cell size (pg C)
  # MB90 is the cell size (pg C) for 90% of phytoplankton biomass
  # MB10 is the cell size (pg C) for 10% of phytoplankton biomass
  # MB50 is the cell size (pg C) for 50% of phytoplankton biomass
  # MB9010 is the cell size range (pg C) for the midle 80% of phytoplankton biomass
  # B is the intercept of the linear relationship of phytoplankton biomass (log10 pg C)
  # as a function of phytoplankton cell mass (log10 pg C)
  # A is the slope of the linear relationship of phytoplankton biomass (log10 pg C)
  # as a function of phytoplankton cell mass (log10 pg C)
  # sst is in degrees C
  # chl is in mg per m3
  
  mb50 <- 10^(sst*-0.043 + log10(chl)*0.929 + 1.340)
  mb9010 <- 10^(sst*0.015 + 2.689)
  B <- log10(chl)*0.099 - 1.196
  mb10 <- mb50 * (((10^((B+1)*log10(mb9010))) + 1) / 2)^(-1/(B+1))
  mb90 <- 10^(log10(mb10) + log10(mb9010))
  mb0 <- (-1.25*mb50^(B+1) + 1.25*mb10^(B+1) + mb50^(B+1))^(1/(B+1))
  mb100 <- (1.25*mb90^(B+1) - 1.25*mb50^(B+1) + mb50^(B+1))^(1/(B+1))
  A <- log10(chl)*0.585 + 9.704
  
  # This takes place in log-transformed space and is the integration of a 
  # linear regression from min size to max size: 
  # ((b * MB100^2)/2) + (a * MB100) - (((b * MB0^2)/2) + (a * MB0))
  
  btot <- ((B * log10(mb100)^2)/2) + (A * log10(mb100)) - (((B * log10(mb0)^2)/2) + (A * log10(mb0)))
  return(btot)
}