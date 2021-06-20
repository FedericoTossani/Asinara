#################
#### Asinara ####
#################

#######################################################
### Intro ###

# Lo scopo di questo progetto è quello di valutare l'eterogeneità vegetale
# del Parco Nazionale dell'Asinara. Il dataset è composto da 17 immagini Landsat
# che coprono un arco di tempo che va dal 1984 al 2020.
# L'idea di questo progetto è nata dalla curiosità di vedere come è cambiata
# la vegetazione dopo la chiusura del carcere (1998), perchè durante il 
# periodo di attività del carcere l'isola aveva una forte componente agricola.
# Le immagini satellitari derivano da Landsat 4, 5, 7, 8.

#######################################################
### Summary ###

# 1. Library & Working directory
# 2. Images
# 3. Where the magic begins
# 4. Results

#######################################################
## 1. Library & Working directory

require(raster)
require(rgdal)
require(RStoolbox)
require(rasterdiv)
require(rasterVis)
require(ggplot2)
require(gridExtra)
require(viridis)
require(purrr)
setwd("/Users/federicotossani/Asinara/L_image")
source("/Users/federicotossani/Asinara/spectralrao.r")

#######################################################
## 2. Images

### estensione ###
extnew<-extent(431858.1, 445713, 4532960, 4552802)

## 1984 ##
list84<-list.files(pattern="1984")
p84t<-lapply(list84, raster)
p84<- map(p84t, crop, extnew)

## 1985 ##
list85<-list.files(pattern="1985")
p85t<-lapply(list85, raster)
p85<- map(p85t, crop, extnew)

## 1987 ##
list87<-list.files(pattern="1987")
p87t<-lapply(list87, raster)
p87<- map(p87t, crop, extnew)

## 1988 ##
list88<-list.files(pattern="1988")
p88t<-lapply(list88, raster)
p88<- map(p88t, crop, extnew)

## 1991 ##
list91<-list.files(pattern="1991")
p91t<-lapply(list91, raster)
p91<- map(p91t, crop, extnew)

## 1992 ##
list92<-list.files(pattern="1992")
p92t<-lapply(list92, raster)
p92<- map(p92t, crop, extnew)
## 1995 ##
list95<-list.files(pattern="1995")
p95t<-lapply(list95, raster)
p95<- map(p95t, crop, extnew)

## 1996 ##
list96<-list.files(pattern="1996")
p96t<-lapply(list96, raster)
p96<- map(p96t, crop, extnew)

## 1997 ##
list97<-list.files(pattern="1997")
p97t<-lapply(list97, raster)
p97<- map(p97t, crop, extnew)

## 1999 ##
list99<-list.files(pattern="1999")
p99t<-lapply(list99, raster)
p99<- map(p99t, crop, extnew)

## 2000 ##
list00<-list.files(pattern="2000")
p00t<-lapply(list00, raster)
p00<- map(p00t, crop, extnew)

## 2002 ##
list02<-list.files(pattern="2002b")
p02t<-lapply(list02, raster)
p02<- map(p02t, crop, extnew)

## 2014 ##
list14<-list.files(pattern="2014")
p14t<-lapply(list14, raster)
p14<- map(p14t, crop, extnew)

## 2015 ##
list15<-list.files(pattern="2015")
p15t<-lapply(list15, raster)
p15<- map(p15t, crop, extnew)

## 2017 ##
list17<-list.files(pattern="2017")
p17t<-lapply(list17, raster)
p17<- map(p17t, crop, extnew)

## 2018 ##
list18<-list.files(pattern="2018")
p18t<-lapply(list18, raster)
p18<- map(p18t, crop, extnew)

## 2020 ##
list20<-list.files(pattern="2020")
p20t<-lapply(list20, raster)
p20<- map(p20t, crop, extnew)

## Import with brick function
p84<-brick("Asi_p193r32_1984.grd")
p85<-brick("Asi_p193r32_1985.grd")
p87<-brick("Asi_p193r32_1987.grd")
p88<-brick("Asi_p193r32_1988.grd")
p91<-brick("Asi_p193r32_1991.grd")
p92<-brick("Asi_p193r32_1992.grd")
p95<-brick("Asi_p193r32_1995.grd")
p96<-brick("Asi_p193r32_1996.grd")
p97<-brick("Asi_p193r32_1997.grd")
p99<-brick("Asi_p193r32_1999.grd")
p00<-brick("Asi_p193r32_2000.grd")
p02<-brick("Asi_p193r32_2002.grd")
p14<-brick("Asi_p193r32_2014.grd")
p15<-brick("Asi_p193r32_2015.grd")
p17<-brick("Asi_p193r32_2017.grd")
p18<-brick("Asi_p193r32_2018.grd")
p20<-brick("Asi_p193r32_2020.grd")

#######################################################
# 3. Where the magic begins
