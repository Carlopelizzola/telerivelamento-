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

# lensat ETM+
# b1 = blue
# b2 = verde
# b3 = rosso 
# b4 = infrarosso vicino 

# plot della banda del blu B1_sre
plot(l2011$B1_sre)
#oppure
plot(l2011[[1]])

# cambiamento leggenda 
cl <- colorRampPalette(c("black", "grey", "light grey")) (100)
plot(l2011$B1_sre, col=cl)

# plot b1 from dark blue to blue to light blue
clb <- colorRampPalette(c("dark blue", "blue", "light blue")) (100)
plot(l2011$B1_sre, col=clb)

# esportazione del plot nella cartella lab 
pdf("banda1.pdf")
plot(l2011$B1_sre, col=clb)
dev.off()

png("banda1.png")
plot(l2011$B1_sre, col=clb)
dev.off()

# plot b2 from dark green to green to light green
clg <- colorRampPalette(c("dark green", "green", "light green")) (100)
plot(l2011$B2_sre, col=clg)

#Multiframe
par(mfrow=c(1,2))
plot(l2011$B1_sre, col=clb)
plot(l2011$B2_sre, col=clg)
dev.off()

# esport pdf multiframe 
pdf("multiframe.pdf") 
par(mfrow=c(1,2))
plot(l2011$B1_sre, col=clb)
plot(l2011$B2_sre, col=clg)
dev.off()

# revert the multiframe 
par(mfrow=c(2,1))
plot(l2011$B1_sre, col=clb)
plot(l2011$B2_sre, col=clg)
dev.off()

# let's plot the first four bands
par(mfrow=c(2,2))
# plot blu
plot(l2011$B1_sre, col=clb)
# plot green
plot(l2011$B2_sre, col=clg)
# plot red 
clr <- colorRampPalette(c("dark red", "red", "pink")) (100)
plot(l2011$B3_sre, col=clr)
# plot NIR
clnir <- colorRampPalette(c("red", "orange", "yellow")) (100)
plot(l2011$B4_sre, col=clnir)

# plot l2011 in the NIR channel 
plot(l2011$B4_sre)
#or 
plot(l2011[[4]])
# cambio leggedna 
clnir <- colorRampPalette(c("red", "orange", "yellow")) (100)
plot(l2011$B4_sre, col=clnir)

# plot RGB layers
# plot visibile 
plotRGB(l2011, r=3, g=2, b=1, stretch="lin")
# plot nir in red per visualizzare vegetazione 
plotRGB(l2011, r=4, g=3, b=2, stretch="lin")
# plot RGB in nir in green per visualizzare vegetazione 
plotRGB(l2011, r=3, g=4, b=2, stretch="lin")
# plot RGB in NIR in blue per visualizzare suolo nudo 
plotRGB(l2011, r=3, g=2, b=4, stretch="lin")
# plot in hist
plotRGB(l2011, r=3, g=4, b=2, stretch="hist")

# multiframe whit Visibol RGB linear strech on top of fals coloror istagram strech
par(mfrow=c(2,1))
plotRGB(l2011, r=3, g=2, b=1, stretch="lin")
plotRGB(l2011, r=3, g=4, b=2, stretch="hist")

#upload from the image 1988
l1988 <- brick("p224r63_1988.grd")
l1988

# multiframe
par(mfrow=c(2,1))
plotRGB(l1988, r=4, g=3, b=2, stretch="lin")
plotRGB(l2011, r=4, g=3, b=2, stretch="lin")


