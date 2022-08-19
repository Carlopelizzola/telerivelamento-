# Codice R per l'analisi dei dati LiDAR

libreria ( raster )
library( RStoolbox ) # Per poter usare la funzione resample, in alternativa si può usare il pacchetto rgdal
libreria ( viridis )
libreria ( ggplot2 )

install.packages( " lidR " )
libreria( lidR )

setwd( " C:/lab/dati/ " )

# Importo i dati relativi al 2004, zona di San Genesio (vicino Bolzano). La risoluzione è di 2,5m
# Importo il DSM del 2004, è la parte più alta degli alberi che viene colpita dal raggio. Modello di superficie digitale
dsm_2004  <- raster( " 2004Elevation_DigitalElevationModel-2.5m.tif " )

# Importo il DTM del 2004, corrisponde al suolo colpito dal raggio. Modello digitale del terreno
dtm_2004  <- raster( " 2004Elevation_DigitalTerrainModel-2.5m.tif " )

# Trama per vedere intanto le due immagini
trama ( dsm_2004 )
trama ( dtm_2004 )

# Posso calcolare CHM relativo al 2004, Canopy Height Model, facendo la differenza tra DSM e DTM
chm_2004  <-  dsm_2004  -  dtm_2004

# Faccio il plot di CHM. Ogni colore della leggenda corrisponde ad un'altezza: dal bianco del suolo fino al verde del bosco.
trama( chm_2004 )

# Importo i dati relativi al 201, la zona è sempre quella di San Genesio. La risoluzione è di 0.5m
# Importo il DSM del 2013
dsm_2013  <- raster( " 2013Elevation_DigitalElevationModel-0.5m.tif " )

# Importo il DTM del 2013
dtm_2013  <- raster( " 2013Elevation_DigitalTerrainModel-0.5m.tif " )

# Calcolo CHM.
chm_2013  <-  dsm_2013  -  dtm_2013

# Voglio fare un confronto tra CHM del 2004 e CHM del 2013.
# Facendo una semplice differenza tra 2013 e 2004 viene segnalato errore perchè hanno due risoluzioni diverse.
# Bisogna avere la stessa risoluzione: facciamo un ricampionamento per avere la risluzione del chm_2013 uguale a quella del 2004
# In questi casi è meglio passare da una risoluzione migliore a quella peggiore tra le due.

chm_2013_resampled  <- resemple ( chm_2013 , chm_2004 )
# Dopo aver ricampionato posso calcolare la differenza tra i due CHM
differenza_chm  <-  chm_2013_ricampionato  -  chm_2004

# Faccio un plot con ggplot della differenza tra i CHM e uso viridis
ggplot() + 
  geom_raster( differenza_chm , mappatura  = aes( x = x , y = y , riempimento = livello )) + 
  scale_fill_viridis() +
  ggtitle( " Differenza CHM San Genesio/Jenesien " )
  

# Con la funzione readLAS, che legge il formato .laz, posso vedere la nube di punti da cui sono stati presi DSM e DTM.
point_cloud  <- readLAS( " point_cloud.laz " )
traccia ( nuvola di punti )
