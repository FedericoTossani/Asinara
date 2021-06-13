#################
#### Asinara ####
#################

# progetto per l'esame di Telerilevamento geo_ecologico

# Analisi da remoto della vegetaione del Parco Nazionale dell'Asinara
# Il dataset è formato da immagini Landsat dal 1984 al 2021.
# Tot. img: 28
# Anni mancanti: 1986, 1994, 1998, 2004, 2005, 2008, 2009, 2011, 2012
# Obiettivo: valutare il cambiamento della vegetazione dopo la chiusura del carcere e la fine della manutenzione agricola dell'isola

#################
#### Summary #### 
#################

# 1. Library & Working directory
# 2. Preparazione immagini
# 3.

########################################
#### 1. Library & Working directory ####
########################################

require(raster)
require(rgdal)
require(RStoolbox)
require(rasterdiv)
require(rasterVis)
require(ggplot2)
require(gridExtra)
setwd("/Users/federicotossani/Asinara/L_image")

##################################
#### 2. Preparazione immagini ####
##################################

### 2.1 Estensione del crop ###

# per ottenre il giusto crop dell'immagine ho usato la funzione draw.extent per disegnare l'area da tagliare sul plot dell'immagine a colori naturali.
# essendo che per coprire gli anni studiati ho dovuto usare due diverse immagini, p193r32 e p194r31 l'operazione di crop è stata fatta due volte.
# NB. le due immagini qui plottate sono state precedentemente importate con i comandi4

### p193r32 ###
p84 <- plotRGB(p84t, 3, 2, 1, stretch="lin")
drawExtent(show=TRUE, col="red")
#class      : Extent 
#xmin       : 431858.1 
#xmax       : 445413 
#ymin       : 4532960 
#ymax       : 4552802 

### p194r31 ###
p03 <- plotRGB(p03t, 3, 2, 1, stretch="lin")
drawExtent(show=TRUE, col="red")
#class      : Extent 
#xmin       : 432846.3 
#xmax       : 445918.7 
#ymin       : 4534674 
#ymax       : 4553130 

### 2.2 

## 1984 ##
list84<-list.files(pattern="1984")
import84<-lapply(list84, raster)
p84t<-stack(import84)
p84<-crop(p84t, extent(431858.1, 445413, 4532960, 4552802))
writeRaster(p84, filename="p193r32_1984.grd", format="raster")
p84<-brick("p193r32_1984.grd")
p84p<-plotRGB(p84, r=4, g=3, b=2, stretch="lin")

## 1985 ##
list85<-list.files(pattern="1985")
import85<-lapply(list85, raster)
p85t<-stack(import85)
p85<-crop(p85t, extent(431858.1, 445413, 4532960, 4552802))
writeRaster(p85, filename="p193r32_1985.grd", format="raster")
p85p<-plotRGB(p85, r=4, g=3, b=2, stretch="lin")

## 1987 ##
list87<-list.files(pattern="1987")
import87<-lapply(list87, raster)
p87t<-stack(import87)
p87<-crop(p87t, extent(431858.1, 445413, 4532960, 4552802))
writeRaster(p87, filename="p193r32_1987.grd", format="raster")
p87p<-plotRGB(p87, r=4, g=3, b=2, stretch="lin")

## 1988 ##
list88<-list.files(pattern="1988")
import88<-lapply(list88, raster)
p88t<-stack(import88)
p88<-crop(p88t, extent(431858.1, 445413, 4532960, 4552802))
writeRaster(p88, filename="p193r32_1988.grd", format="raster")
p88p<-plotRGB(p88, r=4, g=3, b=2, stretch="lin")

## 1989 ##
list89<-list.files(pattern="1989")
import89<-lapply(list89, raster)
p89t<-stack(import89)
p89<-crop(p89t, extent(431858.1, 445413, 4532960, 4552802))
writeRaster(p89, filename="p193r32_1989.grd", format="raster")
p89p<-plotRGB(p89, r=4, g=3, b=2, stretch="lin")

## 1990 ##
list90<-list.files(pattern="1990")
import90<-lapply(list90, raster)
p90t<-stack(import90)
p90<-crop(p90t, extent(431858.1, 445413, 4532960, 4552802))
writeRaster(p90, filename="p193r32_1990.grd", format="raster")
p90p<-plotRGB(p90, r=4, g=3, b=2, stretch="lin")

## 1991 ##
list91<-list.files(pattern="1991")
import91<-lapply(list91, raster)
p91t<-stack(import91)
p91<-crop(p91t, extent(431858.1, 445413, 4532960, 4552802))
writeRaster(p91, filename="p193r32_1991.grd", format="raster")
p91p<-plotRGB(p91, r=4, g=3, b=2, stretch="lin")

