                                                                 ##### ESAME 29 AGOSTO 2022 ######
                                                                     
                                                                #### RISERVA DI AKURE OFOSU #####

# Analisi e confronto di due immagini satellitari Landsat della stessa località (Path:190, Row:055), rilevate in periodi diversi.
# l'immagine satellitare analizzata più recente è stata acquisita nel 26/01/2022 ed è stata confrontata con un altra immagine satellitare della stessa località, rilevata nel 15/01/2015
# le due immagini satellittari comprendono lo stato di Ondo situato nella Nigeria sudoccidentale; dove sono collocate la Riserva Akure Ofosu, la citta di Akure e di Ondo.
# La riserva forestale copre 394 km 2 ed è di grande importanza per la conservazione della popolazione di scimpanzé in Nigeria

# https://www.usgs.gov/faqs/what-are-band-designations-landsat-satellites # questo è il sito da cui ho scaricato le immagini satellitari con spiegazione di ogni banda. 
# nello specifico in questa analisi sono state usate immagini satellitari rilevate dal Landsat 8/9 operational Land image (OLI) and Thermal infrared Sensor (TIRS)
# dalle informazioni si ricava che:

          # B2 = Blue 
          # B3 = Green 
          # B4 = Red
          # B5 = NIR 

# risoluzione 30 m 
# 16 bit 


                                                ### Istallazione dei pachetti necessari (se non già scaricati) ###

    # install.packages("raster")
    # install.packages("RStoolbox")
    # install.packages("ggplot2")
    # install.packages("patchwork")
    # install.packages("viridis")



                                                      #### APERTURA DEI PACHETTI NECESSARI ####

library(raster) 
library(RStoolbox) # per vissualizzare le immagini e calcoli 
library(ggplot2) # per i plot ggplot e per la visualizzazione dei dati
library(patchwork) # per creare multiframe con ggplot 
library(viridis) 

                                                     ### SETTAGGIO DELLA CARTELLA DI LAVORO ### 

setwd("C:/lab/Nigeria_exam")



                                                        ##### IMPORTAZIONE DEI DATI #####
                                     
##Importazione dei dati della immagine satellitare del 26/01/2022##

# CREAZIONE LISTA
# Avendo scaricato le 7 bande separatamente le devo importare creando una lista con la funzione list.files:
list_2022 <- list.files(pattern="LC09_L2SP") # quindi creo una lista contenete le bande e la associo a list_2022  

# IMPORTAZIONE
# una volta creata la lista, per importare tutto corretamente applico, tramite la funzione lapply,la funzione raster a tutta la lista creata.
import_2022 <- lapply(list_2022, raster) # la funzione raster mi permette di importare un singolo elemento.

# CREAZIONE DI UN BLOCCO COMUNE CON TUTTI DATI IMPORTATI: 
# una volta importato tutte le 7 bande creo un blocco comune a tutti i dati importati tramite la funzione stack: 
Nigeria_2022 <- stack(import_2022)
Nigeria_2022 # controllo le informazioni # immagine a 16 bit  

# RICAMPIONAMENTO  
# visto che l'immagine pesa troppo la ricampiono con funzione aggregate 
n2022 <- aggregate(Nigeria_2022, fact=10)


list_2022 <- list.files(pattern="LC09_L2SP") # Creazione lista
import_2022 <- lapply(list_2022, raster)     # Importazione
Nigeria_2022 <- stack(import_2022) # Creazione di un blocco con tutti dati importati

n2022 <- aggregate(Nigeria_2022, fact=10) # Ricapionamento


#PLOT 
#plot normale per visualizzare tutte le bande 
plot(n2022)

# IMMAGINE A COLORI NATURALI: 
# Per osservare l'immagine con i colori naturali, faccio un plot tramite ggRGB, impostando:
   # la banda Red (4) nella componente R (red),
   # la banda Green (3) nella componente G (green) e 
   # la banda del Blue (2) nella componente B  
