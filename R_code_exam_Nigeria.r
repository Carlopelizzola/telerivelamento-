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

# metto a confronto il plot del 2015 e quello del 2021 
n2015_vis + n2022_vis
#
g1_2015 + g1_2022 
