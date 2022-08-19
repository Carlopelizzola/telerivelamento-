 Variabilità del codice R 2 - Utilizzo dei componenti del PC

libreria ( raster )
libreria ( RStoolbox )
libreria ( ggplot2 )
libreria ( patchwork )
libreria ( viridis )
setwd( " C:/lab/ " )

# Importo l'immagine del ghiacciaio del Similaun
# La funzione brick serve per poter importare l'intero pacchetto di dati
sen  <- brick( " sentinel.png " )
sen

# banda 1 = NIR
# fascia 2 = rossa
# banda 3 = verde

# Faccio un plot dell'immagine con ggplot
# Lo stretch è già lineare, non è necessario speficarlo con ggplot
ggRGB( sen , 1 , 2 , 3 )

# Esercizio: visualizza l'immagine come la vegetazione diventa verde e il terreno diventa viola
ggRGB( sen , 2 , 1 , 3 )

# Analisi multivariata: passiamo da 3 layer a PC1 che compatta tutte le informazioni
# In questo caso non ho fatto il ricampionamento perché l'immagini è leggera
sen_pca  <- rasterPCA( sen )
sen_pca
# Ci sono tanti gruppi, nella classificazione ad es. avevo solo la $mappa
# Per la PCA ci sono diversi componenti:
# $call è la funzione che abbiamo usato
# $model è il modello che segue: faccio la matrice di dove attraversare le bande per vedere far passare gli assi della PCA
# $map è la mappa finale
# attr sono gli attributi, quindi la funzione e il pacchetto che abbiamo usato

# Faccio sapere un riepilogo del modello per quanta variabilità spiega la PCA.
riepilogo ( modello sen_pca $ )
# Proporzione di varianza: componente 1 spiega 67%, la 2 il 32% e la 3 il 0.3%.

# Faccio un plot per vedere le singole bande.
# PC1 spiega gran parte della variabilità.
trama( sen_pca $ mappa )

# Assegno a ogni componente un oggetto
pc1  <-  sen_pca $ mappa $ PC1
pc2  <-  sen_pca $ mappa $ PC2
pc3  <-  sen_pca $ mappa $ PC3

# Con ggplot il plot delle singole componenti, associamo al plot un oggetto
g1  <- ggplot() + 
geom_raster( pc1 , mapping = aes( x = x , y = y , fill = PC1 ))

g2  <- ggplot() + 
geom_raster( pc2 , mapping = aes( x = x , y = y , fill = PC2 ))

g3  <- ggplot() + 
geom_raster( pc3 , mapping = aes( x = x , y = y , fill = PC3 ))

# Con patchwork sommo che complotto
g1  +  g2  +  g3

# Deviazione standard di PC1: applico il calcolo della deviazione standard all'immagine della PC1 con la funzione focal
sd3  <- focal( pc1 , matrice ( 1 / 9 , 3 , 3 ), divertimento = sd )
SD3

# Mappa per ggplot la deviazione standard del primo componente principale
ggplot() + 
geom_raster( sd3 , mappatura = aes( x = x , y = y , riempimento = livello ))

# Con viridis
ggplot() + 
geom_raster( sd3 , mappatura  = aes( x = x , y = y , riempimento = livello )) + 
scale_fill_viridis() +
ggtitle( " Deviazione standard dal pacchetto viridis " )

#cividi _
ggplot() + 
geom_raster( sd3 , mappatura  = aes( x = x , y = y , riempimento = livello )) + 
scale_fill_viridis( opzione  =  " cividis " ) +
ggtitle( " Deviazione standard dal pacchetto viridis " )

# magma
ggplot() + 
geom_raster( sd3 , mappatura  = aes( x = x , y = y , riempimento = livello )) + 
scale_fill_viridis( opzione  =  " magma " ) +
ggtitle( " Deviazione standard dal pacchetto viridis " )

# inferno
ggplot() + 
geom_raster( sd3 , mappatura  = aes( x = x , y = y , riempimento = livello )) + 
scale_fill_viridis( opzione  =  " inferno " ) +
ggtitle( " Deviazione standard dal pacchetto viridis " )


# Immagini in totale:
im1  <- ggRGB( sen , 2 , 1 , 3 )

im2  <- ggplot() + 
geom_raster( pc1 , mapping = aes( x = x , y = y , fill = PC1 ))

im3  <- ggplot() +
geom_raster( sd3 , mappatura = aes( x = x , y = y , riempimento = livello )) +
scale_fill_viridis( opzione = " inferno " )

# im1: immagine originale, l' RGB che abbiamo creato
# im2: è il componente principale su cui abbiamo calcolato la deviazione standard
# im3: è la deviazione standard basata sulla leggenda "inferno" di viridis su una mw di 3x3
# im4: è la deviazione standard basata sulla leggenda "inferno" di viridis ma su una mw 5x5
# im5: è la deviazione standard basata sulla leggenda "inferno" di viridis ma su una mw 7x7

# Calcola l'eterogeneità in una finestra mobile 5x5
sd5  <- focal ( pc1 , matrice ( 1/25 , 5 , 5 ) , divertimento = sd )
SD5

im4  <- ggplot() +
geom_raster( sd5 , mappatura = aes( x = x , y = y , riempimento = livello )) +
scale_fill_viridis( opzione = " inferno " )

im3  +  im4 

# Calcola l'eterogeneità in una finestra mobile 7x7
sd7  <- focal( pc1 , matrice ( 1 / 49 , 7 , 7 ), divertimento = sd )
sd7

im5  <- ggplot() +
geom_raster( sd7 , mappatura = aes( x = x , y = y , riempimento = livello )) +
scale_fill_viridis( opzione = " inferno " )

im3  +  im4  +  im5 