n2022_vis <- ggRGB(n2022, 4, 3, 2) + 
             ggtitle("riserva Akure Ofusu 2022")

#IMMAGINE CON L'INFRAROSSO:
# Per osservare l'immagine con l'infrarosso, faccio un plot tramite ggRGB, impostando: 
   # la banda NIR (5) nella componente R (red) 
   # la banda Red (4) nella componente G (green) 
   # la banda Green (3) nella componente B (Blue). 
g1_2022 <- ggRGB(n2022, 5, 4, 3) + 
           ggtitle("Riserva Akure Ofusu NIR 2022") # in questo plot è evidente il suolo nudo e la vegetazione che appare rossa  

##Importazione dei dati della immagine satellitare del 15/01/2015##

# CREAZIONE LISTA 
# Avendo scaricato le 7 bande separatamente le devo importare creando una lista con la funzione list.files:
list_2015 <- list.files(pattern="LC08_L2SP") # quindi creo una lista contenete le bande e la associo a list_2015  

# IMPORTAZIONE
# una volta creata la lista, per importare tutto corretamente applico, tramite la funzione lapply,la funzione raster a tutta la lista creata.
import_2015 <- lapply(list_2015, raster) # la funzione raster mi permette di importare un singolo elemento.

# CREAZIONE DI UN BLOCCO COMUNE CON TUTTI DATI IMPORTATI: 
# una volta importato tutte le 7 bande posso creare un blocco comune a tutti i dati importati tramite la funzione stack: 
Nigeria_2015 <- stack(import_2015)
Nigeria_2015 # # controllo le informazioni # immagine a 16 bit # confrontando con la immagine del 2022 noto che ha una dimensione diversa

# RICAMPIONAMENTO 
# Ricampiono l'immagine perchè ha dimensioni diverse da quella del 2021: 
Nigeria_2015_res <- resample(Nigeria_2015, Nigeria_2022)

# visto che l'immagine pesa troppo la ricampiono con funzione agregate 
n2015 <- aggregate(Nigeria_2015_res, fact=10)

list_2015 <- list.files(pattern="LC08_L2SP") # Creazione lista
import_2015 <- lapply(list_2015, raster)     # Importazione
Nigeria_2015 <- stack(import_2015) # Creazione di un blocco con tutti dati importati
Nigeria_2015_res <- resample(Nigeria_2015, Nigeria_2022) # ricampionamento
n2015 <- aggregate(Nigeria_2015_res, fact=10) # ricampionamento 

#PLOT 
#plot normale per visualizzare le bande 
plot(n2015)

# IMMAGINE A COLORI NATURALI: 
# Per osservare l'immagine con i colori naturali, faccio un plot tramite ggRGB, impostando:
   # la banda Red (4) nella componente R (red),
   # la banda Green (3) nella componente G (green) e 
   # la banda del Blue (2) nella componente B
n2015_vis <- ggRGB(n2015, 4, 3, 2) + 
             ggtitle("riserva Akure Ofusu 2015")

#IMMAGINE CON L'INFRAROSSO:
# Per osservare l'immagine con l'infrarosso, faccio un plot tramite ggRGB, impostando: 
   # la banda NIR (5) nella componente R (red) 
   # la banda Red (4) nella componente G (green) 
   # la banda Green (3) nella componente B (Blue). 

# 2015 
g1_2015 <- ggRGB(n2015, 5, 4, 3) + 
           ggtitle("Riserva Akure Ofusu NIR 2015") 


# in questo plot è evidente il suolo nudo e la vegetazione che appare rossa 

pdf("g1_2015_plot.pdf")
ggRGB(n2015, 5, 4, 3) + 
ggtitle("Riserva Akure Ofusu NIR 2015") 
dev.off()

