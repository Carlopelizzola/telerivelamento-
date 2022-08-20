# Analisi e confronto di due immagini landsat della stessa località (Path:190, Row:055) nello stato della Nigeria dove è situata la riserva Akure Ofosu 
#le immagini analizzate sono state acquisite in periodi diversi una il 26/01/2022 e l'altra il 14/12/2014

# Istallazione dei pachetti necessari 
# install.packages("raster")
# install.packages("RStoolbox")
# install.packages("ggplot2")
# install.packages("patchwork")
# install.packages("viridis")
# install.packages("rgdal")
# install.packages("rasterdiv")
# install.packages("sdm")
# install.packages("rgdal", dependencies=T)

#aperture delle librerie necessarie 
library(raster) 
library(RStoolbox) #per vissualizzare le immagini e calcoli 
library(ggplot2) #per i plot ggplot 
library(patchwork) #per creare multiframe con ggplot 
library(viridis) 

# settaggio della cartella di lavoro: 
setwd("C:/lab/Nigeria_exam")



                                                              ##### IMPORTAZIONE DEI DATI #####
                                      
                                            ##Importazione dei dati della immagine satellitare del 26/01/2022##
#CREAZIONE LISTA 
# Avendo scaricato le 7 bande separatamente le devo importare creando una lista con la funzione list.files:
list_2022 <- list.files(pattern="LC09_L2SP") # quindi creo una lista contenete le bande e la associo a list_2022  

#IMPORTAZIONE
#una volta creata la lista, applico tramite la funzione lapply la funzione raster a tutta la lista creata per importare tutto.
import_2022 <- lapply(list_2022, raster)

#CREAZIONE DI UN BLOCCO COMUNE CON TUTTI DATI IMPORTATI: 
#una volta importato tutte le 7 bande posso creare un blocco comune a tutti i dati importati tramite la funzione stack: 
Nigeria_2022 <- stack(import_2022)

# Ricampionamento 
#visto che l'immagine pesa troppo la ricampiono con funzione agregate 
n2022 <- aggregate(Nigeria_2022, fact=10)

#PLOT 
#plot normale per vedere le bande 
plot(n2022)

#immagine a colori naturali: 
#faccio un plot con la banda R nella componente R, banda G nella componente G e banda B in B per osservare l'immagine con i colori naturali 
n2022_vis <- ggRGB(n2022, 4, 3, 2, stretch="lin") + ggtitle("riserva Akure ofusu 2022")

#Nir in R, red in G, green in B. 
g1_2022 <- ggRGB(n2022, 5, 4, 3, stretch="lin") + ggtitle("ggplot 2022") 
#in questo plot è evidente la vegetazione che appare rossa e il suolo nudo. 

#2014 
# CREAZIONE LISTA 
# Avendo scaricato le 7 bande separatamente le devo importare creando una lista con la funzione list.files:
list_2015 <- list.files(pattern="LC08_L2SP") # quindi creo una lista contenete le bande e la associo a list_2022  

#IMPORTAZIONE
#una volta creata la lista, applico tramite la funzione lapply la funzione raster a tutta la lista creata per importare tutto.
import_2015 <- lapply(list_2015, raster)

#CREAZIONE DI UN BLOCCO COMUNE CON TUTTI DATI IMPORTATI: 
#una volta importato tutte le 7 bande posso creare un blocco comune a tutti i dati importati tramite la funzione stack: 
Nigeria_2015 <- stack(import_2015)

# Ricampionamento 
#visto che l'immagine pesa troppo la ricampiono con funzione agregate 
n2015 <- aggregate(Nigeria_2015, fact=10)

#PLOT 
#plot normale per vedere le bande 
plot(n2015)

#immagine a colori naturali: 
#faccio un plot con la banda R nella componente R, banda G nella componente G e banda B in B per osservare l'immagine con i colori naturali 
n2015_vis <- ggRGB(n2015, 4, 3, 2, stretch="lin") + ggtitle("riserva Akure ofusu 2015")

