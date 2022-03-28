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

# esportazione immagini in pdf nella cartella lab 
pdf("banda1.pdf")
plot(l2011$B1_sre, col=clb)
dev.off()