# CONFRONTO LE IMMAGINI A COLORI NATURALI: 
# metto a confronto i plot del 2015 e del 202 2che rappresenta le immagini a colori naturali
n2015_vis + n2022_vis

# CONFRONTO LE IMMAGINI CON L'IFRAROSSO
# metto a confronto i ploto del 2015 e del 2022 che rappresenta le immagini con l'ifrarosso vicino
g1_2015 + g1_2022 # rosso rapresenta la vegetazione

# CONFRONTO LE 4 IMMAGINI: 
n2015_vis + n2022_vis / g1_2015 + g1_2022



                                                              ##### INDICI SPETTRALI #####

# Per valutare le condizioni della vegetazione efettuo il calcolo degli indici spettrali
# Le foglie delle piante assorbono il rosso e riflettono NIR, per questo la vegetazione diventa rossa nelle immagini con l'infrarosso nel rosso
   # Quindi se la pianta va in sofferenza riflette meno NIR e assorbe meno rosso. 

# In questa analisi verra calcolato il DVI e NDVI 

                                                ### CALCOLO DEL DVI (DIFFERENCE VEGETATION INDEX) ###

# siccome le immagini hanno la stessa risoluzione è possibile calcolare il DVI (Difference Vegetation Index) 
# DVI = Rifettanza NIR - Riflettanza Red
# Range DVI (Imaggine a 16 bit) : -65535 a 65535 

## CALCOLO DEL DVI NEL 2015 ###

# DVI nel 2015
dvi_2015 = n2015[[5]] - n2015[[4]]
dvi_2015 # values : -531.666, 12364.91 (min, max)

# Creazione di una colorRampPalette:
cl <- colorRampPalette(c("darkblue", "yellow", "red", "black")) (100)

# PLOT 
# Faccio un plot del DVI nel 2015 per visulizzare le condizioni della vegetazione 
plot(dvi_2015, col=cl) + title(main="DVI 2015") # il giallo dovrebbe rapresentare il suolo nudo

## CALCOLO DEL DVI NEL 2022 ##

# DVI nel 2022
dvi_2022 = n2022[[5]] - n2022[[4]]
dvi_2022 # values : -2203.359, 13241.65 (min, max) 

# Creazione di una colorRampPalette:
cl <- colorRampPalette(c("darkblue", "yellow", "red", "black")) (100)

# PLOT
# Faccio un plot del DVI nel 2022 per visualizzare le condizioni della vegetazione
plot(dvi_2022, col=cl) + title(main="DVI 2022") # il giallo dovrebbe rapresentare il suolo nudo

# CONFRONTO TRA I DUE DVI 
# confronto i due DVI creando un multiframe con 1 riga 2 colonne che contiene al suo interno le due immagini 
par(mfrow=c(1, 2))
plot(dvi_2015, col=cl) + title(main="DVI 2015")
plot(dvi_2022, col=cl) + title(main="DVI 2022")

# DIFFERENZA DEI DVI DELLE DUE IMMAGINI 
# Faccio la differenza tra il DVI dell'immagine del 2015 e il DVI dell'immagine del 2022 
dvi_diff = dvi_2015 - dvi_2022 

# Creazione di una ColorRampPalette:
cld <- colorRampPalette(c("blue", "white", "red")) (100)

# PLOT 
# faccio un plot della differenza dei DVI delle due immagini per valutare ed evidenziare il cambiamento di stato di salute della foresta nel tempo trascorso. 
plot(dvi_diff, col=cld) + title(main="DVI 2015 - DVI 2022") # le zone in rosso rappresentano la deforestazione o la scomparsa in generale di vegetazione nel arco di tempo analizato. 

                                                     #### CALCOLO DEL NDVI (NORMAL DIFFERENCE VEGETATION INDEX) ####

# NDVI = (Riflettanza NIR - Riflettanza RED) / (Riflettanza NIR + Riflettanza RED)
# Range NDVI (Imaggine a 16 bit) : -1 a 1