#Nir in R, red in G, green in B. 
g1_2015 <- ggRGB(n2015, 5, 4, 3, stretch="lin") + ggtitle("ggplot 2014") 
#in questo plot è evidente la vegetazione che appare rossa e il suolo nudo. 

# metto a confronto i plot del 2015 e del 2022che rappresenta le immagini a colori naturali
n2015_vis + n2022_vis
# metto a confronto i ploto del 2015 e del 2022 che rappresenta le immagini con l'ifrarosso vicino
g1_2015 + g1_2022 #rosso rapresenta la vegetazione 



                                                              ##### INDICI SPETTRALI #####
#2015
dvi_2015 = n2015[[5]] - n2015[[4]]
dvi_2015 # values -531.666, 12364.91 (min, max)

cl <- colorRampPalette(c("darkblue", "yellow", "red", "black")) (100)

plot(dvi_2015, col=cl) + title(main="DVI 2015")
#il giallo dovrebbe rapresentare il suolo nudo

#2022
dvi_2022 = n2022[[5]] - n2022[[4]]
dvi_2022 #values: -2203.359, 13241.65 (min, max) 

cl <- colorRampPalette(c("darkblue", "yellow", "red", "black")) (100)

plot(dvi_2022, col=cl) + title(main="DVI 2022")
#il giallo dovrebbe rapresentare il suolo nudo

par(mfrow=c(1, 2))
plot(dvi_2015, col=cl) + title(main="DVI 2015")
plot(dvi_2022, col=cl) + title(main="DVI 2022")

#differenza tra 2015 e 2022 
dvi_diff = dvi_2015 - dvi_2022 

cld <- colorRampPalette(c("blue", "white", "red")) (100)

plot(dvi_diff, col=cld) + title(main="DVI 2015 - DVI 2022")
#le zone in rosso rappresentano la deforestazione o la scomparsa in generale di vegetazione nel arco di tempo analizato. 

#Calcolo NDVI 

#2015 
ndvi_2015 = (n2015[[5]] - n2015[[4]]) / (n2015[[5]] + n2015[[4]])
plot(ndvi_2015, col=cl) + title(main = "NDVI 2015")
             
#2022
ndvi_2022 = (n2022[[5]] - n2022[[4]]) / (n2022[[5]] + n2022[[4]])
plot(ndvi_2022, col=cl) + title(main = "NDVI 2022")

par(mfrow=c(1, 2))
plot(ndvi_2015, col=cl) + title(main = "NDVI 2015")
plot(ndvi_2022, col=cl) + title(main = "NDVI 2022")

 
                                                   #### LAND COVER ####


#2015 
n2015_class <- unsuperClass(n2015, nClasses=2) 
clc <- colorRampPalette(c("yellow", "red")) (100)
plot(n2015_class$map, col=clc) + title(main ="suddivisione in classi del 2015")
#classe 1: aree di vegetazione  
#classe 2: aree di suolo nudo 

#2022
n2022_class <- unsuperClass(n2022, nClasses=2) 
clc <- colorRampPalette(c("yellow", "red")) (100)
plot(n2022_class$map, col=clc) + title(main ="suddivisione in classi del 2022")
 
#confronto le due immagini 
par(mfrow=c(1, 2))
plot(n2015_class$map, col=clc) + title(main ="suddivisione in classi del 2015")
plot(n2022_class$map, col=clc) + title(main ="suddivisione in classi del 2022")

#frequenze 

#frequenze 2015 
freq(n2015_class$map)
# value     count 
# classe 1: 300520 Pixel (vegetazione)
# classe 2: 105928 pixel (suolo nudo)
#       NA: 180244 pixel (pixel bianchi dovti all'inclinazione dell'immagine satellitare non li considero nei calcoli)

# 300520 + 105928 = 406448 quindi il totale dei pixel del 2015 è 406448 

