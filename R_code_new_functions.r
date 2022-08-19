# 3 giugno pomeriggio: Lezione con Elisa Thouverai sulla creazione di nuove funzioni da zero

cheer_me  <-  funzione ( tuo_nome ) {
  cheer_string  <- paste( " Hello " , your_name , sep  =  "  " )
  print( cheer_string )
}

cheer_me( " Letizia " )

cheer_me_n_times  <-  funzione ( tuo_nome , n ) {
  cheer_string  <- paste( " Hello " , your_name , sep  =  "  " )
  
  for ( io  in seq( 1 , n )) {
  print( cheer_string )
}
}

# for() è il ciclo for, elemento i si ripete n volte
cheer_me_n_times( " Letizia " , 3 )



libreria ( raster )
setwd( " C:/lab/ " )
dato  <- raster( " sentinel.png " )
trama( dato )

# Funzione scegliere la tavolozza di colori
plot_raster  <-  funzione ( r , col  =  NA ) {
  se ( ! è.na( col )) {
  pal  <- colorRampPalette( col ) ( 100 )
  plot( r , col  =  amico )
  } altro {
  
  trama ( r )
  }
}

plot_raster( dato , c( " brown " , " yellow " , " green " ))

plot_raster( dato ) # Colori di default