## CALCOLO NDVI NEL 2015 ##

# NDVI nel 2015
ndvi_2015 = (n2015[[5]] - n2015[[4]]) / (n2015[[5]] + n2015[[4]])

# PLOT 
# faccio il plot del NDVI nel 2015
plot(ndvi_2015, col=cl) + title(main = "NDVI 2015")
             
## CALCOLO NDVI NEL 2022

# NDVI nel 2022
ndvi_2022 = (n2022[[5]] - n2022[[4]]) / (n2022[[5]] + n2022[[4]])

# PLOT 
# Faccio il plot del NDVI nel 2022
plot(ndvi_2022, col=cl) + title(main = "NDVI 2022")

# CONFRONTO TRA I DUE NDVI 
# confronto i due NDVI creando un multiframe con 1 riga e 2 colonne che contiene al suo interno le due immagini 
par(mfrow=c(1, 2))
plot(ndvi_2015, col=cl) + title(main = "NDVI 2015")
plot(ndvi_2022, col=cl) + title(main = "NDVI 2022")
# particolarmente evidente le strade che portano da Ondo alle altre città in giallo
# in oltre dal confronto si nota una marcato aumento nella parte orientale della riserva Akure Ofuse di suolo nudo in giallo
     # Probabilmente legato agli incedi avvenuti nei ultimmi anni per ampliare le coltivazioni 

# valori     < 0.1: suolo nudo  
#        0.1 - 0.2: copertura vegetale quasi assente 
#        0.2 - 0.3: copertura vegetale molto bassa 
#        0.3 - 0.4: copertura vegetale bassa con vigoria bassa o copertura vegetale bassa con vigoria molto alta 




                                                          #### LAND COVER ####

# Per analizzare come è cambiato l'utilizzo suolo in un intervallo di tempo di 7 anni 
# prima efettuo una classificazione in base alla disposizione dei pixel nello spazio a 3 bande 
# suddividendo i pixel in 2 classi: aree di vegetazione e aree di suolo nudo per ogni immagine 
# calcolo la frequenza di ogni classe per ogni immagine 
# confronto le due immagini
  
                                                  ## SUDDIVISIONE IN DUE CLASSI DELLE IMMAGINI ##

# SUDDIVISIONE IN 2 CLASSI DELL'IMMAGINE NEL 2015

# suddivido i pixel dell'immagine in 2 classi tramite la funzione unsuperClass e la associo a n2015_class:
n2015_class <- unsuperClass(n2015, nClasses=2) 

# creo una colorRampPalette e la associo a clc:
clc <- colorRampPalette(c("yellow", "red")) (100)

# PLOT 
# effetuo un plot dove si evidenzia la suddivisione nelle due classi che prendono i colori assegnati dalla colorRampPalette:
plot(n2015_class$map, col=clc) + title(main ="suddivisione in classi 2015")
# classe 1: aree di vegetazione (appare di colore giallo)
# classe 2: aree di suolo nudo (appare di colore rosso) 

# SUDDIVISIONE IN 2 CLASSI DELL'IMMAGINE NEL 2022

# suddivido i pixel dell'immagine in 2 classi tramite la funzione unsuperClass e la associo a n2015_class:
n2022_class <- unsuperClass(n2022, nClasses=2)

# creo una colorRampPalette e la associo a clc:
clc <- colorRampPalette(c("yellow", "red")) (100)

# PLOT
# effetuo un plot dove si evidenzia la suddivisione nelle due classi che prendono i colori assegnati dalla colorRampPalette:
plot(n2022_class$map, col=clc) + title(main ="suddivisione in classi 2022")
# classe 1: aree di vegetazione (appare di colore giallo)
# classe 2: aree di suolo nudo (appare di colore rosso) 
 