## 1992 ##
list92<-list.files(pattern="1992")
import92<-lapply(list92, raster)
p92t<-stack(import92)
p92<-crop(p92t, extent(431858.1, 445413, 4532960, 4552802))
writeRaster(p92, filename="p193r32_1992.grd", format="raster")
p92p<-plotRGB(p92, r=4, g=3, b=2, stretch="lin")

## 1993 ##
list93<-list.files(pattern="1993")
import93<-lapply(list93, raster)
p93t<-stack(import93)
p93<-crop(p93t, extent(432846.3, 445918.7, 4534674, 4553130))
writeRaster(p93, filename="p194r31_1993.grd", format="raster")
p93p<-plotRGB(p93, r=4, g=3, b=2, stretch="lin")

## 1995 ##
list95<-list.files(pattern="1995")
import95<-lapply(list95, raster)
p95t<-stack(import95)
p95<-crop(p95t, extent(431858.1, 445413, 4532960, 4552802))
writeRaster(p95, filename="p193r32_1995.grd", format="raster")
p95p<-plotRGB(p95, r=4, g=3, b=2, stretch="lin")

## 1996 ##
list96<-list.files(pattern="1996")
import96<-lapply(list96, raster)
p96t<-stack(import96)
p96<-crop(p96t, extent(431858.1, 445413, 4532960, 4552802))
writeRaster(p96, filename="p193r32_1996.grd", format="raster")
p96p<-plotRGB(p96, r=4, g=3, b=2, stretch="lin")

## 1997 ##
list97<-list.files(pattern="1997")
import97<-lapply(list97, raster)
p97t<-stack(import97)
p97<-crop(p97t, extent(431858.1, 445413, 4532960, 4552802))
writeRaster(p97, filename="p193r32_1997.grd", format="raster")
p97p<-plotRGB(p97, r=4, g=3, b=2, stretch="lin")

## 1999 ##
list99<-list.files(pattern="1999")
import99<-lapply(list99, raster)
p99t<-stack(import99)
p99<-crop(p99t, extent(431858.1, 445413, 4532960, 4552802))
writeRaster(p99, filename="p193r32_1999.grd", format="raster")
p99p<-plotRGB(p99, r=4, g=3, b=2, stretch="lin")

## 2000 ##
list00<-list.files(pattern="2000")
import00<-lapply(list00, raster)
p00t<-stack(import00)
p00<-crop(p00t, extent(431858.1, 445413, 4532960, 4552802))
writeRaster(p00, filename="p193r32_2000.grd", format="raster")
p00p<-plotRGB(p00, r=4, g=3, b=2, stretch="lin")

## 2001 ##
list01<-list.files(pattern="2001")
import01<-lapply(list01, raster)
p01t<-stack(import01)
p01<-crop(p01t, extent(431858.1, 445413, 4532960, 4552802))
writeRaster(p01, filename="p193r32_2001.grd", format="raster")
p01p<-plotRGB(p01, r=4, g=3, b=2, stretch="lin")

## 2002 ##
list02<-list.files(pattern="2002b")
import02<-lapply(list02, raster)
p02t<-stack(import02)
p02<-crop(p02t, extent(431858.1, 445413, 4532960, 4552802))
writeRaster(p02, filename="p193r32_2002.grd", format="raster")
p02p<-plotRGB(p02, r=4, g=3, b=2, stretch="lin")

## 2003 ##
list03<-list.files(pattern="2003")
import03<-lapply(list03, raster)
p03t<-stack(import03)
p03<-crop(p03t, extent(432846.3, 445918.7, 4534674, 4553130))
writeRaster(p03, filename="p194r31_2003.grd", format="raster")
p03p<-plotRGB(p03, r=4, g=3, b=2, stretch="lin")

## 2006 ##
list06<-list.files(pattern="2006")
import06<-lapply(list06, raster)
p06t<-stack(import06)
p06<-crop(p06t, extent(431858.1, 445413, 4532960, 4552802))
writeRaster(p06, filename="p193r32_2006.grd", format="raster")
p06p<-plotRGB(p06, r=4, g=3, b=2, stretch="lin")

## 2007 ##
list07<-list.files(pattern="2007")
import07<-lapply(list07, raster)
p07t<-stack(import07)
p07<-crop(p07t, extent(431858.1, 445413, 4532960, 4552802))
writeRaster(p07, filename="p193r32_2007.grd", format="raster")
p07p<-plotRGB(p07, r=4, g=3, b=2, stretch="lin")

## 2010 ##
list10<-list.files(pattern="2010")
import10<-lapply(list10, raster)
p10t<-stack(import10)
p10<-crop(p10t, extent(431858.1, 445413, 4532960, 4552802))
writeRaster(p10, filename="p193r32_2010.grd", format="raster")
p10p<-plotRGB(p10, r=4, g=3, b=2, stretch="lin")

