#################
#### Asinara ####
#################

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
## 3.1 NDVI
# first of all, I will calculate the NDVI for each image so I can use 
# this single band product for the calculation of Rao's Q index.

nir84<-p84$p193r32_1984_SR_B4
nir85<-p85$p193r32_1985_SR_B4
nir87<-p87$p193r32_1987_SR_B4
nir88<-p88$p193r32_1988_SR_B4
nir91<-p91$p193r32_1991_SR_B4
nir92<-p92$p193r32_1992_SR_B4
nir95<-p95$p193r32_1995_SR_B4
nir96<-p96$p193r32_1996_SR_B4
nir97<-p97$p193r32_1997_SR_B4
nir99<-p99$p193r32_1999_SR_B4
nir00<-p00$p193r32_2000_SR_B4
nir02<-p02$p193r32_2002b_SR_B4
nir14<-p14$p193r32_2014_SR_B4
nir15<-p15$p193r32_2015_SR_B4
nir17<-p17$p193r32_2017_SR_B4
nir18<-p18$p193r32_2018_SR_B4
nir20<-p20$p193r32_2020_SR_B4

red84	<-	p84$p193r32_1984_SR_B3
red85	<-	p85$p193r32_1985_SR_B3
red87	<-	p87$p193r32_1987_SR_B3
red88	<-	p88$p193r32_1988_SR_B3
red91	<-	p91$p193r32_1991_SR_B3
red92	<-	p92$p193r32_1992_SR_B3
red95	<-	p95$p193r32_1995_SR_B3
red96	<-	p96$p193r32_1996_SR_B3
red97	<-	p97$p193r32_1997_SR_B3
red99	<-	p99$p193r32_1999_SR_B3
red00	<-	p00$p193r32_2000_SR_B3
red02	<-	p02$p193r32_2002b_SR_B3
red14	<-	p14$p193r32_2014_SR_B3
red15	<-	p15$p193r32_2015_SR_B3
red17	<-	p17$p193r32_2017_SR_B3
red18	<-	p18$p193r32_2018_SR_B3
red20	<-	p20$p193r32_2020_SR_B3

ndvi84	<-	(nir84-red84)/(nir84+ red84)
ndvi85	<-	(nir85-red85)/(nir85+	red85)
ndvi87	<-	(nir87-red87)/(nir87+ red87)
ndvi88	<-	(nir88-red88)/(nir88+	red88)
ndvi91	<-	(nir91-red91)/(nir91+	red91)
ndvi92	<-	(nir92-red92)/(nir92+ red92)
ndvi95	<-	(nir95-red95)/(nir95+	red95)
ndvi96	<-	(nir96-red96)/(nir96+	red96)
ndvi97	<-	(nir97-red97)/(nir97+	red97)
ndvi99	<-	(nir99-red99)/(nir99+	red99)
ndvi00	<-	(nir00-red00)/(nir00+	red00)
ndvi02	<-	(nir02-red02)/(nir02+	red02)
ndvi14	<-	(nir14-red14)/(nir14+	red14)
ndvi15	<-	(nir15-red15)/(nir15+	red15)
ndvi17	<-	(nir17-red17)/(nir17+ red17)
ndvi18	<-	(nir18-red18)/(nir18+	red18)
ndvi20	<-	(nir20-red20)/(nir20+	red20)

cl<-colorRampPalette(c("black", "purple", "dark green", "yellow", "white")) (200)
par(mfrow=c(3, 6))
plot(ndvi84, col=cl)
plot(ndvi85, col=cl)
plot(ndvi87, col=cl)
plot(ndvi88, col=cl)
plot(ndvi91, col=cl)
plot(ndvi92, col=cl)
plot(ndvi95, col=cl)
plot(ndvi96, col=cl)
plot(ndvi97, col=cl)
plot(ndvi99, col=cl)
plot(ndvi00, col=cl)
plot(ndvi02, col=cl)
plot(ndvi14, col=cl)
plot(ndvi15, col=cl)
plot(ndvi17, col=cl)
plot(ndvi18, col=cl)
plot(ndvi20, col=cl)

par(mfrow=c(2,2))
levelplot(rao84)
levelplot(rao91)
levelplot(rao02)
levelplot(rao20)



