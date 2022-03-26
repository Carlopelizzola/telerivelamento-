# questo è primo script che useremo a lezione 

# install.packages("raster")
library(raster)

# settaggio cartella di lavoro 
setwd("C:/lab/")

# importazione dati 
l2011 <- brick("p224r63_2011.grd")
l2011

