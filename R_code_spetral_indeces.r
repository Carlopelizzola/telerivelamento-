# Calcolo degli indici di vegetazione

# install.packages("rgdal")
# install.packages("RStoolbox")
# install.packages("rasterdiv")

library( raster ) # Se ho problemi con le immagini .jpg scarica il pacchetto "rgdal"
# library(rgdal)
# library(RStoolbox)
# library(rasterdiv)

# Installiamo il pacchetto rasterdiv
install.packages( " rasterdiv " )
libreria ( rasterdiv )
trama( copNDVI )

#settaggio della cartella di lavoro
# setwd("~/lab/") # Linux
setwd("C:/lab/") # Windows
# setwd("/Users/name/Desktop/lab/") # Mac

# Importa il primo file -> defor1_.jpg -> assegnagli il nome l1992. L'immagine è a 8 bit
l1992  <- brick( " defor1_.jpg " )
l1992

# Plottiamoimmagine per vedere a quali colori della banda le bande, il numero della banda lo metto a caso perché non so a quali componenti corrispondenti.
plotRGB( l1992 , r = 1 , g = 2 , b = 3 , stretch = " lin " )
# Banda 1 è NIR perché nel plot la vegetazione è rossa. Di solito le bande vengono montate in sequenza, quindi la banda 2 corrisponde a R, e la banda 3 al G.

# Banda 1 = NIR
# Banda 2 = rosso
# Banda 3 = verde

# Esercizio: importa il secondo file -> defor2_.jpg -> assegnagli il nome l2006. L'immagine è a 8 bit
l2006  <- brick( " defor2_.jpg " )

# Plottiamo l'immagine
plotRGB( l2006 , r = 1 , g = 2 , b = 3 , stretch = " lin " )

# Esercizio: traccia in multiframe le due immagini una sopra l'altra
par( mfrow = c( 2 , 1 ))
plotRGB( l1992 , r = 1 , g = 2 , b = 3 , stretch = " lin " )
plotRGB( l2006 , r = 1 , g = 2 , b = 3 , stretch = " lin " )

# Calcoliamo indice spettrale: DVI, Difference Vegetation Index. Riflettanza NIR - Riflettanza ROSSO
dvi1992  =  l1992 [[ 1 ]] -  l1992 [[ 2 ]]
# o
dvi1992  =  l1992 $ defor1_.1  -  l1992 $ defor1_.2

# Facciamo il plot di questo dato
cl  <- colorRampPalette(c( " darkblue " , " yellow " , " red " , " black " )) ( 100 )
plot( dvi1992 , col = cl )

# Calcoliamo DVI per il 2006
dvi2006  =  l2006 [[ 1 ]] -  l2006 [[ 2 ]]
# o
dvi2006  =  l2006 $ defor1_.1  -  l2006 $ defor1_.2

# Plottiamo il dvi2006
cl  <- colorRampPalette(c( " darkblue " , " yellow " , " red " , " black " )) ( 100 )
plot( dvi2006 , col = cl )

# Facciamo la differenza tra i due indici. Le zone rosse alle zone fortemente soggette a deforestazione, alta variazione della salute delle piante.
dvi_dif  =  dvi1992  -  dvi2006
cld  <- colorRampPalette(c( " blue " , " white " , " red " )) ( 100 )
plot( dvi_dif , col = cld )


# 31 marzo
# NDVI è DVI ma standardizzato, per poter fare confrontare tra immagini che hanno risoluzione diversa (es. 8 bit vs 16 bit): si calcola facendo: NIR - RED / NIR + RED

# Range DVI (immagine a 8 bit): -255 a 255
# Range NDVI (immagine a 8 bit): -1 a 1

# Range DVI (immagine a 16 bit): -65535 a 65535
# Range NDVI (immagine a 16 bit): -1 a 1

# Quindi NDVI può essere usato anche con immagini con risoluzione radiometrica diversa

#NDVI 1992
dvi1992  =  l1992 [[ 1 ]] -  l1992 [[ 2 ]]
ndvi1992  =  dvi1992  / ( l1992 [[ 1 ]] +  l1992 [[ 2 ]])
# o
ndvi1992  = ( l1992 [[ 1 ]] -  l1992 [[ 2 ]]) / ( l1992 [[ 1 ]] +  l1992 [[ 2 ]])
plot( ndvi1992 , col = cl )

# Esercizio: multiframe con il plotRGB dell'immagine sopra e NDVI sotto
par( mfrow = c( 2 , 1 ))
plotRGB( l1992 , r = 1 , g = 2 , b = 3 , stretch = " lin " )
plot( ndvi1992 , col = cl )

#NDVI 2006
dvi2006  =  l2006 [[ 1 ]] -  l2006 [[ 2 ]]
ndvi2006  =  dvi2006  / ( l2006 [[ 1 ]] +  l2006 [[ 2 ]])
plot( ndvi2006 , col = cl )

# Multiframe con NDVI1992 sopra e NDVI2006 sotto
par( mfrow = c( 2 , 1 ))
plot( ndvi1992 , col = cl )
plot( ndvi2006 , col = cl )

# Indici spettrali automatici tramite la funzione spectralIndices
libreria ( RStoolbox )

si1992  <- spectralIndices( l1992 , verde = 3 , rosso = 2 , nir = 1 )
plot( si1992 , col = cl )

si2006  <- spectralIndices( l2006 , verde = 3 , rosso = 2 , nir = 1 )
plot( si2006 , col = cl )