# Rao's Q index
rao84<-spectralrao(p84, mode="multidimension", distance_m="euclidean", window=3, shannon=F)
writeRaster(rao84, filename="Rao_84.grd", format="raster")
rao85<-spectralrao(p85, mode="multidimension", distance_m="euclidean", window=3, shannon=F)
writeRaster(rao85, filename="Rao_85.grd", format="raster")
rao87<-spectralrao(p87, mode="multidimension", distance_m="euclidean", window=3, shannon=F)
writeRaster(rao87, filename="Rao_87.grd", format="raster")
rao88<-spectralrao(p88, mode="multidimension", distance_m="euclidean", window=3, shannon=F)
writeRaster(rao88, filename="Rao_88.grd", format="raster")
rao91<-spectralrao(p91, mode="multidimension", distance_m="euclidean", window=3, shannon=F)
writeRaster(rao91, filename="Rao_91.grd", format="raster")
rao92<-spectralrao(p92, mode="multidimension", distance_m="euclidean", window=3, shannon=F)
writeRaster(rao92, filename="Rao_92.grd", format="raster")
rao95<-spectralrao(p95, mode="multidimension", distance_m="euclidean", window=3, shannon=F)
writeRaster(rao95, filename="Rao_95.grd", format="raster")
rao96<-spectralrao(p96, mode="multidimension", distance_m="euclidean", window=3, shannon=F)
writeRaster(rao96, filename="Rao_96.grd", format="raster")
rao97<-spectralrao(p97, mode="multidimension", distance_m="euclidean", window=3, shannon=F)
writeRaster(rao97, filename="Rao_97.grd", format="raster")
rao99<-spectralrao(p99, mode="multidimension", distance_m="euclidean", window=3, shannon=F)
writeRaster(rao99, filename="Rao_99.grd", format="raster")
rao00<-spectralrao(p00, mode="multidimension", distance_m="euclidean", window=3, shannon=F)
writeRaster(rao00, filename="Rao_00.grd", format="raster")
rao02<-spectralrao(p02, mode="multidimension", distance_m="euclidean", window=3, shannon=F)
writeRaster(rao02, filename="Rao_02.grd", format="raster")
rao14<-spectralrao(p14, mode="multidimension", distance_m="euclidean", window=3, shannon=F)
writeRaster(rao14, filename="Rao_14.grd", format="raster")
rao15<-spectralrao(p15, mode="multidimension", distance_m="euclidean", window=3, shannon=F)
writeRaster(rao15, filename="Rao_15.grd", format="raster")
rao17<-spectralrao(p17, mode="multidimension", distance_m="euclidean", window=3, shannon=F)
writeRaster(rao17, filename="Rao_17.grd", format="raster")
rao18<-spectralrao(p18, mode="multidimension", distance_m="euclidean", window=3, shannon=F)
writeRaster(rao18, filename="Rao_18.grd", format="raster")
rao20<-spectralrao(p20, mode="multidimension", distance_m="euclidean", window=3, shannon=F)
writeRaster(rao20, filename="Rao_20.grd", format="raster")

writeRaster(rao84, filename="Rao_84.grd", format="raster")
writeRaster(rao91, filename="Rao_91.grd", format="raster")
writeRaster(rao02, filename="Rao_02.grd", format="raster")
writeRaster(rao20, filename="Rao_20.grd", format="raster")


p1<-ggplot()+
geom_raster(rao84, mapping=aes(x = x, y = y, fill = layer))+
scale_fill_viridis()+
ggtitle("Rao's Q value in Asinara 1984")

p2<-ggplot()+
geom_raster(rao91, mapping=aes(x = x, y = y, fill = layer))+
scale_fill_viridis()+
ggtitle("Rao's Q value in Asinara 1991")

p3<-ggplot()+
geom_raster(rao02, mapping=aes(x = x, y = y, fill = layer))+
scale_fill_viridis()+
ggtitle("Rao's Q value in Asinara 2002")

p4<-ggplot()+
geom_raster(rao20, mapping=aes(x = x, y = y, fill = layer))+
scale_fill_viridis()+
ggtitle("Rao's Q value in Asinara 2020")

grid.arrange(p1, p2, p3, p4, nrow=2, ncol=2)

grid.arrange(p1, p4, nrow=1, ncol=2)
p1<-ggplot()+
geom_raster(rao84, mapping=aes(x = x, y = y, fill = layer))+
scale_fill_viridis()+
ggtitle("Rao's Q value in Asinara 1984")
p4<-ggplot()+
geom_raster(rao20, mapping=aes(x = x, y = y, fill = layer))+
scale_fill_viridis()+
ggtitle("Rao's Q value in Asinara 2020")



ndvi84m<-raster::as.matrix(ndvi84)
rao84<-spectralrao(ndvi84m, mode="classic", distance_m="euclidean", window=3, shannon=FALSE)

#######################################################
# Have a seat and enjoy some good music (a couple of days will be enough)
#######################################################
# Good, now burn you pc in the hell's fire and buy a new one with a proper processor
#######################################################

# 4. Results

## DA FARE

#asilist<-list.files(pattern="p193r32")
#asimp<-lapply(asilist, raster)
#asinara<-crop(asimp, extent(431858.1, 445713, 4532960, 4552802))
#asinara<-lapply(asimp, crop(asimp, extent(431858.1, 445713, 4532960, 4552802)))



#asirao<-spectralrao(import84, distance_m="euclidean", window=3, shannon=FALSE)



#asipca<-lapply(asimp, rasterPCA)

#asipc1<-asipca$map$PC1

#plot(asipc1)