# CONFRONTO LE DUE IMMAGINI CLASSIFICATE
# confronto le due immagini classificate creando un multiframe con 1 riga e 2 colonne che contiene al suo interno le due immagini
par(mfrow=c(1, 2))
plot(n2015_class$map, col=clc) + title(main ="suddivisione in classi 2015")
plot(n2022_class$map, col=clc) + title(main ="suddivisione in classi 2022")
# classe 1: aree di vegetazione (appare di colore giallo) 
# classe 2: aree di suolo nudo (appare di colore rosso) 
# si nota un aumento nel 2022 delle aree di suolo nudo.

                                                   ## CALCOLO DELLE FREQUENZE DELLE DUE IMMAGINI CLASSIFICATE ##

# FREQUENZE DELL'IMMAGINE DEL 2015:

# Calcolo le frequenze dell'immagine del 2015 classificata tramite la funzione freq: 
freq(n2015_class$map)
# value     count 
# classe 1: 300520 Pixel (vegetazione)
# classe 2: 105928 pixel (suolo nudo)
#       NA: 180244 pixel (pixel bianchi dovti all'inclinazione dell'immagine satellitare non li considero nei calcoli)

# Calcolo il totale dei pixel dell'immagine del 2015 classificata per poi calcolarmi le percentuali di ciascuna classe:
#  totale: 300520 + 105928 = 406448 pixel
# quindi il totale dei pixel dell'immagine del 2015 classificata è 406448 pixel

# PERCENTUALI DELL'IMMAGINE DEL 2015: 

# Calcolo le percentuali dell'immagine del 2015 classificata per renderla confrontabile 
# Calcolo tramite la semplice formula: count della classe * 100 / totale dei pixel della immagine classificata 
tot2015 <- 406448 # assegno il totale dei pixel della immagine del 2015 classificata a tot2015
perc_veg_2015 <- 300520 * 100 / tot2015    # 73.93812 %
perc_soil_2015 <- 105928 * 100 / tot2015   # 26.06188 % 

# FREQUENZE DELL'IMMAGINE DEL 2022:

# Calcolo le frequenze dell'immagine del 2022 classificata tramite la funzione freq: 
freq(n2022_class$map)
# value     count 
# classe 1: 271822 Pixel (vegetazione)
# classe 2: 136462 Pixel (suolo nudo)
#       NA: 176892 Pixel (Pixel bianchi dovuti all'inclinazione dell'immagine satellitare non li considero nei calcoli)

# Calcolo il totale dei pixel dell'immagine del 2022 classificata per poi calcolarmi le percentuali di ciascuna classe:
#  totale: 271822 + 136462 = 408284 pixel 
# quindi il totale dei pixel dell'immagine del 2022 classificata è 408284 pixel 

# PERCENTUALI DELL'IMMAGINE DEL 2022: 

# Calcolo le percentuali dell'immagine del 2022 classificata per renderla confrontabile 
# Calcolo tramite la semplice formula: count della classe * 100 / totale dei pixel della immagine classificata 
tot2022 <- 408284 # assegno il totale dei pixel della immagine del 2022 classificata a tot2022
perc_veg_2022 <- 271822 * 100 / tot2022   # 66.5767 %
perc_soil_2022 <- 136462 * 100 / tot2022  # 33.4233 %

# CONFRONTO DEI DATI PERCENTUALI 

#creo dataframe per confrontare i dati percentuali ottenuti dalle analisi precedenti 
#creo prima le 3 colonne 
class <- c("Vegetazione", "Suolo nudo") # assegno un vettore a un ogetto che rapresenta la prima colonna 
percent_2015 <- c(73.93812, 26.06188) # assegno un vettore a un ogetto che rappresenta la seconda colonna 
percent_2022 <- c(66.5767, 33.4233) # assegno un vettore a un ogetto che rappresenta la terza colonna  

# creo il dataframe tramite la funzione data.frame e la associo a multitemporal: 
multitemporal <- data.frame(class, percent_2015, percent_2022)
View(multitemporal) # Per visulizzare il dataframe in formato tabella

