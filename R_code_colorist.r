# Colorist lavora solo con ggplot2 e con file RasterStack

libreria ( colorista )
libreria ( ggplot2 )

# Mappiamo distribuzione di una specie con ciclo annuale: dal 1 gennaio al 31 dicembre
# File che contiene dati sugli uccelli
data( " fiespa_occ " )
fiespa_occ

# Creare le metriche
met1  <- metrics_pull( fiespa_occ )

# Creare la tavolozza
amico  <- palette_timecycle ( fiespa_occ )

# Creare mappa multipla per capire dove sono queste specie. Dividi in 3 colonne le mappe multiple
map_multiples ( met1 , pal , ncol  =  3 , etichette  = nomi ( fiespa_occ ))

# Estrarre un solo mese:
map_single( met1 , pal , layer  =  6 )

# Manipoliamo mappa: cambiamo il colore delle mappe.
# Con 60 si parte dal giallo invece che dal blu, 240, come invece era impostato per gennaio
p1_custom  <- palette_timecycle ( 12 , start_hue  =  60 )

map_multiples ( met1 , p1_custom , etichette  = nomi ( fiespa_occ ), ncol  =  4 )

# Uniamo i livelli, compattiamoli
met1_distill  <- metrics_distill( fiespa_occ )
map_single( met1_distill , amico )

map_single( met1_distill , p1custom )

# Creare leggenda
legend_timecycle( amico , origin_label  =  " 1 gen " )




# Esempio con specie: Pekania pennati
data( " fisher_ud " )

# Metrica
met2  <- metrics_pull( fisher_ud )

# Tavolozza: tempo lineare, non annuale
pal2  <- palette_timeline ( fisher_ud )

head( pal2 ) # Vedere valori

# Mappa multipla
map_multiples( met2 , pal2 , necol  =  3 )

# Lambda: fattore lambda, capiamo poco dalla mappa multipla che indica la distribuzione della specie in 9 notti
# Lambda: cambiando il valore si può passare da opacità alta a bassa. Qui è bassa, quindi se mettiamo il valore -12, mettendo l'opacità massima, si vedrà meglio
map_multiples( met2 , pal2 , ncol  =  3 , lambda_i  =  - 12 )

met2_distill  <- metrics_distill( fisher_ud )

map_single( met2_distill , pal2 , lambda_i  =  - 10 )

# Leggenda
legend_timeline( pal2 )

# Codice Ludovico
https : // github.com / Ludovico - Chieffallo / Lezioni 