#percentuali 2015 
tot2015 <- 406448 
perc_veg_2015 <- 300520 * 100 / tot2015    # 73.93812 %
perc_soil_2015 <- 105928 * 100 / tot2015   # 26.06188 % 

#frequenze 2022
freq(n2022_class$map)
# value     count 
# classe 1: 271822
# classe 2: 136462
#       NA: 176892

# 271822 + 136462 = 408284 quindi il totale dei pixel del 2022 è 408284 

#percentuali 2015 
tot2022 <- 408284
perc_veg_2022 <- 271822 * 100 / tot2022   # 66.5767 %
perc_soil_2022 <- 136462 * 100 / tot2022  # 33.4233 %

#creo dataframe per confrontare i dati 
#creo prima le 3 colonne 
class <- c("Vegetazione", "Suolo nudo") 
percent_2015 <- c(73.93812, 26.06188)
percent_2022 <- c(66.5767, 33.4233)

multitemporal <- data.frame(class, percent_2015, percent_2022)
View(multitemporal)

#salvo il dataframe come file csv con la funzione write.csv lo apro con exel e lo salvo come immagine da mettere nella presentazione
#write.csv(multitemporal, file = "multitemporal.csv") 

#creo gli istogrammi prima con i dati del 2015 poi con quelli del 2022

#istrgamma del 2015 
perc_2015 <- ggplot(multitemporal, aes(x=class, y=percent_2015, color=class)) + geom_bar(stat="identity", fill="white") + ggtitle("percentuale 2015")

#istogramma del 2022 
perc_2022 <- ggplot(multitemporal, aes(x=class, y=percent_2022, color=class)) + geom_bar(stat="identity", fill="white") + ggtitle("percentuale 2022")




                                    ##### VARIABILITA' #######

#2015 
nir_2015 <- n2015[[5]]

#con la funzione focal faccio passare un moving window di 3x3 che calcola la deviazione standard di ogni pixel 
sd_2015 <- focal(nir_2015, matrix(1/9, 3, 3), fun=sd)
#visione immediata della variabilità uso viridis 
g1 <- ggplot() + geom_raster(sd_2015, mapping = aes(x=x, y=y, fill=layer)) + scale_fill_viridis() + ggtitle("deviazione standar della banda NIR 2015 tramite viridis")

#in quasi tutta l'imaggine si ha bassa variabilità sia nella vegetazione sia nel suolo nudo. 

#2022
nir_2022 <- n2022[[5]]

#con la funzione focal faccio passare un moving window di 3x3 che calcola la deviazione standard di ogni pixel 
sd_2022 <- focal(nir_2022, matrix(1/9, 3, 3), fun=sd)
#visione immediata della variabilità uso viridis 
g2 <- ggplot() + geom_raster(sd_2022, mapping = aes(x=x, y=y, fill=layer)) + scale_fill_viridis() + ggtitle("deviazione standar della banda NIR 2022 tramite viridis")

g2 + g1 

                                        ### ANALISI MULTIVARIATA ###

# 2015
n2015_pca <- rasterPCA(n2015)

# faccio la summary del modello per vedere quanta variabilità spiega ogni componente 
summary(n2015_pca$model) 
# proprortion of Variance: #PC1 spiega il 76.69% #PC2 spiega il 15.90%  #PC3 spiega il 5.9% 
# faccio un plot con tutte le componenti 
plot(n2015_pca$map) 

#assegno l'oggetto alle prime 3 componenti: 
pc1_2015 <- n2015_pca$map$PC1
pc2_2015 <- n2015_pca$map$PC2
pc3_2015 <- n2015_pca$map$PC3