#salvo il dataframe come file csv con la funzione write.csv lo apro con exel e lo salvo come immagine da mettere nella presentazione
#write.csv(multitemporal, file = "multitemporal.csv") 

# CREAZIONE DI ISTOGRAMMI PER IL CONFRONTO DATI: 

# Creo un istrgamma che rappresenti i dati percentuali ottenuti dalle due classi dell'immagine del 2015 classificata: 
perc_2015 <- ggplot(multitemporal, aes(x=class, y=percent_2015, color=class)) + geom_bar(stat="identity", fill="white") + ggtitle("percentuale 2015")

# Creo un istrgamma che rappresenti i dati percentuali ottenuti dalle due classi dell'immagine del 2022 classificata: 
perc_2022 <- ggplot(multitemporal, aes(x=class, y=percent_2022, color=class)) + geom_bar(stat="identity", fill="white") + ggtitle("percentuale 2022")

# CONFRONTO DEI 2 ISCTOGRAMMI: 
perc_2015 + perc_2022 # si nota come la percentuale delle aree a suolo nudo sia aumentata dal 2015 al 2022 e l'area vegetale sia diminuita 



                                                     ##### VARIABILITA' #######

# calcolo la variabilità nello spazio 
# la variabile che utilizzo per calcolare la variabilità nello spazio delle immagini analizzate è la deviazione standard
# la deviazione standard misura la variabilita intorno alla media.
# più aumeta la diversità di valori e maggiore sarà la deviazione standard maggiore sarà la variabilità 
# questi calcoli vanno effetuati su una singola variabile # quindi dei layer che ho a disposizione (le bande della immagine satellitare) devo sceglierne uno 
# perciò scelgo la banda NIR ( Banda 5 dell'infrarosso vicino) perchè sarebbe il layer più informativo visto che la vegetazione riflette moltissimo la luce NIR.


# VARIABILITA' DELL'IMMAGINE NEL 2015 NELLA BANDA NIR

# estraggo la banda del NIR (5) dall'immagine n2015 e la associo a uno ogetto chiamato nir_2015
nir_2015 <- n2015[[5]]

# CALCOLO DEVIAZIONE STANDARD
# con la funzione focal faccio passare un moving window di 3x3 che calcola la deviazione standard di ogni pixel 
# deviazione standard definta dalla funzione sd
sd_2015 <- focal(nir_2015, matrix(1/9, 3, 3), fun=sd) # genero tramite la funzione matrix una matrice di 3 X 3 pixel definendo l'unita 1/9 e il numero di colonne e righe (3, 3)

# per avere una visione immediata della variabilità uso viridis # ho usato la opzione Plasma perchè risalta maggiormente la variabilità
g1 <- ggplot() + geom_raster(sd_2015, mapping = aes(x=x, y=y, fill=layer)) + scale_fill_viridis(option = "plasma") + ggtitle("deviazione standar della banda NIR 2015 tramite viridis")
g1 
# il massimo della variabilita è in corrispondenza del Lagos Lagoon a sud est della immagine e in corrispondenza delle citta di Ondo
# si nota molto bene che si ha un alta variabilita nelle zone di transizione tra vegetazione e suolo nudo 
# si ha un bassa variabilità dove si ha vegetazione e suolo nudo 

# VARIABILITA' DELL'IMMAGINE NEL 2022

# estraggo la banda del NIR (5) dall'immagine n2022 e la associo a uno ogetto chiamato nir_2022
nir_2022 <- n2022[[5]]

# CALCOLO DEVIAZIONE STANDARD
# con la funzione focal faccio passare un moving window di 3x3 che calcola la deviazione standard di ogni pixel 
sd_2022 <- focal(nir_2022, matrix(1/9, 3, 3), fun=sd)