## 2013 ##
list13<-list.files(pattern="2013")
import13<-lapply(list13, raster)
p13t<-stack(import13)
p13<-crop(p13t, extent(431858.1, 445413, 4532960, 4552802))
writeRaster(p13, filename="p193r32_2013.grd", format="raster")
p13p<-plotRGB(p13, r=4, g=3, b=2, stretch="lin")

## 2014 ##
list14<-list.files(pattern="2014")
import14<-lapply(list14, raster)
p14t<-stack(import14)
p14<-crop(p14t, extent(431858.1, 445413, 4532960, 4552802))
writeRaster(p14, filename="p193r32_2014.grd", format="raster")
p14p<-plotRGB(p14, r=4, g=3, b=2, stretch="lin")

## 2015 ##
list15<-list.files(pattern="2015")
import15<-lapply(list15, raster)
p15t<-stack(import15)
p15<-crop(p15t, extent(431858.1, 445413, 4532960, 4552802))
writeRaster(p15, filename="p193r32_2015.grd", format="raster")
p15p<-plotRGB(p15, r=4, g=3, b=2, stretch="lin")

## 2016 ##
list16<-list.files(pattern="2016")
import16<-lapply(list16, raster)
p16t<-stack(import16)
p16<-crop(p16t, extent(431858.1, 445413, 4532960, 4552802))
writeRaster(p16, filename="p193r32_2016.grd", format="raster")
p16p<-plotRGB(p16, r=4, g=3, b=2, stretch="lin")

## 2017 ##
list17<-list.files(pattern="2017")
import17<-lapply(list17, raster)
p17t<-stack(import17)
p17<-crop(p17t, extent(431858.1, 445413, 4532960, 4552802))
writeRaster(p17, filename="p193r32_2017.grd", format="raster")
p17p<-plotRGB(p17, r=4, g=3, b=2, stretch="lin")

## 2018 ##
list18<-list.files(pattern="2018")
import18<-lapply(list18, raster)
p18t<-stack(import18)
p18<-crop(p18t, extent(431858.1, 445413, 4532960, 4552802))
writeRaster(p18, filename="p193r32_2018.grd", format="raster")
p18p<-plotRGB(p18, r=4, g=3, b=2, stretch="lin")

## 2019 ##
list19<-list.files(pattern="2019")
import19<-lapply(list19, raster)
p19t<-stack(import19)
p19<-crop(p19t, extent(431858.1, 445413, 4532960, 4552802))
writeRaster(p19, filename="p193r32_2019.grd", format="raster")
p19p<-plotRGB(p19, r=4, g=3, b=2, stretch="lin")

## 2020 ##
list20<-list.files(pattern="2020")
import20<-lapply(list20, raster)
p20t<-stack(import20)
p20<-crop(p20t, extent(431858.1, 445413, 4532960, 4552802))
writeRaster(p20, filename="p193r32_2020.grd", format="raster")
p20p<-plotRGB(p20, r=4, g=3, b=2, stretch="lin")

## 2021 ##
list21<-list.files(pattern="2021")
import21<-lapply(list21, raster)
p21t<-stack(import21)
p21<-crop(p21t, extent(431858.1, 445413, 4532960, 4552802))
writeRaster(p21, filename="p193r32_2021.grd", format="raster")
p21p<-plotRGB(p21, r=4, g=3, b=2, stretch="lin")

# Elenco immagini 
# p84, p85, p87, p88, p89, p90, p91, p92, p93, p95, p96, p97, p99, p00, p01, p02, p03, p06, p07, p10, p13, p14, p15, p16, p17, p18, p19, p20, p21
# Elenco plot
# p84p, p85p, p87p, p88p, p89p, p90p, p91p, p92p, p93p, p95p, p96p, p97p, p99p, p00p, p01p, p02p, p03p, p06p, p07p, p10p, p13p, p14p, p15p, p16p, p17p, p18p, p19p, p20p, p21p

grid.arrange(p84p, p85p, p87p, p88p, p89p, p90p, p91p, p92p, p93p, p95p, p96p, p97p, p99p, p00p, p01p, p02p, p03p, p06p, p07p, p10p, p13p, p14p, p15p, p16p, p17p, p18p, p19p, p20p, p21p, nrow=6, ncol=6)


#a questo punto abbiamo le immagini composte dalle 7 bande Landsat dal 2013-2021

#plot dell'immagine e crop per avere lo zoom sull'Asinara
plotRGB(p193r32_2014, 4, 3, 2, stretch="lin") #immagine completa

#ora uso la funzione crop per tagliare l'immagine e fare lo zoom sull'area di interesse
#extent     : 425985, 449085, 4532895, 4557075  (xmin, xmax, ymin, ymax)
#extent     : 429435, 448155, 4531395, 4557645  (xmin, xmax, ymin, ymax)
p193r32_2014c<-crop(p193r32_2014, extent(425985, 449085, 4532895, 4557075))

plotRGB(p193r32_2014c, 5,3,2, stretch="lin")