#tramite ggplot faccio il plot delle singole componenti, associo al plot un oggetto 
#PC1 
gpc1_2015 <- ggplot() + geom_raster(pc1_2015, mapping=aes(x=x, y=y, fill=PC1)) + ggtitle("PC1 2015")
#PC2 
gpc2_2015 <- ggplot() + geom_raster(pc2_2015, mapping=aes(x=x, y=y, fill=PC2)) + ggtitle("PC2 2015")
#PC3 
gpc3_2015 <- ggplot() + geom_raster(pc3_2015, mapping=aes(x=x, y=y, fill=PC3)) + ggtitle("PC3 2015")

#unisco tutti e tre i plot 
gpc1_2015 + gpc2_2015 + gpc3_2015

# per vedere la variabilità calcolo la deviazione standard sulla PC1 di entrambe le immagini 
# calcolo la deviazione standard della PC1 del 2015 sempre con una moving window 3 x 3 
sd_pc1_2015 <- focal(pc1_2015, matrix(1/9, 3, 3), fun=sd)
# faccio ggplot della deviazione standard della pc1 usando viridis 

Im_2015 <- ggplot() + geom_raster(sd_pc1_2015, mapping=aes(x=x, y=y, fill=layer)) + scale_fill_viridis() + ggtitle("deviazione standard della PC1 del 2015 tramite il pachetto viridis")
#bassa variabilità dove si ha la foresta 
#si hanno dei piccoli picchi di massima varibilità in corrispondenza delle zone di suolo nudo 

#visulizziamo assieme i due plot: ggplot dell'immagine del 2015 e la deviazione standard di PC1 basata su mw 3 x 3
g1_2015 + im_2015


#2022
n2022_pca <- rasterPCA(n2022)

# faccio la summary del modello per vedere quanta variabilità spiega ogni componente 
summary(n2022_pca$model) 
# proprortion of Variance: #PC1 spiega il 79.86% #PC2 spiega il 14.03%  #PC3 spiega il 4.09% 
# faccio un plot con tutte le componenti 
plot(n2022_pca$map) 

#assegno l'oggetto alle prime 3 componenti: 
pc1_2022 <- n2022_pca$map$PC1
pc2_2022 <- n2022_pca$map$PC2
pc3_2022 <- n2022_pca$map$PC3

#tramite ggplot faccio il plot delle singole componenti, associo al plot un oggetto 
#PC1 
gpc1_2022 <- ggplot() + geom_raster(pc1_2022, mapping=aes(x=x, y=y, fill=PC1)) + ggtitle("PC1 2022")
#PC2 
gpc2_2022 <- ggplot() + geom_raster(pc2_2022, mapping=aes(x=x, y=y, fill=PC2)) + ggtitle("PC2 2022")
#PC3 
gpc3_2022 <- ggplot() + geom_raster(pc3_2022, mapping=aes(x=x, y=y, fill=PC3)) + ggtitle("PC3 2022")

#unisco tutti e tre i plot 
gpc1_2022 + gpc2_2022 + gpc3_2022

# per vedere la variabilità calcolo la deviazione standard sulla PC1 di entrambe le immagini 
# calcolo la deviazione standard della PC1 del 2015 sempre con una moving window 3 x 3 
sd_pc1_2022 <- focal(pc1_2022, matrix(1/9, 3, 3), fun=sd)

# faccio ggplot della deviazione standard della pc1 usando viridis 
Im_2022 <- ggplot() + geom_raster(sd_pc1_2022, mapping=aes(x=x, y=y, fill=layer)) + scale_fill_viridis() + ggtitle("deviazione standard della PC1 del 2022 tramite il pachetto viridis")
#bassa variabilità dove si ha la foresta 
#si hanno dei piccoli picchi di massima varibilità in corrispondenza delle zone di suolo nudo 

#visulizziamo assieme i due plot: ggplot dell'immagine del 2015 e la deviazione standard di PC1 basata su mw 3 x 3
g1_2022 + Im_2022

Im_2015 + Im_2022

#i plot sono stati salvati in pdf seguendo la struttura generale: 
#pdf("nome_plot.pdf")
#plot() + 
#title(main="")
#dev.off()


