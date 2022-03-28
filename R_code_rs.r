# questo è primo script che useremo a lezione 

# install.packages("raster")
library(raster)

# settaggio cartella di lavoro 
setwd("C:/lab/")

# importazione dati 
l2011 <- brick("p224r63_2011.grd")
l2011

# plot 
plot(l2011)

# cambiamento di leggenda 
cl <- colorRampPalette(c("black", "grey", "light grey")) (100)

plot(l2011, col=cl)