# per avere una visione immediata della variabilità uso viridis 
g2 <- ggplot() + geom_raster(sd_2022, mapping = aes(x=x, y=y, fill=layer)) + scale_fill_viridis(option = "plasma") + ggtitle("deviazione standar della banda NIR 2022 tramite viridis")

# CONFRONTO FRA LE DUE IMMAGINI: 
g2 + g1 
# si riesce apprezzare abbastanza bene la differenza tra le due immagini sebbene abbia usato le immagini ricampionate 
# 

  
                                                               ### ANALISI MULTIVARIATA ###

# tramite l'analisi multivariata anziche scegliere una sola variabile posso compattare tutti i dati in un sistema più semplice 

# ANALISI MULTIVARIATA SULLA IMMAGINE DEL 2015:
n2015_pca <- rasterPCA(n2015)

# faccio la summary del modello per vedere quanta variabilità spiega ogni componente 
summary(n2015_pca$model) 
# proprortion of Variance: #PC1 spiega il 76.69% #PC2 spiega il 15.90%  #PC3 spiega il 5.9% 

# PLOT
# Effetto un plot con tutte le componenti 
plot(n2015_pca$map) 

# assegno l'oggetto alle prime 3 componenti: 
pc1_2015 <- n2015_pca$map$PC1
pc2_2015 <- n2015_pca$map$PC2
pc3_2015 <- n2015_pca$map$PC3

# tramite ggplot faccio il plot delle singole componenti
# associo al plot un oggetto 
# PC1 
gpc1_2015 <- ggplot() + geom_raster(pc1_2015, mapping=aes(x=x, y=y, fill=PC1)) + ggtitle("PC1 2015")
#PC2 
gpc2_2015 <- ggplot() + geom_raster(pc2_2015, mapping=aes(x=x, y=y, fill=PC2)) + ggtitle("PC2 2015")
#PC3 
gpc3_2015 <- ggplot() + geom_raster(pc3_2015, mapping=aes(x=x, y=y, fill=PC3)) + ggtitle("PC3 2015")

#unisco tutti e tre i plot 
gpc1_2015 + gpc2_2015 + gpc3_2015

# CALCOLO LA DEVIAZIONE STANDARD 
# per vedere la variabilità calcolo la deviazione standard sulla PC1 di entrambe le immagini 
# calcolo la deviazione standard della PC1 del 2015 sempre con una moving window 3 x 3 
sd_pc1_2015 <- focal(pc1_2015, matrix(1/9, 3, 3), fun=sd)

# PLOT
# faccio ggplot della deviazione standard della pc1 usando viridis 
Im_2015 <- ggplot() + geom_raster(sd_pc1_2015, mapping=aes(x=x, y=y, fill=layer)) + scale_fill_viridis(option = "cividis") + ggtitle("deviazione standard della PC1 del 2015 tramite il pachetto viridis")
# bassa variabilità dove si ha la foresta e il suolo nudo
# la massima variabilità è in corrispondenza delle zone di transizione tra vegetazione e suolo nudo 
# si riesce a notare anche le strade che tagliano la vegetazione per collegare le varie città 

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
Im_2022 <- ggplot() + geom_raster(sd_pc1_2022, mapping=aes(x=x, y=y, fill=layer)) + scale_fill_viridis(option = "cividis") + ggtitle("deviazione standard della PC1 del 2022 tramite il pachetto viridis")
#bassa variabilità dove si ha la foresta 
#si hanno dei piccoli picchi di massima varibilità in corrispondenza delle zone di suolo nudo 

#visulizziamo assieme i due plot: ggplot dell'immagine del 2015 e la deviazione standard di PC1 basata su mw 3 x 3
g1_2022 + Im_2022

# visualizziamo assieme i plot della variabilità calcolata sulla PC1 per entrambi gli anni
Im_2015 + Im_2022

#i plot sono stati salvati in pdf seguendo la struttura generale: 
#pdf("nome_plot.pdf")
#plot() + 
#title(main="")
#dev.off()


